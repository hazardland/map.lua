require ('love/system');

require ('game/plane');
require ('game/bullet');
require ('game/game');

images = {}

game.init()

function love.load()

    images['player'] = love.graphics.newImage ('assets/plane.png');
    game.player.width = images['player']:getWidth();
    game.player.height = images['player']:getHeight();

    images['bullet'] = love.graphics.newImage ('assets/bullet.png');
end

function love.draw(delta)
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)

	for i, bullet in pairs(game.bullets) do
		love.graphics.draw(images['bullet'], bullet.x, bullet.y)
	end

    love.graphics.draw (images['player'], game.player.x, game.player.y)
end


function love.update(delta)
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	local input = {}

    if love.keyboard.isDown('space') then
        input.fire = true
	end

	if love.keyboard.isDown('left','a') then
		input.left = true
	end

	if love.keyboard.isDown('right','d') then
		input.right = true
	end

	game.update (delta, input)


end
