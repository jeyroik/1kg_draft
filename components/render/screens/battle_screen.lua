require "components/render/screens/battle/battle_layer_view_background"
require "components/render/screens/battle/battle_layer_view_board"
require "components/render/screens/battle/battle_layer_view_players"
require "components/render/screens/battle/battle_layer_view_the_end"
require "components/render/screens/battle/battle_layer_data"

BattleScreen = Screen:extend()

function BattleScreen:new(config)
	BattleScreen.super.new(self, config)

	self:addViewLayers({
		BattleLayerViewBackground(),
		BattleLayerViewBoard(),
		BattleLayerViewPlayers(),
		BattleLayerViewTheEnd()
	})
	self:setDataLayer(BattleLayerData(config))
end

function BattleScreen:init()
	self.layers.data:init()
end

function BattleScreen:getCurrentPlayer()
	return self.layers.data:getCurrentPlayer()
end

function BattleScreen:getNextPlayer()
	return self.layers.data:getNextPlayer()
end