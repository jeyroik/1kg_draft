Text = Source:extend()

-- @param string body
-- @param number x
-- @param number y
-- @return void
function Text:new(config)
	self.body = ''

	config.source_type = 'text'

	Text.super.new(self, config)

	self:setSize(self.source:getWidth(), self.source:getHeight())
end

-- @param number dx delta for the x
-- @param number dy delta for the y
-- @return void
function Text:render(dx, dy, radian, sx, sy)
	dx = dx or 0
	dy = dy or 0
	radian = radian or 0
	sx = sx or self.sx
	sy = sy or self.sy

	love.graphics.draw(self.source, dx + self.x, dy + self.y, radian, sx, sy)
end