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
function Image:draw(dx, dy, radian, sx, sy)
	dx     = dx     + self.x
	dy     = dy     + self.y
	radian = radian * self.radian
	sx     = sx     * self.sx
	sy     = sy     * self.sy

	love.graphics.draw(self.source, dx, dy, radian, sx, sy)
end