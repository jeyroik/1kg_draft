Profile = Object:extend{}
Profile:implement(Config)
Profile:implement(Printer)
Profile:implement(Uuid)

function Profile:new(config)
	self.id = self:getId()
	self.name = ''
	self.description = ''
	self.health = 1
	self.attack = 0
	self.defense = 0
	self.skill = {
		active = {},
		passive = {}
	}
	self.avatar = 1
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

	Profile.super.new(self, config)
end

function Profile:addCard(card)
	if  not self.cardsAdded[card.path] then
		table.insert(self.cards, card)

		self.cardsAdded[card.path] = 1
		self.cardsCount = self.cardsCount + 1
		return true
	else
		self.cardsAdded[card.path] = self.cardsAdded[card.path] + 1
	end
	
	return false
end

return Profile
