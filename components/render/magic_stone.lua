MagicStone = Render:extend{}
MagicStone:implement(Uuid)

function MagicStone:new(config)
	self.row = 1
	self.column = 1
	self.deltaX = 570
	self.deltaY = 0
	self.size = 122
	self.volume = 1
	self.state = 0
	self.id = self:getId()

	MagicStone.super.new(self, config)

	self.x = self.column * self.size + self.deltaX
	self.y = self.row * self.size
end

function MagicStone:render(game, dx, dy)
	love.graphics.draw(game.assets.images.gems[self:getMask()], self.x, self.y, 0, 2,2)
end

function MagicStone:update(dt, game)
	local nextRow = self.row
	local nextColumn = self.column

	game.screens.battle.board.cells[self.row][self.column] = MagicStone({row = self.row, column = self.column})
	
	if game.screens.battle.board.gravity == 'down' then
		nextRow = self.row == game.screens.battle.board.size and self.row or self.row + 1
		if (self.row ~= nextRow and game.screens.battle.board.cells[nextRow][nextColumn].volume > 1) or self.row == 5 then
			self.state = 1
		end
		
	elseif game.screens.battle.board.gravity == 'up' then
		nextRow = self.row == 1 and 1 or self.row - 1
		if (self.row ~= nextRow and game.screens.battle.board.cells[nextRow][nextColumn].volume > 1) or self.row == 1 then
			self.state = 1
		end
		
	elseif game.screens.battle.board.gravity == 'right' then
		nextColumn = self.column == game.screens.battle.board.size and self.column or self.column + 1
		if (self.column ~= nextColumn and game.screens.battle.board.cells[nextRow][nextColumn].volume > 1) or self.column == 5 then
			self.state = 1
		end
		
	elseif game.screens.battle.board.gravity == 'left' then
		nextColumn = self.column == 1 and 1 or self.column - 1
		if (self.column ~= nextColumn and game.screens.battle.board.cells[nextRow][nextColumn].volume > 1) or self.column == 1 then
			self.state = 1
		end
	else
	end

	if game.screens.battle.board.cells[nextRow][nextColumn].volume > 1 then
		nextRow = self.row
		nextColumn = self.column
	end
	
	self.row = nextRow
	self.column = nextColumn
	
	self.x = self.column * self.size + self.deltaX
	self.y = self.row * self.size + self.deltaY
	
	game.screens.battle.board.cells[self.row][self.column] = self
end

function MagicStone:getMask()
	return 'c' .. self.volume
end

function MagicStone:upgrade()
	self.volume = self.volume * 2
end

function MagicStone:applyDeathMagic(deathPerc, ultraDeathPerc)
	deathPerc = deathPerc or 10
	ultraDeathPerc = ultraDeathPerc or 20
	
	if love.math.random(1,10) == 1 then
		self.volume = 2048
	end
	
	if love.math.random(1,20) == 1 then
		self.volume = 4096
	end
end