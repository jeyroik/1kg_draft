Image = Source:extend()

-- @param image source
-- @return void
function Image:new(config)
	config.initializer = 'components/sources/initializers/image'

	Image.super.new(self, config)

	self:setSize(self.source:getWidth(), self.source:getHeight())
end

-- @param number dx delta for the x
-- @param number dy delta for the y
-- @return void
function Image:render(dx, dy, radian, sx, sy)
	dx = dx or 0
	dy = dy or 0
	radian = radian or self.radian
	sx = sx or self.sx
	sy = sy or self.sy

	love.graphics.draw(self.source, self.x+dx, self.y+dy, radian, sx, sy)
end