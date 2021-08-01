local GameObject = require 'components/game/object'

VisibleObject = GameObject:extend()

-- @param table config
-- @return void
function VisibleObject:new(config)
	self.x = 0
	self.y = 0
	self.width = 0
	self.height = 0
	self.radian = 0
	self.sx = 1
	self.sy = 1
	self.grid = {
		row = 0,
		column = 1,
		width = 1,
		height = 1
	}

	self.type = 'object'
	self.mouseOn 	  = false
	self.mouseOut 	  = false
	self.mousePressed = false
	self.pointable	  = false
	self.visible	  = true
	self.label 		  = 'error# Set label or set tip dispatcher or disable tip drawing'
	self.tip 		  = {
		draw = false,
		x = 0,
		y = 0,
		dispatcher = function () 
			
		end
	}

	VisibleObject.super.new(self, config)

	self:subscribeForEvents()
end

function VisibleObject:subscribeForEvents()

	if self.pointable then
		self.mouseOn  = function(event, obj) 
			game.cursor:setOn() 
			obj.tip = {
				draw = true,
				x = event.args.x,
				y = event.args.y,
				dispatcher = game.tip
			}
		end
		self.mouseOut = function(event, obj) 
			game.cursor:reset() 
			obj.tip = {draw = false}
		end
	end

	local hook = require 'components/hooks/event'

	if self.mousePressed then
		self:log('[VisibleObject:subscribeForEvents] subscribed for mousePressed by '..self.name..' (event = mousePressed.'..game:getSceneFullname()..')')
		game.events:on('mousePressed.'..game:getSceneFullname(), hook({gameObject = self}))
	end

	if self.mouseOut or self.mouseOn then
		self:log('[VisibleObject:subscribeForEvents] subscribed for mouseMoved by '..self.name..' (event = mouseMoved.'..game:getSceneFullname()..')')
		game.events:on('mouseMoved.'..game:getSceneFullname(), hook({gameObject = self}))
	end
end

function VisibleObject:eventMousePressed(event)
	if self.mousePressed and self:isMouseOn(event.args.x, event.args.y) then
		if type(self.mousePressed) == 'table' then
			self.mousePressed:onPressed(event, self)
		else
			self.mousePressed(event, self)
		end
	end
end

function VisibleObject:eventMouseMoved(event)
	if self:isMouseOn(event.args.x, event.args.y) and self.visible then
		self:eventMouseOn(event)
		game.cursor:setTarget(self)
	elseif game.cursor:isTarget(self) and self.visible then
		self:eventMouseOut(event)
		game.cursor:releaseTarget()
	end
end

function VisibleObject:eventMouseOn(event)
	if self.mouseOn then
		if type(self.mouseOn) == 'table' then
			self.mouseOn:onPressed(event, self)
		else
			self.mouseOn(event, self)
		end
	end
end

function VisibleObject:eventMouseOut(event)
	if self.mouseOut then
		if type(self.mouseOut) == 'table' then
			self.mouseOut:onPressed(event, self)
		else
			self.mouseOut(event, self)
		end
	end
end

function VisibleObject:draw(...)
	self:drawTip()
end

function VisibleObject:setGridPosition(column, row)
	self.grid.row    = row
	self.grid.column = column
end

function VisibleObject:offsetGridPosition(column, row)
    self.grid.row    = self.grid.row    + row
    self.grid.column = self.grid.column + column
end

function VisibleObject:setGridSize(width, height)
    self.grid.width  = width
    self.grid.height = height
end

function VisibleObject:getWidth()
	return self.width*self.sx
end

function VisibleObject:getHeight()
	return self.height*self.sy
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
		left  = { x = self.x + game.translate.x, 				   y = self.y + game.translate.y },
		right = { x = self.x + game.translate.x + self:getWidth(), y = self.y + game.translate.y }
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
		xAxis and 2 or nil,
		yAxis and 2 or nil, 
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

	self.ySource = self.y
	self.y       = obj.y + (inside and self:getHeight() or -self:getHeight())
end

function VisibleObject:stickToBottom(obj, inside)
	inside = inside or false

	self.ySource = self.y
	self.y       = obj.y + (inside and obj:getHeight()-self:getHeight() or obj:getHeight())
end

function VisibleObject:stickToLeft(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x       = obj.x + (inside and 0 or -self:getWidth())
end

function VisibleObject:stickToRight(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x       = obj.x + (inside and obj:getWidth()-self:getWidth() or obj:getWidth())
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
	ds = ds or 1
	self.sx = (object.width  / self.width)  * ds
	self.sy = (object.height / self.height) * ds
end

function VisibleObject:stepByX(dx)
	self.xSource = self.x
	self.x = self.x + dx
end

function VisibleObject:stepByY(dy)
	self.xSource = self.x
	self.y = self.y + dy
end

function VisibleObject:drawSelection(dx, dy, color, mode)
	dx = dx or 5
	dy = dy or 5
	mode = mode or 'line'
	color = color or {1,1,1,1}

	local top, _, size = self:getEdgesFrame(dx, dy)

	love.graphics.setColor(color)
	love.graphics.rectangle(mode, top.left.x-game.translate.x, top.left.y-game.translate.y, size.width, size.height, 10, 10, 10)
	love.graphics.setColor({1,1,1,1})
end

function VisibleObject:drawTip()
	if self.tip.draw then 
		if type(self.tip.dispatcher) == 'table' then
			self.tip.dispatcher:draw(self.tip, self)
		else
			self.tip.dispatcher(self.tip, self) 
		end
	end
end

return VisibleObject