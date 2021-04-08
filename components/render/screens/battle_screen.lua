BattleScreen = Screen:extend()

function BattleScreen:new(config)
	BattleScreen.super.new(self, config)
	
	self.board = Board(config.board.size)
	self.battle = Battle(config.players.first, config.players.second)
end

function BattleScreen:init(basePath)
	self.board:init()
	self.battle:init()
end

function BattleScreen:render(game)
	self:renderBackground(game)
	self.board:render(game)	
	self.battle:renderMagic(game)
	self.battle:frameCurrentPlayer()
	self.battle:showPlayersInfo()
	self:renderTip(game)
	
	if self.board.theEndFlag then
		self:renderTheEnd(game)
	end
end