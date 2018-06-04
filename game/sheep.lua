sheep =
{
	new = function (x, y, map)
		local self = {}
		self.map = map
		self.sprite = sprite.new ('assets/sheep_walk.png', 128, 128)
		self.sprite:tile (0,4,1)
		self.x = x;
		self.y = y;
		function self:draw ()
			self.sprite.tiles[0]:draw (self.map.x(self.x), self.map.y(self.y))
		end
		function self:update (delta)
			self.x = self.x+100*delta
			print ("sheep "..math.floor(self.x))
		end
		return self
	end
}