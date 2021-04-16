VisibleObject = GameObject:extend()

-- @param table config
-- @return void
function VisibleObject:new(config)
	self.x = 0
	self.xSource = self.x
	self.y = 0
	self.ySource = self.y
	self.width = 0
	self.height = 0

	VisibleObject.super.new(self, config)
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

-- @return {left={x,y}, right={x,y}} top, {left={x,y}, right={x,y}} bottom
function VisibleObject:getEdges()
	local top = {
		left = {x=self.x, y=self.y},
		right = {x=self.x+self.width, y=self.y}
	}
	local bottom = {
		left = {x=self.x, y=self.y+self.height},
		right = {x=self.x+self.width, y=self.y+self.height}
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
	local w = self.width * self.sx
	local h = self.height * self.sy

	local sw = love.graphics.getWidth()
	local sh = love.graphics.getHeight()

	local center = { x = sw/2, y = sh/2 }
	if xAxis then
		self.xSource = self.x
		self.x = center.x - w/2
	end

	if yAxis then
		self.ySource = self.y
		self.y = center.y - h/2
	end
end

function VisibleObject:stickToTop(obj)
	self.xSource = self.x
	self.x = obj.x

	self.ySource = self.y
	self.y = obj.y - self.height*self.sy
end

function VisibleObject:stickToBottom(obj)
	self.xSource = self.x
	self.x = obj.x

	self.ySource = self.y
	self.y = obj.y + obj.height*obj.sy
end

function VisibleObject:stickToLeft(obj)
	self.xSource = self.x
	self.x = obj.x-self.width*self.sx

	self.ySource = self.y
	self.y = obj.y
end

function VisibleObject:stickToRight(obj)
	self.xSource = self.x
	self.x = obj.x+obj.width*obj.sx

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
		self.y = center.y - h/2
	end
end

function VisibleObject:scaleTo(object, ds)
	local s = object:getWidth() / self.width
	ds = ds or 1

	self.sx = s*ds
	self.sy = self.sx
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