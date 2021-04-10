Player = Card:extend{}

function Player:new(config)
	self.cards = {}
	self.cardsAdded = {}
	self.cardsCount = 0
	self.isHuman = false
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
	Player.super.new(self, config)
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

function Player:getMagic(layerData, magicType)
	return self.magic[layerData:translateMagicType(magicType)] or 'missed magic type "'..magicType ..'"'
end

function Player:getMagicPower(layerData, magicType)
	return self.magic[layerData:translateMagicType(magicType)].power
end

function Player:getMagicMana(layerData, magicType)
	return self.magic[layerData:translateMagicType(magicType)].mana
end

function Player:isEnoughMagic(layerData, card)
	local isEnough = true

	for magicName, amount in pairs(card.skill.active.cost) do
		if layerData:getMagicAmount(self, layerData:translateMagicName(magicName)) < amount then
			isEnough = false
			break
		end
	end

	return isEnough
end

function Player:useCard(game, layerData, card)
	if self.cardsAdded[card.id] then
		self:addDbg('card found')
		game.assets:playFx('skill')

		local skill = card.skill.active
		for name, context in pairs(skill.mutators) do
			local mutator, err = game.assets:getMutator(name)
			if err then
				self:addDbg(err)
			else
				mutator:apply(game, context)
			end
		end
		self:spendMagic(layerData, card)
	else
		self:addDbg('card not found')
	end
end

function Player:spendMagic(layerData, card)
	local cost = card.skill.active:getCost(layerData)
	for magicType, amount in pairs(cost) do
		layerData:decMagicAmount(self, magicType, amount)
	end
end