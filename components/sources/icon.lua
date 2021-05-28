local Source = require 'components/sources/source'

Icon = Source:extend()

-- @param Image image
-- @param Text text
-- @return void
function Icon:new(config)
	self.image = {}
	self.text = {}

	config.initializer = config.initializer or 'components/sources/initializers/icon'

	Icon.super.new(self, config)
end

-- @return void
function Icon:draw()
	self.image:draw()
	self.text:draw()
end

return Icon