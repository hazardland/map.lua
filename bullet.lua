function Bullet (x, y)
	local object = {
		x = x,
		y = y,
		speed = 250,
		move = function(self, delta)
			self.y = self.y-(self.speed*delta)
		end
	}
	return object
end