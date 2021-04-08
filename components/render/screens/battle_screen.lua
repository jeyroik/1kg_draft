BattleScreen = Screen:extend()

function BattleScreen:new(config)
	BattleScreen.super.new(self, config)

	self:addViewLayers({
		BattleLayerViewBackground(),
		BattleLayerViewBoard(),
		BattleLayerViewPlayers()
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

function BattleScreen:render(game)

	self:renderTip(game)
	
	if self.board.theEndFlag then
		self:renderTheEnd(game)
	end
end