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
function Image:draw()
	love.graphics.draw(self.source, self.x, self.y, self.radian, self.sx, self.sy)
end