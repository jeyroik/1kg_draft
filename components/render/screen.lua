require "components/render/screens/screen_layer"
require "components/render/screens/layers/layer_view"
require "components/render/screens/layers/layer_data"
require "components/render/screens/layers/layer_view_tip"

Screen = Render:extend()
Screen:implement(Printer)

-- @param table config
-- @return void
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

-- @param LayerView[] layers
-- @return void
function Screen:addViewLayers(layers)
	for i=1,#layers do
		table.insert(self.layers.view, layers[i])
	end
end

-- @param LayerData layer
-- @return void
function Screen:setDataLayer(layer)
	self.layers.data = layer
end

-- @param Game game
-- @return void
function Screen:render(game)
	for i = 1, #self.layers.view do
		local layer = self.layers.view[i]
		if layer:needRender(game, self.layers.data) then
			layer:render(game, self.layers.data)
		end
	end
end

-- @return LayerData
function Screen:getData()
	return self.layers.data
end