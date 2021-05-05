local BattleLayerData = require "components/screens/battle/data"
local Screen = require "components/screens/screen"

BattleScreen = Screen:extend()

function BattleScreen:new(config)
	config.initializer = config.initializer or 'components/screens/battle/initializer'
	BattleScreen.super.new(self, config)

	self:setDataLayer(BattleLayerData(config))
end

function BattleScreen:getCurrentPlayer()
	return self.layers.data:getCurrentPlayer()
end

function BattleScreen:getNextPlayer()
	return self.layers.data:getNextPlayer()
end

return BattleScreen