require "components/render/screens/battle/battle_layer_view_background"
require "components/render/screens/battle/battle_layer_data"
require "components/render/screens/battle/scenes/fight_start"
require "components/render/screens/battle/scenes/fight"
require "components/render/screens/battle/scenes/fight_the_end"

BattleScreen = Screen:extend()

function BattleScreen:new(config)
	BattleScreen.super.new(self, config)

	self.scenes = {
		fight_start = SceneFightStart(),
		fight = SceneFight(),
		fight_the_end = SceneFightTheEnd()
	}

	self:addViewLayers(
			{ BattleLayerViewBackground( {image = 'background'} ) },
			'scene_before'
	)
	self:setDataLayer(BattleLayerData(config))
end

function BattleScreen:getCurrentPlayer()
	return self.layers.data:getCurrentPlayer()
end

function BattleScreen:getNextPlayer()
	return self.layers.data:getNextPlayer()
end