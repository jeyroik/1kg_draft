Icon = Renderable:extend()

-- @param Image image
-- @param Text text
-- @return void
function Icon:new(image, text)
	self.image = image
	self.text = text
end

-- @param number dx delta for the x
-- @param number dy delta for the y
-- @return void
function Icon:render(dx, dy)
	self.image:render(dx, dy)
	self.text:render(dx+self.image.x, dy+self.image.y)
end