Player = Card:extend{}

function Player:new(config)
	self.cards_registry = config.cards
	self.cardsAdded = {}
	self.cardsCount = 0
	self.isHuman = false
	self.battle_magic = {

	}
	self.avatar = {
		path = 'chars',
		frame = 1
	}
	self.magic = {
		air = {
			power = 1,
			mana = 5
		},	
		water = {
			power = 1,
			mana = 5
		},
		tree = {
			power = 1,
			mana = 5
		},
		fire = {
			power = 1,
			mana = 5
		},
		life = {
			power = 1,
			mana = 5
		},
		air_ultra = {
			power = 1,
			mana = 2
		},
		water_ultra = {
			power = 1,
			mana = 2
		},
		tree_ultra = {
			power = 1,
			mana = 2
		},
		fire_ultra = {
			power = 1,
			mana = 2
		},
		life_ultra = {
			power = 1,
			mana = 1
		}
	}
	config.path = 'components/render/cards/player'
	Player.super.new(self, config)

	self.cards = {}
end

function Player:addCard(card)
	if  not self.cardsAdded[card.id] then
		card.x = self.x
		card.y = self.y + card.height * (1.2*#self.cards)
		table.insert(self.cards, card)
		self.cardsAdded[card.id] = true
		self.cardsCount = self.cardsCount + 1
		return true
	end
	
	return false
end

function Player:getMagic(magicType)
	return self.magic[game.assets:getMisc('magic'):getByType(magicType):getName()]
end

function Player:getMagicPower(magicType)
	return self:getMagic(magicType).power
end

function Player:getMagicMana(magicType)
	return self:getMagic(magicType).mana
end

-- @param Player player
-- @param string magicType magic type like 'c32'
-- @return number
function Player:getMagicAmount(magicType)
	return self.battle_magic[magicType]
end

function Player:isEnoughMagic(layerData, card)
	local isEnough = true

	for magicName, amount in pairs(card.skill.active.cost) do
		if self:getMagicAmount(game.assets:getMisc('magic'):getByName(magicName):getType()) < amount then
			isEnough = false
			break
		end
	end

	return isEnough
end

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
		self:spendMagic(layerData, card)
	else
		self:addDbg('card not found')
	end
end

-- @param string magicType magic type like 'c32'
-- @param number amount
-- @return void
function Player:incMagicAmount(magicType, amount)
	self.battle_magic[magicType] = self.battle_magic[magicType] + amount
end

-- @param string magicType magic type like 'c32'
-- @param number amount
-- @return void
function Player:decMagicAmount(magicType, amount)
	self:incMagicAmount(magicType, -amount)
end

function Player:spendMagic(layerData, card)
	local cost = card.skill.active:getCost(layerData)
	for magicType, amount in pairs(cost) do
		layerData:decMagicAmount(self, magicType, amount)
	end
end

return Player