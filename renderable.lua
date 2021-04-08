Renderable = VisibleObject:extend()

-- @return void
function Renderable:new()
	self.radian = 0
	self.sx = 1
	self.sy = 1
	Renderable.super.new(self)
end

-- @param number sx scale x
-- @param number sy scale y
-- @return void
function Renderable:setScale(sx, sy)
	sy = sy or sx
	
	self.sx = sx
	self.sy = sy
end

-- @param number radian angle radian
-- @return void
function Renderable:setAngle(radian)
	self.radian = radian
end