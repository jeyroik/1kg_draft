local PlayerLayerData = require "components/screens/player/data"

PlayerScreen = Screen:extend()

function PlayerScreen:new(config)
	config.initializer = config.initializer or 'components/screens/player/initializer'
	PlayerScreen.super.new(self, config)

	self:setDataLayer(PlayerLayerData(config))
end

return PlayerScreen