plane =
{
	new = function (x,y)

		local self = {}

		self.x = x
		self.y = y
		self.width = nil
		self.height = nil
		self.speed = 150
		self.timer = 0.2
		self.ready = true

		function self:cooldown (delta)
			self.timer = self.timer - (1*delta)
			if self.timer<0 then
				self.ready = true
			end
		end

		function self:fire (delta)
			self.ready = false;
			self.timer = 0.2;
			return bullet.new (self.x+self.width/2,self.y);
		end

		function self:move (direction, delta)
			if direction=='left' and self.x>0 then
				self.x = self.x - (self.speed*delta)
			end
			if direction=='right' and self.x<system.screen.getWidth()-self.width then
				self.x = self.x + (self.speed*delta)
			end
		end

		return self
	end
}
