Text = Source:extend()

-- @param string body
-- @param number x
-- @param number y
-- @return void
function Text:new(config)
	self.body = ''

	config.initializer = config.initializer or 'components/sources/initializers/text'

	Text.super.new(self, config)

	self.x = math.floor(self.x)
	self.y = math.floor(self.y)

	self:setSize(self.source:getWidth(), self.source:getHeight())
end

-- @param number dx delta for the x
-- @param number dy delta for the y
-- @return void
function Text:draw(dx, dy, radian, sx, sy)
	dx     = dx     + self.x
	dy     = dy     + self.y
	radian = radian * self.radian
	sx     = sx     * self.sx
	sy     = sy     * self.sy

	love.graphics.draw(self.source, dx, dy, radian, sx, sy)
end

function Text:setBody(text)
	self.body = text
	self.source:set(text)
end