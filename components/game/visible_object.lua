VisibleObject = GameObject:extend()

VisibleObject.globalSX = love.graphics.getWidth()/800
VisibleObject.globalSY = love.graphics.getHeight()/600

-- @param table config
-- @return void
function VisibleObject:new(config)
	self.x = 0
	self.xSource = self.x
	self.y = 0
	self.ySource = self.y
	self.width = 0
	self.height = 0
	self.radian = 0
	self.sx = 1
	self.sy = 1
	self.love = {
		width = love.graphics.getWidth(),
		height = love.graphics.getHeight()
	}
	self.renderConfig = {
		scale = 'scale', -- size | position | none
		origin = {
			x = 0,
			y = 0,
			w = 800,
			h = 600
		}
	}
	self.previousResolution = '0x0'

	VisibleObject.super.new(self, config)
end

function VisibleObject:render()
	local render = Render(self.renderConfig)
	render:draw(self)
end

function VisibleObject:draw(...)
	self:addDbg('Missed draw implementation')
end

function VisibleObject:updateGlobals()
	VisibleObject.globalSX = love.graphics.getWidth()/800
	VisibleObject.globalSY = love.graphics.getHeight()/600
end

function VisibleObject:getWidth()
	if not self.sx then
		love.filesystem.append('log.txt', '\n[VisibleObject:getWidth] missed sx: '..json.encode(self))
	end
	return self.width * self.sx
end

function VisibleObject:getHeight()
	return self.height * self.sy
end

-- Checks is mouse currently point to the current object
-- @param number mouseX
-- @param number mouseY
-- @return boolean
function VisibleObject:isMouseOn(mouseX, mouseY)
	local top, bottom = self:getEdges()

	if mouseX >= top.left.x and mouseX <= top.right.x and mouseY >= top.left.y and mouseY <= bottom.left.y then
		return true
	end
	
	return false
end

-- @param number sx scale x
-- @param number sy scale y
-- @return void
function VisibleObject:setScale(sx, sy)
	sx = sx or 1
	sy = sy or sx

	self.sx = sx
	self.sy = sy
end

-- @param number radian angle radian
-- @return void
function VisibleObject:setAngle(radian)
	self.radian = radian
end

-- @param number x
-- @param number y
-- @return void
function VisibleObject:setCoords(x, y)
	self.xSource = self.x
	self.ySource = self.y
	self.x = x
	self.y = y
end

-- @param number width
-- @param number height
-- @return void
function VisibleObject:setSize(width, height)
	self.width = width
	self.height = height
end

-- Set Coordinates and Size
-- @param number x
-- @param number y
-- @param number width
-- @param number height
-- @return void
function VisibleObject:setCS(x, y, width, height)
	self:setCoords(x, y)
	self:setSize(width, height)
end

-- @return number x, number y
function VisibleObject:getCoords()
	return self.x, self.y
end

-- Return coordinates for a frame
-- @param number dx delta x for a frame
-- @param number dy delta y for a frame, may be skiped
-- @return number x, number y
function VisibleObject:getCoordsFrame(dx, dy)
	dy = dy or dx
	
	return self.x-dx, self.y-dy
end

function VisibleObject:getEdges()
	local top = {
		left  = { x = self.x + game.translate.x, 						y = self.y + game.translate.y },
		right = { x = self.x + game.translate.x + self.width * self.sx, y = self.y + game.translate.y }
	}
	local bottom = {
		left  = { x = self.x + game.translate.x,                        y = self.y + game.translate.y + self.height * self.sy },
		right = { x = self.x + game.translate.x + self.width * self.sx, y = self.y + game.translate.y + self.height * self.sy }
	}
	
	return top, bottom
end

-- Return edges for a frame
-- @param number dx delta x for a frame
-- @param number dy delta y for a frame, may be skiped
-- @return {left={x,y}, right={x,y}} top, {left={x,y}, right={x,y}} bottom
function VisibleObject:getEdgesFrame(dx, dy)
	dx = dx or 1
	dy = dy or dx

	local selfTop, selfBottom = self:getEdges()

	local top = {
		left   = { x = selfTop.left.x  - dx, y = selfTop.left.y  - dy },
		right  = { x = selfTop.right.x + dx, y = selfTop.right.y - dy }
	}
	local bottom = {
		left   = {x = selfBottom.left.x  - dx, y = selfBottom.left.y  + dy },
		right  = {x = selfBottom.right.x + dx, y = selfBottom.right.y + dy }
	}
	local size = {
		width  = self:getWidth()  + dx * 2,
		height = self:getHeight() + dy * 2
	}
	
	return top, bottom, size
end

function VisibleObject:setToCenter(xAxis, yAxis)
	self:setToPart(
		xAxis and 1 or nil,
		yAxis and 1 or nil, 
		2
	)
end

function VisibleObject:setToPart(xNum, yNum, slice)
	local w = self:getWidth()
	local h = self:getHeight()

	local sw = love.graphics.getWidth()
	local sh = love.graphics.getHeight()

	slice = slice or 4
	local parts = {}
	for i=0,slice do
		table.insert(parts, {
			x = sw * (1/slice * i),
			y = sh * (1/slice * i)
		})
	end

	if xNum then
		self.xSource = self.x
		self.x = parts[xNum].x - w/2
	end

	if yNum then
		self.ySource = self.y
		self.y = parts[yNum].y - h/2
	end
end

function VisibleObject:stickToTop(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x       = obj.x

	self.ySource = self.y
	self.y       = obj.y + (inside and self:getHeight() or -self:getHeight())
end

function VisibleObject:stickToBottom(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x       = obj.x

	self.ySource = self.y
	self.y       = obj.y + (inside and obj:getHeight()-self:getHeight() or obj:getHeight())
end

function VisibleObject:stickToLeft(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x       = obj.x + (inside and 0 or -self:getWidth())

	self.ySource = self.y
	self.y       = obj.y
end

function VisibleObject:stickToRight(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x       = obj.x + (inside and obj:getWidth()-self:getWidth() or obj:getWidth())

	self.ySource = self.y
	self.y       = obj.y
end

function VisibleObject:setToCenterOfObject(obj, xAxis, yAxis)
	local w = self:getWidth()
	local h = self:getHeight()

	local sw = obj:getWidth()
	local sh = obj:getHeight()

	local center = { x = obj.x + sw/2, y = obj.y + sh/2 }

	if xAxis then
		self.xSource = self.x
		self.x       = center.x - w/2
	end

	if yAxis then
		self.ySource = self.y
		self.y       = center.y - h/2
	end
end

function VisibleObject:scaleTo(object, ds)
	self.sx = (object:getWidth()  / self:getWidth())  * ds
	self.sy = (object:getHeight() / self:getHeight()) * ds
end

function VisibleObject:stepByX(dx)
	self.xSource = self.x
	self.x = self.x + dx
end

function VisibleObject:stepByY(dy)
	self.xSource = self.x
	self.y = self.y + dy
end

function VisibleObject:restoreCoords(x, y)
	self.x = x and self.xSource or self.x
	self.y = y and self.ySource or self.y
end

function VisibleObject:drawSelection(dx, dy, color, mode)
	dx = dx or 5
	dy = dy or 5
	mode = mode or 'line'
	color = color or {1,1,1,1}

	local top, _, size = self:getEdgesFrame(dx, dy)

	love.graphics.setColor(color)
	love.graphics.rectangle(mode, top.left.x-game.translate.x, top.left.y-game.translate.y, size.width*self.sx, size.height*self.sy)
	love.graphics.setColor({1,1,1,1})
end