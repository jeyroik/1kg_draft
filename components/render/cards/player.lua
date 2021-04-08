Player = Card:extend{}

function Player:new(config)
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
	Player.super.new(self, config)
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

function Player:isEnoughMagic(game, card)
	local screen = game:getScreen('battle')

	return screen.battle:isEnoughMagic(self, card)
end

function Player:spendMagic(game, card)
	local screen = game:getScreen('battle')

	return screen.battle:spendMagic(self, card)
end

function Player:useCard(game, card)
	if self.cardsAdded[card.name] then
		game.assets:playFx('skill')

		local skill = card.skill.active
		for name, context in pairs(skill.mutators) do
			local mutator = MutatorCollection.getMutator(name)
			mutator:apply(game, context)
		end
		self:spendMagic(game, card)
	end
end