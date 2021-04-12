Text = Render:extend()

-- @param string body
-- @param number x
-- @param number y
-- @return void
function Text:new(config)
	self.body = ''

	Text.super.new(self, config)
end

-- @param number dx delta for the x
-- @param number dy delta for the y
-- @return void
function Text:render(dx, dy)
	love.graphics.print(self.body, dx + self.x, dy + self.y, self.radian, self.sx, self.sy)
end