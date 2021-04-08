Battle = Object:extend()

-- @param Player player1
-- @param Player player2
-- @return void
function Battle:new(player1, player2)
	self.players = {}
	table.insert(self.players, player1)
	table.insert(self.players, player2)
	self.current = 1
	self.next = 2
	self.magic = {}
	self.deathPerc = 10
	self.ultraDeathPerc = 20
end

function Battle:init()
	self.magic = {}
	local current = self:getCurrentPlayer()
	local enemy = self:getNextPlayer()
	
	self.magic[current.id] = {}
	self.magic[enemy.id] = {}
	
	for i=0, 10 do
		self.magic[current.id]['c'..math.pow(2,i)] = 0
		self.magic[enemy.id]['c'..math.pow(2,i)] = 0
	end
end


function Battle:renderMagic(game, dx, dy)
	self:renderPlayer1Magic(game)
	self:renderPlayer2magic(game)
end

function Battle:renderPlayer1Magic(game)
	local magicX = 270
	local magicXDelta = 150
	local magicY = 750
	local magicYDelta = 50
	local perRow = 3
	local onRow = 0
	local current = self.players[1]
	
	for i=0,10 do
		local id = 'c'..math.pow(2,i)
		value = self.magic[current.id][id]
		--plm1 = plm1 .. magicTypes[color].name..': '..value..'\n'
		if game.assets.images.gems[id] then
			
			if onRow == perRow then
				magicX = 270
				magicY = magicY + magicYDelta
				onRow = 0
			end
			
			love.graphics.draw(game.assets.images.gems[id], magicX, magicY, 0, 0.5,0.5)
			love.graphics.print(value, magicX+40, magicY, 0, 2,2)
			magicX = magicX + magicXDelta
			onRow = onRow + 1
		end
	end
end

function Battle:renderPlayer2magic(game)
	local magicX = 1270
	local magicXDelta = 150
	local magicY = 750
	local magicYDelta = 50
	local perRow = 3
	local onRow = 0
	local enemy = self.players[2]
	
	for i=0,10 do
		local id = 'c'..math.pow(2,i)
		value = self.magic[enemy.id][id]
		--plm1 = plm1 .. magicTypes[color].name..': '..value..'\n'
		if game.assets.images.gems[id] then
			
			if onRow == perRow then
				magicX = 1270
				magicY = magicY + magicYDelta
				onRow = 0
			end
			
			love.graphics.draw(game.assets.images.gems[id], magicX, magicY, 0, 0.5,0.5)
			love.graphics.print(value, magicX+40, magicY, 0, 2,2)
			magicX = magicX + magicXDelta
			onRow = onRow + 1
		end
	end
end

function Battle:showPlayersInfo()
	local p1 = self.players[1]
	local p2 = self.players[2]
	
	love.graphics.print('\nPlayer 1:'..'\n\nHealth: '.. p1.health, p1.x, 100, 0, 2,2)
	love.graphics.print('\nPlayer 2:'..'\n\nHealth: '.. p2.health, p2.x, 100, 0,2,2)
end

function Battle:frameCurrentPlayer()
	local current = self.players[self.current]
	local frameX, frameY = current:getCoordsFrame(5)
	
	love.graphics.rectangle('line', frameX, 120, 200, 40)
end

-- @return Player
function Battle:getCurrentPlayer()
	return self.players[self.current]
end

-- @return Player
function Battle:getNextPlayer()
	return self.players[self.next]
end

-- Changes current and next player with each other
-- @return void
function Battle:nextTurn()
	local c = self.current
	self.current = self.next
	self.next = c
end