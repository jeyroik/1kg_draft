require "components/render/magic_stone"

Board = Render:extend()

-- @param number size
-- @return void
function Board:new(size)
	self.size = size or 5
	self.cells = {}
	self.gravity = 'none'
	self.existed = 0
	self.deathPerc = 10
	self.ultraDeathPerc = 20
	self.theEndFlag = false
end

-- @param number dx delta for the x
-- @param number dy delta for the y
-- @return void
function Board:render(game, dx, dy)
	for row, columns in pairs(self.cells) do
		for column,stone in pairs(columns) do
			if stone.volume > -1 then
				if game.assets.images.gems[stone:getMask()] then
					stone:render(game, dx, dy)
				end
			end
		end
	end
end

function Board:init()
	for i=1,self.size do
		self.cells[i] = {}
		
		for j=1,self.size do
			local stone = MagicStone(i, j, 'c1')
			
			if love.math.random(1,8) == 3 then
				stone.volume = love.math.random(1,9) == 3 and 4 or 2
				stone:applyDeathMagic(self.deathPerc, self.ultraDeathPerc)
				self:addExisted()
			end
			
			self.cells[i][j] = stone
		end
	end
end

function Board:addExisted()
	self.existed = self.existed + 1
end

function Board:removeExisted()
	self.existed = self.existed - 1
end

function Board:addStone(game)
	if not self.theEndFlag then
		local stoped = 0
		for row, columns in pairs(self.cells) do
			for column, stone in pairs(columns) do
				if stone.state == 1 then stoped = stoped + 1 end
			end
		end
		game:addDbg('Board:addStone() : stoped = '..stoped)
		if stoped == self.existed then
			self.gravity = 'none'
			game.screens.battle.battle:nextTurn()
			for i=1, 3 do
				local row = love.math.random(1,5)
				local column = love.math.random(1,5)
		
				if not self.cells[row][column] then
					msg = '\nMissed '..row..','..column
				else
					if self.cells[row][column].volume < 2 then
						self.cells[row][column].volume = love.math.random(1,5) == 3 and 4 or 2
						
						self.cells[row][column]:applyDeathMagic(self.deathPerc, self.ultraDeathPerc)
				
						self:addExisted()
					end
				end
			end
			
			for row, columns in pairs(self.cells) do
				for column, stone in pairs(columns) do
					stone.state = 0
				end
			end
		end
	end
end

function Board:merge(game, stone, nextRow, nextColumn)

	local currentType = game.magicTypes[stone:getMask()]
	local source = 'merge'

	self.cells[nextRow][nextColumn] = MagicStone(nextRow, nextColumn, 'c1')
	local currentPlayer = game.screens.battle.battle:getCurrentPlayer()
	local nextPlayer = game.screens.battle.battle:getNextPlayer()

	if stone.volume == 2048 then
		damage = currentPlayer.attack - nextPlayer.defense
		if nextPlayer.health >= damage then
			nextPlayer.health = nextPlayer.health - damage
		else
			nextPlayer.health = 0
		end
		source = 'damage'
	elseif stone.volume == 4096 then
		damage = 5*currentPlayer.attack - nextPlayer.defense
		if nextPlayer.health >= damage then
			nextPlayer.health = nextPlayer.health - damage
		else
			nextPlayer.health = 0
		end
		source = 'damage'
	else
		local currentMana = game.screens.battle.battle.magic[currentPlayer.id][stone:getMask()]
		local magicPower = currentPlayer.magic[magicTypesDict[stone:getMask()]].power
		
		if currentPlayer.magic[magicTypesDict[stone:getMask()]].mana >= currentMana + magicPower then
			game.screens.battle.battle.magic[currentPlayer.id][stone:getMask()] = currentMana + magicPower
		end
	end
	
	if currentType.isCanBeMerged then
		self.cells[stone.row][stone.column]:upgrade()
	else
		self.cells[stone.row][stone.column] = MagicStone(stone.row, stone.column, 'c1')
		self:removeExisted()
	end
	self:removeExisted()
	
	if nextPlayer.health == 0 then
		source = 'the_end'
		self.theEndFlag = true
	end
	
	game.assets:playFx(source)
end

function Board:move(game)
	if self.gravity == 'down' then
		self:moveDown(game)
	elseif self.gravity == 'up' then
		self:moveUp(game)
	elseif self.gravity == 'left' then
		self:moveLeft(game)
	elseif self.gravity == 'right' then
		self:moveRight(game)
	end
end

function Board:moveDown(game)
	for row=5,1,-1 do
		columns = self.cells[row]
		for column,stone in pairs(columns) do
			if stone.volume > 1 then
				stone:update(dt, game)
			end
		end
	end
	
	for row=5,1,-1 do
		columns = self.cells[row]
		for column,stone in pairs(columns) do
			if stone.volume > 1 and stone.row > 1 and self.cells[stone.row-1][stone.column].volume == stone.volume then
				-- надо смержить
				self:merge(game, stone, stone.row-1, stone.column)
			end
		end
	end
end

function Board:moveUp(game)
	for row=1,5 do
		columns = self.cells[row]
		for column,stone in pairs(columns) do
			if stone.volume > 1 then
				stone:update(dt, game)
			end
		end
	end
	
	for row=1,4 do
		columns = self.cells[row]
		for column,stone in pairs(columns) do
			if stone.volume > 1 and stone.row < 5 and self.cells[stone.row+1][stone.column].volume == stone.volume then
				-- надо смержить
				self:merge(game, stone, stone.row+1, stone.column)
			end
		end
	end
end

function Board:moveLeft(game)
	for row,columns in pairs(self.cells) do
		for column=1,5 do
			if not columns[column] then
				msg = msg .. '\nMissed ' .. row .. ',' .. column 
			else
				local stone = columns[column]
					if stone.volume > 1 then
					stone:update(dt, game)
				end
			end
		end
	end

	for row,columns in pairs(self.cells) do
		for column=1,4 do
			if not columns[column] then
				msg = msg .. '\nMissed ' .. row .. ',' .. column 
			else
				local stone = columns[column]
				if stone.volume > 1 and stone.column < 5 and self.cells[stone.row][stone.column+1].volume == stone.volume then
					-- надо смержить
					self:merge(game, stone, stone.row, stone.column+1)
				end
			end
		end
	end
end

function Board:moveRight(game)
	for row,columns in pairs(self.cells) do
		for column=5,1,-1 do
			local stone = columns[column]
			if stone.volume > 1 then
				stone:update(dt, game)
			end
		end
	end
	
	for row,columns in pairs(self.cells) do
		for column=5,1,-1 do
			local stone = columns[column]
			if stone.volume > 1 and stone.column > 1 and self.cells[stone.row][stone.column-1].volume == stone.volume then
				-- надо смержить
				self:merge(game, stone, stone.row, stone.column-1)
			end
		end
	end
end