bullet =
{
    new = function (x,y)
        self = {}

        self.x = x
        self.y = y
        self.speed = 250

        function self:move (delta)
            self.y = self.y - (self.speed*delta)
        end

        return self
    end
}
