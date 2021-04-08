Card = Render:extend{}
Card:implement(Uuid)

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
	self.x = 0
	self.y = 0
	self.width = 0
	self.height = 0

	Card.super.new(self, config)
end

