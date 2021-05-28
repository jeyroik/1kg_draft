local Source = require 'components/sources/source'
local InitializerCard = require 'components/sources/initializers/card'

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
		frame = 1,
		part = 1
	}
	self.path = 'components/render/cards/card'
	self.initialized = false
	self.screenName  = ''
	self.sceneName   = ''

	config.initializer = config.initializer or 'components/sources/initializers/card'

	Card.super.new(self, config)
end

function Card:draw()
	local card = game.assets:getQuads(self.avatar.path)
	card.x = self.x
	card.y = self.y
	card.sx = self.sx
	card.sy = self.sy
	card:draw(self.avatar.frame)

	--local top, bottom = card:getEdges()

	--self:renderHealth(top)
	--self:renderAttack(bottom)
	--self:renderDefense(bottom)
end

function Card:drawPart(part, rows, columns)
	rows = rows or 3
	columns = columns or 1

	local q = Quads({ path = self.avatar.path .. '/'..self.avatar.frame..'.jpg', rows = rows, columns = columns}) -- jpg !? wtf...

	q.x = self.x
	q.y = self.y
	q.sx = self.sx * (self.width/q.width)
	q.sy = self.sy * (self.height/q.height)
	q:draw(part)
	q:drawSelection()
end

function Card:renderAttack(bottom)
	local attack = Text({ 
		body = self.defense, 
		sx = 1.5*self.sx, 
		sy = 1.5*self.sy,
		x = bottom.left.x+2
	})
	attack.y = bottom.left.y - attack:getHeight()*1.5*self.sy

	local overlay = Rectangle({
		mode   = 'fill',
		x      = bottom.left.x,
		y      = bottom.left.y - attack:getHeight()*1.5*self.sx,
		width  = attack:getWidth()*1.5*self.sx+2,
		height = attack:getHeight()*1.5*self.sx,
		color  = {0,0,0,0.3},
		renderConfig = {
			scale = 'size',
			origin = {
				w = 200,
				h = 150
			}
		}
	})

	overlay:render()
	--love.graphics.print(overlay.sx..','..overlay.sy, overlay.x + overlay:getWidth()+5, overlay.y)
	attack:render()
end

function Card:renderDefense(bottom)
	local defense = Text({ 
		body = self.defense, 
		sx = 1.5*self.sx, 
		sy = 1.5*self.sy
	})
	defense.x = bottom.right.x - defense:getWidth()*1.5*self.sx
	defense.y = bottom.right.y - defense:getHeight()*1.5*self.sy

	local overlay = Rectangle({
		mode   = 'fill',
		x      = bottom.right.x - defense:getWidth()*1.5*self.sx-2,
		y      = bottom.right.y - defense:getHeight()*1.5*self.sx,
		width  = defense:getWidth()*1.5*self.sx+2,
		height = defense:getHeight()*1.5*self.sx,
		color  = {0,0,0,0.3}
	})

	overlay:render()
	defense:render()
end

function Card:renderHealth(top)
	local health = Text({ 
		body = self.health, 
		sx = 1.5*self.sx, 
		sy = 1.5*self.sy,
		y = top.right.y
	})
	health.x = top.right.x - health:getWidth()*1.5*self.sx

	local overlay = Rectangle({
		mode   = 'fill',
		x      = top.right.x - health:getWidth()*1.5*self.sx-2,
		y      = top.right.y,
		width  = health:getWidth()*1.5*self.sx+2,
		height = health:getHeight()*1.5*self.sx,
		color  = {0,0,0,0.3}
	})

	overlay:render()
	health:render()
end

function Card:takeDamage(damage)
	local data = game:getCurrentState():getData()
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

function Card:reload()
	local ini = InitializerCard({})
    ini:initSource(self)
end

return Card