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
	self.width = self.size
	self.height = self.size
end

function MagicStone:render(game)
	love.graphics.draw(game.assets.images.gems[self:getMask()], self.x, self.y, 0, 2,2)
end

function MagicStone:update(board)
	local nextRow = self.row
	local nextColumn = self.column

	board:setFree(self.row, self.column)
	
	if board:isGravity('down') then
		nextRow = board:isOnEdge('down', self) and self.row or self.row + 1
		if (self.row ~= nextRow and board:isReserved(nextRow, nextColumn)) or board:isOnEdge('down', self) then
			self:setStopped()
		end
		
	elseif board:isGravity('up') then
		nextRow = board:isOnEdge('up', self) and 1 or self.row - 1
		if (self.row ~= nextRow and board:isReserved(nextRow, nextColumn)) or board:isOnEdge('up', self) then
			self:setStopped()
		end
		
	elseif board:isGravity('right') then
		nextColumn = board:isOnEdge('right', self) and self.column or self.column + 1
		if (self.column ~= nextColumn and board:isReserved(nextRow, nextColumn)) or board:isOnEdge('right', self) then
			self:setStopped()
		end
		
	elseif board:isGravity('left') then
		nextColumn = board:isOnEdge('left', self) and 1 or self.column - 1
		if (self.column ~= nextColumn and board:isReserved(nextRow, nextColumn)) or board:isOnEdge('left', self) then
			self:setStopped()
		end
	else
	end

	if board:isReserved(nextRow, nextColumn) then
		nextRow = self.row
		nextColumn = self.column
	end
	
	self.row = nextRow
	self.column = nextColumn
	
	self.x = self.column * self.size + self.deltaX
	self.y = self.row * self.size + self.deltaY

	board:setStone(self)
end

function MagicStone:getMask()
	return 'c' .. self.volume
end

function MagicStone:upgrade()
	self.volume = self.volume * 2
end

function MagicStone:setInAction()
	self.state = 0
end

function MagicStone:setStopped()
	self.state = 1
end

function MagicStone:isStopped()
	return self.state == 1
end

function MagicStone:isInAction()
	return self.state == 0
end

function MagicStone:isDeathStone()
	return self.volume == 2048
end

function MagicStone:isUltraDeathStone()
	return self.volume == 4096
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