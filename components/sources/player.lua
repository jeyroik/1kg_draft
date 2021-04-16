Player = Card:extend{}

function Player:new(config)
	self.cards = {}
	self.cardsAdded = {}
	self.cardsCount = 0
	self.isHuman = false
	self.battle_magic = {}
	self.magic = {}
	self.number = 1

	config.initializer = 'components/sources/initializers/player'

	Player.super.new(self, config)
end

function Player:addCard(card)
	if  not self.cardsAdded[card.id] then
		card.x = self.x
		card.y = self.y + card.height * card.sx * (1.2*#self.cards)
		table.insert(self.cards, card)

		self.cardsAdded[card.id] = true
		self.cardsCount = self.cardsCount + 1
		return true
	end
	
	return false
end

function Player:getMagic(magicName)
	return self.magic[magicName]
end

function Player:getMagicPower(magicName)
	return self:getMagic(magicName).power
end

function Player:getMagicMana(magicName)
	return self:getMagic(magicName).mana
end

-- @param Player player
-- @param string magicName magic name like 'air'
-- @return number
function Player:getMagicAmount(magicName)
	return self.battle_magic[magicName]
end

-- @param Card card
-- @return void
function Player:isEnoughMagic(card)
	local isEnough = true

	for magicName, amount in pairs(card.skill.active.cost) do
		if self:getMagicAmount(magicName) < amount then
			isEnough = false
			break
		end
	end

	return isEnough
end

-- @param LayerData layerData
-- @param Card
-- @return void
function Player:useCard(layerData, card)
	if self.cardsAdded[card.id] then
		self:addDbg('card found')
		game.assets:getFx('skill'):play()

		local skill = card.skill.active
		for name, context in pairs(skill.mutators) do
			local mutator, err = game.assets:getMutator(name)
			if err then
				self:addDbg(err)
			else
				mutator:apply(layerData, context)
			end
		end
		self:spendMagic(card)
	else
		self:addDbg('card not found')
	end
end

-- @param string magicType magic name like 'air'
-- @param number amount
-- @return void
function Player:incMagicAmount(magicName, amount)
	self.battle_magic[magicName] = self.battle_magic[magicName] + amount
end

-- @param string magicName magic name like 'air'
-- @param number amount
-- @return void
function Player:decMagicAmount(magicName, amount)
	self:incMagicAmount(magicName, -amount)
end

function Player:spendMagic(card)
	for magicName, amount in pairs(card.skill.active.cost) do
		self:decMagicAmount(magicName, amount)
	end
end

return Player