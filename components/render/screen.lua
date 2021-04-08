Screen = Render:extend()
Screen:implement(Printer)

function Screen:new(config)
	self.background = 'background'
	self.theEnd = 'theEnd'
	self.tip = {}

	self.layers = {
		view = {},
		data = {}
	}

	Screen.super.new(self, config)

	self:addViewLayers({ LayerViewTip() })
end

function Screen:addViewLayers(layers)
	for i=1,#layers do
		table.insert(self.layers.view, layers[i])
	end
end

function Screen:setDataLayer(layer)
	self.layers.data = layer
end

function Screen:render(game)
	for i = 1, #self.layers.view do
		local layer = self.layers.view[i]
		if layer:needRender(game, data) then
			layer:render(game, self.layer.data)
		end
	end
end

function Screen:renderTheEnd(game)
	local noticeImg = game.assets:getImage(self.theEnd)
	love.graphics.draw(noticeImg, self.center.x-noticeImg:getWidth()/2, 120)
	love.graphics.print('The end', self.center.x-noticeImg:getWidth()/2+150, 140, 0,4,4)
end