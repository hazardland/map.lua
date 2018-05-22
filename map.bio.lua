require ('love/system')
require ('love/sprite')
require ('love/tile')
require ('util/debug')

terrain = nil

map =
{
	speed = 0.2,
	scroll = 
	{
		up = 0,
		down = 0,
		left = 0,
		right = 0
	},
    scale = 1,
    view =
    {
        x = 0,
        y = 0,
        width = 16,
        height = 10
    },
    tile =
    {
        width = 32,
        height = 32
    },
    width = 20,
    height = 20,
    data =
    {
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 0, 2, 2, 2, 0, 3, 0, 3, 0, 1, 1, 1, 0, 0, 0, 0, 0},
       {0, 1, 0, 0, 2, 0, 2, 0, 3, 0, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 1, 0, 2, 2, 2, 0, 0, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
       {0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
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
    }
}

function love.load()
    terrain = sprite.new ('assets/terrain.png', 32, 32)
    terrain:tile (0,6,1)
    terrain:tile (1,6,4)
    terrain:tile (2,6,8)
    terrain:tile (3,6,12)
end

function love.draw(delta)
--[[    terrain.tiles[0]:draw (0,0)
    terrain.tiles[1]:draw (32,0)
    terrain.tiles[2]:draw (64,0)
    terrain.tiles[3]:draw (96,0)--]]

	-- love.graphics.scale(0.5, 0.5)


	for y=1, map.view.height do
		for x=1, map.view.width do
	    	terrain.tiles [map.data[y+map.view.y][x+map.view.x]]:draw (((x-1)*map.tile.width)+0, ((y-1)*map.tile.height)+0)
	  	end
	end

end

function love.update(delta)

	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
	if love.keyboard.isDown('up') then
		map.view.y = map.view.y-1
		if map.view.y < 0 then map.view.y = 0; end
	end
	
	map.scroll.down = map.scroll.down+(5*delta)
	if map.scroll.down>1 then 
		map.scroll.down = map.scroll.down-1
		if love.keyboard.isDown('down') then
			map.view.y = map.view.y+1
			if map.view.y > map.height-map.view.height then map.view.y = map.height-map.view.height; end
		end
	end

	if love.keyboard.isDown('left') then
		map.view.x = math.max(map.view.x-1, 0)
	end
	if love.keyboard.isDown('right') then
		map.view.x = math.min(map.view.x+1, map.width-map.view.width)
	end
	if map.scroll.down>0 then
		love.graphics.translate(0, -map.scroll.down)
	end	
end
