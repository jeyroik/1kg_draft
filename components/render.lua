Render = VisibleObject:extend()

-- @return void
function Render:new()
	self.radian = 0
	self.sx = 1
	self.sy = 1
	Render.super.new(self)
end

-- @param number sx scale x
-- @param number sy scale y
-- @return void
function Render:setScale(sx, sy)
	sy = sy or sx
	
	self.sx = sx
	self.sy = sy
end

-- @param number radian angle radian
-- @return void
function Render:setAngle(radian)
	self.radian = radian
end