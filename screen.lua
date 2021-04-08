Screen = Renderable:extend()
Screen:implement(Printer)

function Screen:new(config)
	self.background = config.background or 'background'
	self.theEnd = config.theEnd or 'theEnd'
	self.tip = config.tip or nil
	self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function Screen:renderBackground(game)
	background = game.assets:getImage(self.background)
	background:setScale(2)
	background:render(80, 0)
	
	self:printDbg()
end

function Screen:renderTheEnd(game)
	local noticeImg = game.assets:getImage(self.theEnd)
	love.graphics.draw(noticeImg, self.center.x-noticeImg:getWidth()/2, 120)
	love.graphics.print('The end', self.center.x-noticeImg:getWidth()/2+150, 140, 0,4,4)
end

function Screen:renderTip(game)
	if self.tip then
		local tipImg = game.assets:getImage('tip')
		
		if tipImg:getWidth() + self.tip.x > love.graphics.getWidth() then
			self.tip.x = self.tip.x-tipImg:getWidth()
		end 
		love.graphics.draw(tipImg, self.tip.x, self.tip.y)
		love.graphics.print(self.tip.text, self.tip.x+30, self.tip.y+30, 0,2,2)
		if self.tip.icons then
			
			for i,icon in pairs(self.tip.icons) do
				love.graphics.draw(icon.image, self.tip.x+icon.xd, self.tip.y+icon.yd, 0, 0.5, 0.5)
				love.graphics.print(icon.text, self.tip.x+icon.xd+5+icon.image:getWidth()/2, self.tip.y+icon.yd, 0,2,2)
			end
		end
	end
end