require ('player');
require ('bullet');

images = {}

player = Player (200, 710);
bullets = {}


function love.load()
    images['player'] = love.graphics.newImage ('assets/plane.png');
    player.width = images['player']:getWidth();

    images['bullet'] = love.graphics.newImage ('assets/bullet.png');
end

function love.draw(dt)
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(images['bullet'], bullet.x, bullet.y)
	end

    love.graphics.draw (images['player'], player.x, player.y)
end


function love.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if not player.ready then
		player:cooldown (dt)
	end

	for i, bullet in ipairs(bullets) do
		bullet:move (dt);
		if bullet.y < 0 then 
			table.remove(bullets, i)
		end
	end

	if love.keyboard.isDown('space') and player.ready then
		table.insert(bullets, player:fire())
	end

	if love.keyboard.isDown('left','a') then
		player:move ('left', dt);
	elseif love.keyboard.isDown('right','d') then
		player:move ('right', dt)
	end

end