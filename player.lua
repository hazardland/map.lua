function Player (x,y)
	local object = {
		-- position
		x = x,
		y = y,
		-- dimension
		width = nil,
		height = nil,
		speed = 150,
		-- fire
		timer = 0.2,
		ready = true,
		-- check cooldown and set ready to true if time
		cooldown = function (self, delta)
			self.timer = self.timer - (1*delta)
			if self.timer<0 then
				self.ready = true
			end
		end,
		-- fire bullet
		fire = function (self)
			self.ready = false;
			self.timer = 0.2;
			return Bullet (self.x+self.width/2,self.y);
		end,
		-- move
		move = function (self, direction, delta)
			if direction=='left' and self.x>0 then
				self.x = self.x - (self.speed*delta)
			end
			if direction=='right' and self.x<love.graphics.getWidth()-self.width then
				self.x = self.x + (self.speed*delta)
			end
		end
	}
	return object;
end