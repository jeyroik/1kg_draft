Card = Source:extend{}

function Card:new(config)
	self.name = ''
	self.description = ''
	self.health = 1
	self.attack = 0
	self.defense = 0
	self.skill = {
		active = {},
		passive = {}
	}
	self.avatar = {
		path = 'chars',
		frame = 1
	}
	self.path = 'components/render/cards/card'

	config.initializer = config.initializer or 'components/sources/initializers/card'

	Card.super.new(self, config)
end

function Card:render(dx, dy)
	dx = dx or 0
	dy = dy or 0
	game.assets:getQuads(self.avatar.path):render(self.avatar.frame, self.x+dx, self.y+dy, 0, self.sx, self.sy)
end

function Card:takeDamage(damage)
	self.health = (self.health >= damage) and (self.health - damage) or 0
end

function Card:isDead()
	return self.health == 0
end

return Card