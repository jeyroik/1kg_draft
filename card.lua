Card = Renderable:extend{}
Card:implement(Uuid)

function Card:new(name, x, y)
	self.id = self:getId()
	self.name = name
	self.description = ''
	self.health = 1
	self.attack = 0
	self.defense = 0
	self.skill = {}
	self.avatar = 3
	
	self.x = x or 0
	self.y = y or 0
	self.width = charWidth
	self.height = charHeight
end

function Card:addSkill(skill)
	self.skill = skill
end

function Card:mutate(card, context)
	mutators = {
		health_change = function (card, context)
			card.health = card.health + context.amount
		end
	}
	
	if mutators[context.mutator] then
		mutators[context.mutator](card, context)
	end
end

function Card:copy()
	local newCard = Card(self.name)
	newCard.name = self.name
	newCard.description = self.description 
	newCard.health = self.health 
	newCard.attack = self.attack 
	newCard.defense = self.defense
	newCard.skill = self.skill
	newCard.avatar = self.avatar
	
	newCard.x = self.x 
	newCard.y = self.y
	newCard.width = self.width 
	newCard.height = self.height
	return newCard
end