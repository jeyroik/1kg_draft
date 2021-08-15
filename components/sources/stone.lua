local Source = require 'components/sources/source'

MagicStone = Source:extend{}

function MagicStone:new(config)
	self.row = 1
	self.column = 1
	self.size = 61
	self.state = 0
	self.scale = 1
	self.magic = 'deck'

	config.path = 'magic'
	config.initializer = config.initializer or 'components/sources/initializers/stone'

	MagicStone.super.new(self, config)
end

function MagicStone:draw()
	local pack  = game.assets:getImagePack(self.path)
	local image = pack:get(self.magic)
	
	image.x 	 = self.x
	image.y 	 = self.y
	image.width  = self.width
	image.height = self.height
	image.sx 	 = self.sx
	image.sy 	 = self.sy
	image:draw()
end

function MagicStone:update(board)
	local nextRow    = self.row
	local nextColumn = self.column
	
	if board:isGravity('down') then
		nextRow = board:isOnEdge('down', self) and self.row or self.row + 1
		if (self.row ~= nextRow and board:isReserved(nextRow, nextColumn)) or board:isOnEdge('down', self) then
			self:setStopped()
		end
		
	elseif board:isGravity('up') then
		nextRow = board:isOnEdge('up', self) and self.row or self.row - 1
		if (self.row ~= nextRow and board:isReserved(nextRow, nextColumn)) or board:isOnEdge('up', self) then
			self:setStopped()
		end
		
	elseif board:isGravity('right') then
		nextColumn = board:isOnEdge('right', self) and self.column or self.column + 1
		if (self.column ~= nextColumn and board:isReserved(nextRow, nextColumn)) or board:isOnEdge('right', self) then
			self:setStopped()
		end
		
	elseif board:isGravity('left') then
		nextColumn = board:isOnEdge('left', self) and self.column or self.column - 1
		if (self.column ~= nextColumn and board:isReserved(nextRow, nextColumn)) or board:isOnEdge('left', self) then
			self:setStopped()
		end
	else
	end

	if not board:isReserved(nextRow, nextColumn) then
		local nextCell = board:getCell(nextRow, nextColumn)

		nextCell:setInAction()
		nextCell.magic = self.magic
		
		self:setInAction()
		self.magic = 'deck'
	end
end

function MagicStone:getMagic()
	return game.assets:getMisc('magic'):getByName(self.magic)
end

function MagicStone:upgrade()
	self.magic = self:getMagic().mergeTo
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
	return self.magic == 'death'
end

function MagicStone:isUltraDeathStone()
	return self.magic == 'death_ultra'
end

function MagicStone:applyDeathMagic(deathPerc, ultraDeathPerc)
	deathPerc = deathPerc or 10
	ultraDeathPerc = ultraDeathPerc or 20

	if love.math.random(1,deathPerc) == 1 then
		self.magic = 'death'
	end

	if love.math.random(1,ultraDeathPerc) == 1 then
		self.magic = 'death_ultra'
	end
end

return MagicStone