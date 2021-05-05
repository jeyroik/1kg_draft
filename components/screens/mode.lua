local ModeLayerData = require "components/screens/mode/data"
local Screen = require "components/screens/screen"

ModeScreen = Screen:extend()

function ModeScreen:new(config)
	config.initializer = config.initializer or 'components/screens/mode/initializer'
	ModeScreen.super.new(self, config)

	self:setDataLayer(ModeLayerData(config))
end

return ModeScreen