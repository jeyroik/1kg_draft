local MagicStone = require "components/sources/stone"
local Source     = require 'components/sources/source'

Board = Source:extend()

-- @param number size
-- @return void
function Board:new(config)
	self.size = 5
	self.rows = 5
	self.columns = 5
	self.cells = {}
	self.gravity = 'none'
	self.existed = 0
	self.deathPerc = 10
	self.ultraDeathPerc = 20
	self.stonesPerRound = 3
	self.deathStoneDamage = 1
	self.ultraDeathStoneDamage = 5
	self.ready = false

	config.initializer = config.initializer or 'components/sources/initializers/board'

	Board.super.new(self, config)

	self.alias = 'board'
end

function Board:reload()
	for i, columns in pairs(self.cells) do
		for j,stone in pairs(columns) do
			game.graphics:put(stone, self.gridRow+(i-1)*2,self.gridColumn+(j-1)*2, 2,2)
		end
	end
end

function Board:draw()
	love.graphics.rectangle('line', self.x, self.y, self.width*self.sx, self.height*self.sy, self.radian)

	self:reload()
	for _, columns in pairs(self.cells) do
		for _,stone in pairs(columns) do
			if stone.volume > 1 then
				stone:render()
			end
		end
	end
end

function Board:forEachStone(dispatcher)
	local loop = function(func)
		for _, columns in pairs(self.cells) do
			for _, stone in pairs(columns) do
				local continue = func(stone)
				if not continue then
					return
				end
			end
		end
	end

	loop(dispatcher)
end

function Board:setToCenter(xAxis, yAxis)
	Board.super.setToCenter(self, xAxis, yAxis)

	for _, columns in pairs(self.cells) do
		for _, stone in pairs(columns) do
			stone.deltaX = self.x
			stone.deltaY = self.y
			stone.x = (stone.column-1)*stone.width + self.x
			stone.y = (stone.row-1)*stone.width + self.y
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

	if stopped == math.pow(self.size, 2) then
		for row, columns in pairs(self.cells) do
			for column, stone in pairs(columns) do
				self:decExisted()
				stopped = stopped - 1
			end
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
			end
		end

		for _, columns in pairs(self.cells) do
			for _, stone in pairs(columns) do
				stone:setInAction()
			end
		end
	end

	return ''
end

function Board:merge(layerData, stone, nextRow, nextColumn)

	local currentMagic = stone:getMagic()
	local source = 'merge'

	self:setVolume(nextRow, nextColumn, 1)

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
		local currentMana = currentPlayer:getMagicAmount(currentMagic:getName())
		local magic = currentPlayer:getMagic(currentMagic:getName())

		if magic.mana >= currentMana + magic.power then
			currentPlayer:incMagicAmount(currentMagic:getName(), magic.power)
		end
	end
	
	if currentMagic.isCanBeMerged then
		self.cells[stone.row][stone.column]:upgrade()
	else
		self:setVolume(stone.row, stone.column, 1)
		self:decExisted()
	end
	layerData.statistics[currentPlayer.number].stones = layerData.statistics[currentPlayer.number].stones + 2

	self:decExisted()
	
	return source
end

function Board:move(layerData)
	local fx = ''

	if self.gravity == 'down' then
		fx = self:moveDown(layerData)
	elseif self.gravity == 'up' then
		fx = self:moveUp(layerData)
	elseif self.gravity == 'left' then
		fx = self:moveLeft(layerData)
	elseif self.gravity == 'right' then
		fx = self:moveRight(layerData)
	end

	return fx
end

function Board:moveDown(layerData)
	for row=self.rows,1,-1 do
		columns = self.cells[row]
		for _,stone in pairs(columns) do
			if stone.volume > 1 then
				stone:update(self)
			end
		end
	end
	
	for row=self.rows,1,-1 do
		columns = self.cells[row]
		for _,stone in pairs(columns) do
			if stone.volume > 1 and stone.row > 1 and self.cells[stone.row-1][stone.column].volume == stone.volume then
				return self:merge(layerData, stone, stone.row-1, stone.column)
			end
		end
	end

	return ''
end

function Board:moveUp(layerData)
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
				return self:merge(layerData, stone, stone.row+1, stone.column)
			end
		end
	end

	return ''
end

function Board:moveLeft(layerData)
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
				return self:merge(layerData, stone, stone.row, stone.column+1)
			end
		end
	end

	return ''
end

function Board:moveRight(layerData)
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
				return self:merge(layerData, stone, stone.row, stone.column-1)
			end
		end
	end

	return ''
end

function Board:setVolume(row, column, volume)
	self.cells[row][column].volume = volume
end

function Board:setFree(row, column)
	local s = self:calculateStoneParameters()

	self.cells[row][column] = MagicStone({
		row = row,
		column = column
	})
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

function Board:getCell(row, column)
	return self.cells[row][column]
end

return Board