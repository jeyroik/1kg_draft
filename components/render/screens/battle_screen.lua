BattleScreen = Screen:extend()

function BattleScreen:new(config)
	self.cfg_battle = {}
	self.cfg_board = {}

	BattleScreen.super.new(self, config)

	self.battle = Battle(self.cfg_battle)
	self.board = Board(self.cfg_board)
end

function BattleScreen:init()
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