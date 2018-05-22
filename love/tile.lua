tile =
{
    new =  function (sprite, x, y)
        local self = {}
        self.sprite = sprite
        self.x = x
        self.y = y
        self.quad = love.graphics.newQuad (self.x, self.y, self.sprite.width, self.sprite.height, self.sprite.dimensions[1], self.sprite.dimensions[2])
        function self:draw (x, y)
            love.graphics.draw (self.sprite.image, self.quad, x, y)
        end
        return self
    end
}
