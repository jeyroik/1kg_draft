Card = Render:extend{}

function Card:new(config)
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

	Card.super.new(self, config)
end

function Card:takeDamage(damage)
	self.health = (self.health >= damage) and (self.health - damage) or 0
end

function Card:isDead()
	return self.health == 0
end