Icon = Source:extend()

-- @param Image image
-- @param Text text
-- @return void
function Icon:new(config)
	self.image = {}
	self.text = {}

	config.initializer = 'components/sources/initializers/icon'

	Icon.super.new(self, config)
end

-- @param number dx delta for the x
-- @param number dy delta for the y
-- @return void
function Icon:draw(dx, dy, radian, sx, sy)
	self.image:draw(dx, dy, radian, sx, sy)
	self.text:draw(dx+self.image.x, dy+self.image.y, radian, sx, sy)
end