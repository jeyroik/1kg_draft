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
function Text:draw()
	love.graphics.draw(self.source, self.x, self.y, self.radian, self.sx, self.sy)
end

function Text:setBody(text)
	self.body = text
	self.source:set(text)
end