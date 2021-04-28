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

function Card:draw()
	game.assets:getQuads(self.avatar.path):draw(self.avatar.frame)

	local top, bottom = self:getEdges()

	self:renderHealth(top)
	self:renderAttack(bottom)
	self:renderDefense(bottom)
end

function Card:renderAttack(bottom)
	local attack = Text({ 
		body = self.defense, 
		sx = 1.5*self.sx, 
		sy = 1.5*self.sy,
		x = bottom.left.x+2,
		y = bottom.left.y - attack:getHeight()*1.5*self.sy
	})
	local overlay = Rectangle({
		mode   = 'fill',
		x      = bottom.left.x,
		y      = bottom.left.y - attack:getHeight()*1.5*self.sx,
		width  = attack:getWidth()*1.5*self.sx+2,
		height = attack:getHeight()*1.5*self.sx,
		color  = {0,0,0,0.3}
	})

	overlay:draw()
	attack:draw()
end

function Card:renderDefense(bottom)
	local defense = Text({ 
		body = self.defense, 
		sx = 1.5*self.sx, 
		sy = 1.5*self.sy,
		x = bottom.right.x - defense:getWidth()*1.5*self.sx,
		y = bottom.right.y - defense:getHeight()*1.5*self.sy
	})
	local overlay = Rectangle({
		mode   = 'fill',
		x      = bottom.right.x - defense:getWidth()*1.5*self.sx-2,
		y      = bottom.right.y - defense:getHeight()*1.5*self.sx,
		width  = defense:getWidth()*1.5*self.sx+2,
		height = defense:getHeight()*1.5*self.sx,
		color  = {0,0,0,0.3}
	})

	overlay:draw()
	defense:draw()
end

function Card:renderHealth(top, dx, dy, radian, sx, sy)
	local health = Text({ 
		body = self.health, 
		sx = 1.5*self.sx, 
		sy = 1.5*self.sy,
		x = top.right.x - health:getWidth()*1.5*self.sx,
		y = top.right.y
	})
	local overlay = Rectangle({
		mode   = 'fill',
		x      = top.right.x - health:getWidth()*1.5*self.sx-2,
		y      = top.right.y,
		width  = health:getWidth()*1.5*self.sx+2,
		height = health:getHeight()*1.5*self.sx,
		color  = {0,0,0,0.3}
	})

	overlay:draw()
	health:draw()
end

function Card:takeDamage(damage)
	local data = game:getCurrentScreen():getData()
	local c = data:getCurrentPlayer()
	local n = data:getNextPlayer()

	local realDamage = (self.health >= damage) and damage or self.health

	data.statistics[c.number].damaged = data.statistics[c.number].damaged + realDamage
	data.statistics[n.number].damage_taken = data.statistics[n.number].damage_taken + realDamage

	self.health = self.health - realDamage
end

function Card:isDead()
	return self.health == 0
end

return Card