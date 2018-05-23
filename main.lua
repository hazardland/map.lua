require ('love/system')
require ('love/sprite')
require ('love/tile')
require ('util/debug')

terrain = nil

map =
{
    width = 20,
    height = 20,
    tile =
    {
        width = 32,
        height = 32
    },
    view =
    {
        x = 1,
        y = 1,
        width = 16,
        height = 10
    },
    zoom = 
    {
        x = 1,
        y = 1
    },
    batch = nil,
    data =
    {
       {3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 0, 2, 2, 2, 0, 3, 0, 3, 0, 1, 1, 1, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 2, 0, 2, 0, 3, 0, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 1, 2, 2, 2, 2, 0, 0, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0},
       {0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
       {0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
       {0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 2, 2, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
    new = function ()
        map.batch = love.graphics.newSpriteBatch(terrain.image, map.view.width * map.view.height) 
    end,
    update = function ()
        map.batch:clear()
        for y=0, map.view.height do
            for x=0, map.view.width do
                map.batch:add (
                    terrain.tiles [map.data[y+math.floor(map.view.y)][x+math.floor(map.view.x)]].quad,
                    x*map.tile.width,y*map.tile.height
                    )
            end
        end
        map.batch:flush()
    end,
    move = function (x, y)
        old = {x=map.view.x, y=map.view.y} 
        map.view.x = math.max(math.min(map.view.x + x, map.width - map.view.width), 1)
        map.view.y = math.max(math.min(map.view.y + y, map.height - map.view.height), 1)
        -- only update if we actually moved
        if math.floor(map.view.x) ~= math.floor(old.x) or math.floor(map.view.y) ~= math.floor(old.y) then
            map.update()
        end
    end
}

function love.load()
    terrain = sprite.new ('assets/terrain.png', 32, 32)
    terrain:tile (0,6,1)
    terrain:tile (1,6,4)
    terrain:tile (2,6,8)
    terrain:tile (3,6,12)
    map.new()
    map.update()
end

function love.draw(delta)

  love.graphics.draw(
    map.batch,
    math.floor(-map.zoom.x*(map.view.x%1)*map.tile.width), 
    math.floor(-map.zoom.y*(map.view.y%1)*map.tile.height),
    0, 
    map.zoom.x, 
    map.zoom.y
    )
  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)

end

function love.update(delta)

	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
    if love.keyboard.isDown("up")  then
        map.move(0, -0.2*map.tile.height*delta)
    end
    if love.keyboard.isDown("down")  then
        map.move(0, 0.2*map.tile.height*delta)
    end
    if love.keyboard.isDown("left")  then
        map.move(-0.2*map.tile.width*delta, 0)
    end
    if love.keyboard.isDown("right")  then
        map.move(0.2*map.tile.width*delta, 0)
    end
end
