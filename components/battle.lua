Battle = Object:extend()
Battle:implement(Config)

-- @param Player player1
-- @param Player player2
-- @return void
function Battle:new(config)
	self.players = {}
	self.current = 1
	self.next = 2
	self.magic = {}
	self.deathPerc = 10
	self.ultraDeathPerc = 20

	self:applyConfig(config)
end

function Battle:init()
	local current = self:getCurrentPlayer()
	local enemy = self:getNextPlayer()

	if not self.magic[current.id] then

		self.magic[current.id] = {}
		self.magic[enemy.id] = {}

		for i=0, 10 do
			self.magic[current.id]['c'..math.pow(2,i)] = 0
			self.magic[enemy.id]['c'..math.pow(2,i)] = 0
		end
	end
end

function Battle:isEnoughMagic(player, card)
	local isEnough = true

	for magicName, amount in pairs(card.skill.active.cost) do
		if self:getMagic(player, magicName) < amount then
			isEnough = false
			break
		end
	end

	return isEnough
end

function Battle:getMagic(player, magic)
	local magicId = magicNamesDict[magic]

	return self.magic[player.id][magicId]
end

function Battle:spendMagic(player, card)
	for magicName, amount in pairs(card.skill.active.cost) do
		local magicId = magicNamesDict[magicName]
		self.magic[player.id][magicId] = self.magic[player.id][magicId] - amount
	end
end

function Battle:changeMagic(player, magic, amount)
	local magicId = magicNamesDict[magic]
	self.magic[player.id][magicId] = self.magic[player.id][magicId] + amount
end





