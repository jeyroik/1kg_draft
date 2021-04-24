VisibleObject = GameObject:extend()
VisibleObject.globalScale = love.graphics.getWidth()/1920

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

	VisibleObject.super.new(self, config)
end

function VisibleObject:updateGlobals()
	VisibleObject.globalScale = love.graphics.getWidth()/1920
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
		left = {x=self.x+ game.translate.x, y=self.y+game.translate.y},
		right = {x=self.x+ game.translate.x+self.width*self.sx, y=self.y+game.translate.y}
	}
	local bottom = {
		left = {x=self.x+ game.translate.x, y=self.y+game.translate.y+self.height*self.sy},
		right = {x=self.x+ game.translate.x+self.width*self.sx, y=self.y+game.translate.y+self.height*self.sy}
	}
	
	return top, bottom
end

-- Return edges for a frame
-- @param number dx delta x for a frame
-- @param number dy delta y for a frame, may be skiped
-- @return {left={x,y}, right={x,y}} top, {left={x,y}, right={x,y}} bottom
function VisibleObject:getEdgesFrame(dx, dy)
	dy = dy or dx
	local top = {
		left = {x=self.x-dx, y=self.y-dy},
		right = {x=self.x+self.width+dx, y=self.y-dy},
		width = self.width + dx*2,
		height = self.height + dy*2
	}
	local bottom = {
		left = {x=self.x-dx, y=self.y+self.height+dy},
		right = {x=self.x+self.width+dx, y=self.y+self.height+dy},
		width = self.width + dx*2,
		height = self.height + dy*2
	}
	local size = {
		width = self.width + dx*2,
		height = self.height + dy*2
	}
	
	return top, bottom, size
end

function VisibleObject:getWidth()
	return self.width
end

function VisibleObject:getHeight()
	return self.height
end

function VisibleObject:setToCenter(xAxis, yAxis)
	self:setToPart(xAxis and 3 or nil, yAxis and 3 or nil, 4)
end

function VisibleObject:setToPart(xNum, yNum, slice)
	local w = self.width * self.sx
	local h = self.height * self.sy

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
	self.x = obj.x

	self.ySource = self.y
	self.y = obj.y + (inside and self.height*self.sy or -self.height*self.sy)
end

function VisibleObject:stickToBottom(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x = obj.x

	self.ySource = self.y
	self.y = obj.y + (inside and obj.height*obj.sy-self.height*self.sx or obj.height*obj.sy)
end

function VisibleObject:stickToLeft(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x = obj.x+(inside and 0 or -self.width*self.sx)

	self.ySource = self.y
	self.y = obj.y
end

function VisibleObject:stickToRight(obj, inside)
	inside = inside or false

	self.xSource = self.x
	self.x = obj.x+(inside and obj.width*obj.sx-self.width*self.sx or obj.width*obj.sx)

	self.ySource = self.y
	self.y = obj.y
end

function VisibleObject:setToCenterOfObject(obj, xAxis, yAxis)
	local w = self.width * self.sx
	local h = self.height * self.sy

	local sw = obj:getWidth() * obj.sx
	local sh = obj:getHeight() * obj.sy

	local center = { x = obj.x + sw/2, y = obj.y + sh/2 }

	if xAxis then
		self.xSource = self.x
		self.x = center.x - w/2
	end

	if yAxis then
		self.ySource = self.y
		self.y = center.y - h*0.75
	end
end

function VisibleObject:scaleTo(object, ds)
	local sx = (object:getWidth()*object.sx) / (self.width*self.sx)
	local sy = (object:getHeight()*object.sy) / (self.height*self.sy)
	ds = ds or 1

	self.sx = sx*ds
	self.sy = sy*ds
end

function VisibleObject:stepByX(dx)
	self.xSource = self.x
	self.x = self.x + self.width + dx
end

function VisibleObject:stepByY(dy)
	self.xSource = self.x
	self.y = self.y + self.height + dy
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
	love.graphics.rectangle(mode, top.left.x, top.left.y, size.width, size.height)
	love.graphics.setColor({1,1,1,1})
end