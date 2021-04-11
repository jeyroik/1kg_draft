require "components/render/screens/layers/scenes/scene"
require "components/render/screens/layers/layer"
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
	self.scenes = {}
	self.scene = ''
	self.layers = {
		views = {
			scene_before = {},
			scene_current = {},
			scene_after = {},
			system = {}
		},
		data = {}
	}

	Screen.super.new(self, config)

	self:addViewLayers(
		{ LayerViewDebug() },
		'system'
	)
end

function Screen:init(game)
	self.layers.data:init(game)

	local currentScene = self:getCurrentScene()

	currentScene:init(game, self)
	self:setViewLayers(currentScene:getViews(), 'scene_current')
end

function Screen:update(game, dt)
	local currentScene = self:getCurrentScene()
	currentScene:update(game, self, dt)
end

function Screen:mouseMoved(game, x, y, dx, dy, isTouch)
	local currentScene = self:getCurrentScene()
	currentScene:mouseMoved(game, self, x, y, dx, dy, isTouch)
end

function Screen:mousePressed(game, x, y, button, isTouch, presses)
	local currentScene = self:getCurrentScene()
	currentScene:mousePressed(game, self, x, y, button, isTouch, presses)
end

function Screen:keyPressed(game, key)
	local currentScene = self:getCurrentScene()
	currentScene:keyPressed(game, self, key)
end

-- @param Game game
-- @return void
function Screen:render(game)
	for i = 1, #self.layers.views.scene_before do
		local layer = self.layers.views.scene_before[i]
		layer:render(game, self.layers.data)
	end

	for i = 1, #self.layers.views.scene_current do
		local layer = self.layers.views.scene_current[i]
		layer:render(game, self.layers.data)
	end

	for i = 1, #self.layers.views.scene_after do
		local layer = self.layers.views.scene_after[i]
		layer:render(game, self.layers.data)
	end

	for i = 1, #self.layers.views.system do
		local layer = self.layers.views.system[i]
		layer:render(game, self.layers.data)
	end
end

-- @param LayerView[] layers
-- @return void
function Screen:addViewLayers(layers, stage)
	for i=1,#layers do
		table.insert(self.layers.views[stage], layers[i])
	end
end

function Screen:setViewLayers(layers, stage)
	self.layers.views[stage] = layers
end

-- @param LayerData layer
-- @return void
function Screen:setDataLayer(layer)
	self.layers.data = layer
end

-- @return LayerData
function Screen:getData()
	return self.layers.data
end

function Screen:getScene(sceneName)
	return self.scenes[sceneName]
end

function Screen:getCurrentScene()
	return self:getScene(self.scene)
end

function Screen:isScene(sceneName)
	return self.scene == sceneName
end

function Screen:changeSceneTo(sceneName)
	self.scene = sceneName

	local currentScene = self:getCurrentScene()
	self.layers.views.scene_current = currentScene:getViews()
end