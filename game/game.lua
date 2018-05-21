game =
{
    player = nil,
    bullets = {},
    init = function ()
        game.player = plane.new (200, 710);
    end,
    update = function (delta, input)

        if not game.player.ready then
            game.player:cooldown (delta)
        end

        for i, bullet in pairs(game.bullets) do
            bullet:move (delta);
            if bullet.y < 0 then
                table.remove(game.bullets, i)
            end
        end

        if input.fire and game.player.ready then
            table.insert(game.bullets, game.player:fire())
        end

        if input.left then
            game.player:move ('left', delta);
        end

        if input.right then
            game.player:move ('right', delta)
        end

    end
}
