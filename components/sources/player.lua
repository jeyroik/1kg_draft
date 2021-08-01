local Card = require 'components/sources/card'

Player = Card:extend{}

function Player:new(config)
	self.cards = {}
	self.cardsAdded = {}
	self.cardsCount = 0
	self.isHuman = false
	self.magic = {}
	self.number = 1
	self.magic = {}

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

function Player:addCards(cards)
	for _, card in pairs(cards) do
		self:addCard(card)
	end
end

function Player:getMagic(magicName)
	return self.magic[magicName]
end

function Player:getMagicPower(magicName)
	return self:getMagic(magicName).power
end

function Player:incMagicPower(magicName, inc)
	self:incMagicParameter(magicName, 'power', inc)
end

function Player:decMagicPower(magicName, dec)
	self:incMagicPower(magicName, -dec)
end

function Player:getMagicMana(magicName)
	return self:getMagic(magicName).mana
end

function Player:incMagicMana(magicName, inc)
	self:incMagicParameter(magicName, 'mana', inc)
end

function Player:decMagicMana(magicName, dec)
	self:incMagicMana(magicName, -dec)
end

function Player:incMagicParameter(magicName, parameter, inc)
	self.magic[magicName]:incMagicParameter(parameter, inc)
end

function Player:decMagicParameter(magicName, parameter, dec)
	self:incMagicParameter(magicName, parameter, -dec)
end

-- @param Player player
-- @param string magicName magic name like 'air'
-- @return number
function Player:getMagicAmount(magicName)
	return self.magic[magicName].amount
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
		game.assets:getFx('skill'):play()

		card.skill.active:use(layerData)
		self:spendMagic(card)
	end
end

-- @param string magicType magic name like 'air'
-- @param number amount
-- @return void
function Player:incMagicAmount(magicName, amount)
	self.magic[magicName].amount = self.magic[magicName].amount + amount
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