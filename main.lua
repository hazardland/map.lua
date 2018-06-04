require ('love/system')
require ('love/sprite')
require ('love/tile')
require ('love/map/orthogonal')
require ('util/debug')
require ('game/sheep')


terrain = nil
sheep1 = nil


function love.load()
    
    terrain = sprite.new ('assets/terrain.png', 32, 32)
    terrain:tile (0,6,1)
    terrain:tile (1,6,4)
    terrain:tile (2,6,8)
    terrain:tile (3,6,12)
    
    map.new()
    map.update()

    sheep1 = sheep.new (1,1,map)
end

function love.draw(delta)
    map.draw ()

    sheep1:draw ()

    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
    love.graphics.print("X: "..map.view.x*32+map.view.width*32, 10, 50)
    love.graphics.print("Y: "..map.view.y*32+map.view.height*32, 10, 35)
end

function love.update(delta)

    sheep1:update(delta)

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
