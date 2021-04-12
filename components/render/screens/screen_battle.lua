require "components/render/screens/battle/battle_layer_data"
require "components/render/screens/battle/scenes/fight_before"
require "components/render/screens/battle/scenes/fight"
require "components/render/screens/battle/scenes/fight_after"

BattleScreen = Screen:extend()

function BattleScreen:new(config)
	BattleScreen.super.new(self, config)

	self.scene = 'fight_before'
	self.scenes = {
		fight_before = SceneFightBefore(),
		fight = SceneFight(),
		fight_the_end = SceneFightAfter()
	}

	self:setDataLayer(BattleLayerData(config))
end

function BattleScreen:getCurrentPlayer()
	return self.layers.data:getCurrentPlayer()
end

function BattleScreen:getNextPlayer()
	return self.layers.data:getNextPlayer()
end