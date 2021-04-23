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

	local top, bottom = self:getEdges()

	self:renderHealth(top, dx, dy)
	self:renderAttack(bottom, dx, dy)
	self:renderDefense(bottom, dx, dy)
end

function Card:renderAttack(bottom, dx, dy)
	local attack = Text({ body = self.defense, sx = 1.5*self.sx, sy = 1.5*self.sy })
	local overlay = Rectangle({
		mode = 'fill',
		x = bottom.left.x+dx,
		y = bottom.left.y+dy - attack:getHeight()*1.5*self.sx,
		width = attack:getWidth()*1.5*self.sx+2,
		height = attack:getHeight()*1.5*self.sx,
		color = {0,0,0,0.3}
	})

	overlay:render()
	attack:render(bottom.left.x+2+dx, bottom.left.y - attack:getHeight()*1.5*self.sx+dy)
end

function Card:renderDefense(bottom, dx, dy)
	local defense = Text({ body = self.defense, sx = 1.5*self.sx, sy = 1.5*self.sy })
	local overlay = Rectangle({
		mode = 'fill',
		x = bottom.right.x - defense:getWidth()*1.5*self.sx-2 +dx,
		y = bottom.right.y - defense:getHeight()*1.5*self.sx +dy,
		width = defense:getWidth()*1.5*self.sx+2,
		height = defense:getHeight()*1.5*self.sx,
		color = {0,0,0,0.3}
	})

	overlay:render()
	defense:render(
		bottom.right.x - defense:getWidth()*1.5*self.sx +dx,
		bottom.right.y - defense:getHeight()*1.5*self.sx +dy
	)
end

function Card:renderHealth(top, dx, dy)
	local health = Text({ body = self.health, sx = 1.5*self.sx, sy = 1.5*self.sy })
	local overlay = Rectangle({
		mode = 'fill',
		x = top.right.x - health:getWidth()*1.5*self.sx-2 +dx,
		y = top.right.y +dy,
		width = health:getWidth()*1.5*self.sx+2,
		height = health:getHeight()*1.5*self.sx,
		color = {0,0,0,0.3}
	})

	overlay:render()
	health:render(top.right.x - health:getWidth()*1.5*self.sx +dx, top.right.y +dy)
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