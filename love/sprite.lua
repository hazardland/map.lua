sprite =
{
    new = function (path, width, height)
        local self = {}
        self.width = width
        self.height = height
        self.image = love.graphics.newImage (path)
        self.image:setFilter("nearest", "nearest")
        self.dimensions = {self.image:getDimensions()}
        self.tiles = {}
        function self:tile (name, row, cell)
            self.tiles[name] = tile.new (self, (cell-1)*self.width, (row-1)*self.height)
        end
        return self
    end
}
