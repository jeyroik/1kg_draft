VisibleObject = Object:extend()
VisibleObject:implement(Config)

-- @param table config
-- @return void
function VisibleObject:new(config)
	self.x = 0
	self.y = 0
	self.width = 0
	self.height = 0

	self:applyConfig(config)
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
		right = {x=self.x+self.width+dx, y=self.y-dy}
	}
	local bottom = {
		left = {x=self.x-dx, y=self.y+self.height+dy},
		right = {x=self.x+self.width+dx, y=self.y+self.height+dy}
	}
	
	return top, bottom
end