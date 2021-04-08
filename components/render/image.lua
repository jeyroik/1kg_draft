Image = Render:extend()

-- @param image source
-- @return void
function Image:new(config)
	self.source = {}
	Image.super.new(self, config)
	self:setSize(self.source:getWidth(), self.source:getHeight())
end

-- @param number dx delta for the x
-- @param number dy delta for the y
-- @return void
function Image:render(dx, dy)
	love.graphics.draw(self.source, self.x+dx, self.y+dy, self.radian, self.sx, self.sy)
end