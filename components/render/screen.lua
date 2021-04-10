require "components/render/screens/screen_layer"
require "components/render/screens/layers/layer_view"
require "components/render/screens/layers/layer_data"
require "components/render/screens/layers/layer_view_tip"
require "components/render/screens/layers/layer_view_debug"
require "components/render/screens/layers/layer_view_single_selection"

Screen = Render:extend()
Screen:implement(Printer)

-- @param table config
-- @return void
function Screen:new(config)
	self.background = 'background'
	self.theEnd = 'theEnd'
	self.tip = {}
	self.overlay = false
	self.layers = {
		view = {},
		data = {}
	}

	Screen.super.new(self, config)
end

function Screen:init(game)
	self.layers.data:init(game)
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
	if  not self.overlay then
		self:addViewLayers({ LayerViewSingleSelection(), LayerViewTip(), LayerViewDebug() })
		self.overlay = true
	end

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

function Screen:mouseMoved(game, x, y, dx, dy, isTouch)

end

function Screen:mousePressed(game, x, y, button, isTouch, presses)
    
end

function Screen:keyPressed(game, key)
    
end

function Screen:update(game)
    
end