Player = Card:extend{}

function Player:new(name, x, y)
	Player.super.new(self, name, x, y)
	
	self.health = 100
	self.attack = 2
	self.defense = 1
	self.cards = {}
	self.cardsAdded = {}
	self.cardsCount = 0
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
end

function Player:addCard(card)
	if  not self.cardsAdded[card.name] then
		table.insert(self.cards, card)
		self.cardsAdded[card.name] = true
		self.cardsCount = self.cardsCount + 1
		return true
	end
	
	return false
end