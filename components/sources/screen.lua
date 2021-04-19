require "components/render/screens/scenes/scene"
require "components/render/screens/layers/layer"
require "components/render/screens/layers/layer_view"
require "components/render/screens/layers/layer_data"
require "components/render/screens/layers/layer_view_tip"
require "components/render/screens/layers/layer_view_debug"
require "components/render/screens/layers/layer_view_single_selection"

Screen = Source:extend()
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
	self.hooks = {
		fullscreen = {
			path = 'components/hooks/render/after/fullscreen',
			events = {
				mouseMoved = { 'after' },
				mousePressed = { 'after' },
				render = { 'after' },
			}
		}
	}
	self.events = {
		init = {
			before = {},
			after = {}
		},
		update = {
			before = {},
			after = {}
		},
		mouseMoved = {
			before = {},
			after = {}
		},
		mousePressed = {
			before = {},
			after = {}
		},
		mouseReleased = {
			before = {},
			after = {}
		},
		keyPressed = {
			before = {},
			after = {}
		},
		render = {
			before = {},
			after = {}
		},
		changeSceneTo = {
			before = {},
			after = {}
		}
	}

	config.autoInit = false

	Screen.super.new(self, config)

	self:addViewLayers(
		{ LayerViewDebug() },
		'system'
	)
end

function Screen:init()
	self:initHooks()
	self:runHooks('init', 'before')

	self.layers.data:init()
	self:changeSceneTo(self.scene)

	self:runHooks('init', 'after')
end

function Screen:initHooks()
	for alias, config in pairs(self.hooks) do
		for event, stages in pairs(config.events) do
			for _, stage in pairs(stages) do
				self.events[event][stage][alias] = true
			end
		end
		local hook = require (config.path)
		self.hooks[alias] = hook({ screen = self })
	end
end

function Screen:catchEvent(event, stage, hook)
	self.hooks[hook:getAlias()] = hook
	self.events[event][stage][hook:getAlias()] = true
end

function Screen:releaseEvent(event, stage, hookAlias)
	if self.hooks[event][stage][hookAlias] then
		self.hooks[event][stage][hookAlias] = nil
	end
end

function Screen:runHooks(event, stage, args)
	for alias in pairs(self.events[event][stage]) do
		self.hooks[alias]:catch(self, args, event, stage)
	end
end

function Screen:update(dt)
	self:runHooks('update', 'before', {dt = dt})

	local currentScene = self:getCurrentScene()
	currentScene:update(self, dt)

	self:runHooks('update', 'after', {dt = dt})
end

function Screen:mouseMoved(x, y, dx, dy, isTouch)
	self:runHooks('mouseMoved', 'before', {x=x, y=y, dx=dx, dy=dy, isTouch=isTouch})

	local currentScene = self:getCurrentScene()
	currentScene:mouseMoved(self, x, y, dx, dy, isTouch)

	self:runHooks('mouseMoved', 'after', {x=x, y=y, dx=dx, dy=dy, isTouch=isTouch})
end

function Screen:mousePressed(x, y, button, isTouch, presses)
	self:runHooks('mousePressed', 'before', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})

	local currentScene = self:getCurrentScene()
	currentScene:mousePressed(self, x, y, button, isTouch, presses)

	self:runHooks('mousePressed', 'after', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})
end

function Screen:mouseReleased(x, y, button, isTouch, presses)
	self:runHooks('mouseReleased', 'before', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})

	local currentScene = self:getCurrentScene()
	currentScene:mouseReleased(self, x, y, button, isTouch, presses)

	self:runHooks('mouseReleased', 'after', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})
end

function Screen:keyPressed(key)
	self:runHooks('keyPressed', 'before', {key=key})

	local currentScene = self:getCurrentScene()
	currentScene:keyPressed(self, key)

	self:runHooks('keyPressed', 'after', {key=key})
end

-- @param Game game
-- @return void
function Screen:render()
	self:runHooks('render', 'before')

	local currentScene = self:getCurrentScene()

	for i = 1, #self.layers.views.scene_before do
		local layer = self.layers.views.scene_before[i]
		layer:render(self.layers.data, currentScene)
	end

	for i = 1, #self.layers.views.scene_current do
		local layer = self.layers.views.scene_current[i]
		layer:render(self.layers.data, currentScene)
	end

	for i = 1, #self.layers.views.scene_after do
		local layer = self.layers.views.scene_after[i]
		layer:render(self.layers.data, currentScene)
	end

	for i = 1, #self.layers.views.system do
		local layer = self.layers.views.system[i]
		layer:render(self.layers.data, currentScene)
	end

	self:runHooks('render', 'after')
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
	self:runHooks('changeSceneTo', 'before', {sceneName = sceneName})

	self.scene = sceneName

	local currentScene = self:getCurrentScene()
	currentScene:init(self)
	self:setViewLayers(currentScene:getViews(), 'scene_current')

	self:runHooks('changeSceneTo', 'after', {sceneName = sceneName})
end

function Screen:export()
	return self.layers.data
end