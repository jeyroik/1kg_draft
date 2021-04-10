require "components/render/magic_stone"

Board = Render:extend()

-- @param number size
-- @return void
function Board:new(config)
	self.size = 5
	self.cells = {}
	self.gravity = 'none'
	self.existed = 0
	self.deathPerc = 10
	self.ultraDeathPerc = 20
	self.stonesPerRound = 3
	self.deathStoneDamage = 1
	self.ultraDeathStoneDamage = 5

	Board.super.new(self, config)
end

function Board:init()
	for i=1,self.size do
		self.cells[i] = {}
		
		for j=1,self.size do
			local stone = MagicStone({row = i, column = j})
			
			if love.math.random(1,8) == 3 then
				stone.volume = love.math.random(1,9) == 3 and 4 or 2
				stone:applyDeathMagic(self.deathPerc, self.ultraDeathPerc)
				self:incExisted()
			end
			
			self.cells[i][j] = stone
		end
	end
end

function Board:addStone(layerData)
	local stopped = 0
	for _, columns in pairs(self.cells) do
		for _, stone in pairs(columns) do
			if stone:isStopped() then stopped = stopped + 1 end
		end
	end

	if stopped == self.existed then
		self.gravity = 'none'
		layerData:nextTurn()
		for _=1, self.stonesPerRound do
			local row = love.math.random(1,5)
			local column = love.math.random(1,5)

			if self.cells[row][column].volume < 2 then
				self.cells[row][column].volume = love.math.random(1,8) == 3 and 4 or 2
				self.cells[row][column]:applyDeathMagic(self.deathPerc, self.ultraDeathPerc)

				self:incExisted()
				--return 'created'
			end
		end

		for _, columns in pairs(self.cells) do
			for _, stone in pairs(columns) do
				stone:setInAction()
			end
		end
	end

	return nil
end

function Board:merge(game, layerData, stone, nextRow, nextColumn)

	local currentType = layerData:getMagicType(stone:getMask())
	local source = 'merge'

	self:setFree(nextRow, nextColumn)

	local currentPlayer = layerData:getCurrentPlayer()
	local nextPlayer = layerData:getNextPlayer()

	if stone:isDeathStone() then
		local damage = self.deathStoneDamage * currentPlayer.attack - nextPlayer.defense
		nextPlayer:takeDamage(damage)
		source = 'damage'
	elseif stone:isUltraDeathStone() then
		local damage = self.ultraDeathStoneDamage * currentPlayer.attack - nextPlayer.defense
		nextPlayer:takeDamage(damage)
		source = 'damage'
	else
		local currentMana = layerData:getMagicAmount(currentPlayer, stone:getMask())
		local magic = currentPlayer:getMagic(layerData, stone:getMask())

		if magic.mana >= currentMana + magic.power then
			layerData:incMagicAmount(currentPlayer, stone:getMask(), magic.power)
		end
	end
	
	if currentType.isCanBeMerged then
		self.cells[stone.row][stone.column]:upgrade()
	else
		self:setFree(stone.row, stone.column)
		self:decExisted()
	end
	self:decExisted()
	
	return source
end

function Board:move(game, layerData)
	local fx = 'move'

	if self.gravity == 'down' then
		fx = self:moveDown(game, layerData) or fx
	elseif self.gravity == 'up' then
		fx = self:moveUp(game, layerData) or fx
	elseif self.gravity == 'left' then
		fx = self:moveLeft(game, layerData) or fx
	elseif self.gravity == 'right' then
		fx = self:moveRight(game, layerData) or fx
	end

	return fx
end

function Board:moveDown(game, layerData)
	for row=5,1,-1 do
		columns = self.cells[row]
		for _,stone in pairs(columns) do
			if stone.volume > 1 then
				stone:update(self)
			end
		end
	end
	
	for row=5,1,-1 do
		columns = self.cells[row]
		for _,stone in pairs(columns) do
			if stone.volume > 1 and stone.row > 1 and self.cells[stone.row-1][stone.column].volume == stone.volume then
				return self:merge(game, layerData, stone, stone.row-1, stone.column)
			end
		end
	end

	return nil
end

function Board:moveUp(game, layerData)
	for row=1,5 do
		columns = self.cells[row]
		for _,stone in pairs(columns) do
			if stone.volume > 1 then
				stone:update(self)
			end
		end
	end
	
	for row=1,4 do
		columns = self.cells[row]
		for _,stone in pairs(columns) do
			if stone.volume > 1 and stone.row < 5 and self.cells[stone.row+1][stone.column].volume == stone.volume then
				return self:merge(game, layerData, stone, stone.row+1, stone.column)
			end
		end
	end

	return nil
end

function Board:moveLeft(game, layerData)
	for _,columns in pairs(self.cells) do
		for column=1,5 do
			local stone = columns[column]
			if stone.volume > 1 then
				stone:update(self)
			end
		end
	end

	for _,columns in pairs(self.cells) do
		for column=1,4 do
			local stone = columns[column]
			if stone.volume > 1 and stone.column < 5 and self.cells[stone.row][stone.column+1].volume == stone.volume then
				return self:merge(game, layerData, stone, stone.row, stone.column+1)
			end
		end
	end

	return nil
end

function Board:moveRight(game, layerData)
	for _,columns in pairs(self.cells) do
		for column=5,1,-1 do
			local stone = columns[column]
			if stone.volume > 1 then
				stone:update(self)
			end
		end
	end
	
	for _,columns in pairs(self.cells) do
		for column=5,1,-1 do
			local stone = columns[column]
			if stone.volume > 1 and stone.column > 1 and self.cells[stone.row][stone.column-1].volume == stone.volume then
				return self:merge(game, layerData, stone, stone.row, stone.column-1)
			end
		end
	end

	return nil
end

function Board:setFree(row, column)
	self.cells[row][column] = MagicStone({row = row, column = column})
end

function Board:setStone(stone)
	self.cells[stone.row][stone.column] = stone
end

function Board:isGravity(direction)
	return self.gravity == direction
end

function Board:isOnEdge(edge, stone)
	if edge == 'up' then
		return stone.row == 1
	elseif edge == 'down' then
		return stone.row == self.size
	elseif edge == 'left' then
		return stone.column == 1
	elseif edge == 'right' then
		return stone.column == self.size
	end

	return false
end

function Board:isReserved(row, column)
	return self.cells[row][column].volume > 1
end

function Board:incExisted()
	self.existed = self.existed + 1
end

function Board:decExisted()
	self.existed = self.existed - 1
end