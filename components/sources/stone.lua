MagicStone = Source:extend{}

function MagicStone:new(config)
	self.row = 1
	self.column = 1
	self.deltaX = 285
	self.deltaY = 0
	self.size = 61
	self.volume = 1
	self.state = 0
	self.scale = 1

	config.path = 'gems'
	config.initializer = config.initializer or 'components/sources/initializers/stone'

	MagicStone.super.new(self, config)

	self.alias = 'stone'
end

function MagicStone:draw()
	local pack = game.assets:getImagePack(self.path)
	local image = pack:get(self:getMask())

	image.x = self.x
	image.y = self.y
	image.width = self.width
	image.height = self.height
	image.sx = self.sx
	image.sy = self.sy
	image:draw()
end

function MagicStone:update(board)
	local nextRow = self.row
	local nextColumn = self.column
	
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

	if not board:isReserved(nextRow, nextColumn) then
		local nextStone = board:getCell(nextRow, nextColumn)
		
		nextStone.state = self.state
		nextStone.volume = self.volume
		
		self.volume = 1
		self.state  = 0
	end
end

function MagicStone:getMask()
	return 'c' .. self.volume
end

function MagicStone:getMagic()
	return game.assets:getMisc('magic'):getByType(self:getMask())
end

-- @return Magic
function MagicStone:getMagic()
	return game.assets:getMisc('magic'):getByType(self:getMask())
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

	if love.math.random(1,deathPerc) == 1 then
		self.volume = 2048
	end

	if love.math.random(1,ultraDeathPerc) == 1 then
		self.volume = 4096
	end
end

return MagicStone