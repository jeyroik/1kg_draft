require "components/screens/scenes/scene"
local GridView 		 = require "components/screens/views/grid"
local LayerViewDebug = require "components/screens/layers/layer_view_debug"

Screen = Source:extend()
Screen:implement(Printer)

-- @param table config
-- @return void
function Screen:new(config)
	self.initialized = false
	self.background = 'background'
	self.theEnd = 'theEnd'
	self.tip = {}
	self.freeze = {
		mouseMoved    = false,
		mousePressed  = false,
		mouseReleased = false,
		keyPressed 	  = false
	}
	self.layers = {
		views = {
			scene_before  = {},
			scene_current = {},
			scene_after   = {},
			system        = {}
		},
		data = {}
	}
	self.hooks = {
		fullscreen = {
			path   = 'components/hooks/fullscreen',
			events = {
				mouseMoved   = { 'after' },
				mousePressed = { 'after' },
				render       = { 'after' },
			}
		},
		graphicsGrid = {
			path = 'components/hooks/graphics',
			events = {
				keyPressed = { 'after' }
			}
		}
	}
	self.events = {
		init = {
			before = {},
			after  = {}
		},
		update = {
			before = {},
			after  = {}
		},
		mouseMoved = {
			before = {},
			after  = {}
		},
		mousePressed = {
			before = {},
			after  = {}
		},
		mouseReleased = {
			before = {},
			after  = {}
		},
		keyPressed = {
			before = {},
			after  = {}
		},
		textInput = {
			before = {},
			after  = {}
		},
		render = {
			before = {},
			after  = {}
		},
		changeSceneTo = {
			before = {},
			after  = {}
		}
	}

	config.autoInit = false

	Screen.super.new(self, config)

	self:addViewLayers(
		{ LayerViewDebug(), GridView() },
		'system'
	)
end

function Screen:init(game, ...)
	if not self.initialized then
		Screen.super.init(self)

		self:initHooks()
		self:runHooks('init', 'before', ...)

		self.layers.data:init(...)
		self:changeStateTo(self.__state__, ...)
		
		self:runHooks('init', 'after', ...)
	end
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
	if not self.hooks[hook:getAlias()] then
		self.hooks[hook:getAlias()] = hook
	end
	self.events[event][stage][hook:getAlias()] = true
end

function Screen:releaseEvent(event, stage, hookAlias)
	if self.events[event][stage][hookAlias] then
		self.events[event][stage][hookAlias] = false
	end
end

function Screen:runHooks(event, stage, args)
	if not self.events[event] or not self.events[event][stage] then
		return
	end

	for alias,available in pairs(self.events[event][stage]) do
		if available then
			self.hooks[alias]:catch(self, args, event, stage)
		end
	end
end

function Screen:update(dt)
	self:runHooks('update', 'before', {dt = dt})

	local currentScene = self:getCurrentState()
	currentScene:update(self, dt)

	self:runHooks('update', 'after', {dt = dt})
end

function Screen:mouseMoved(x, y, dx, dy, isTouch)
	if self.freeze.mouseMoved then
		return
	end

	self:runHooks('mouseMoved', 'before', {x=x, y=y, dx=dx, dy=dy, isTouch=isTouch})

	local currentScene = self:getCurrentState()
	currentScene:mouseMoved(self, x, y, dx, dy, isTouch)

	self:runHooks('mouseMoved', 'after', {x=x, y=y, dx=dx, dy=dy, isTouch=isTouch})
end

function Screen:mousePressed(x, y, button, isTouch, presses)
	if self.freeze.mousePressed then
		return
	end

	self:runHooks('mousePressed', 'before', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})

	local currentScene = self:getCurrentState()
	currentScene:mousePressed(self, x, y, button, isTouch, presses)

	self:runHooks('mousePressed', 'after', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})
end

function Screen:mouseReleased(x, y, button, isTouch, presses)
	if self.freeze.mouseReleased then
		return
	end

	self:runHooks('mouseReleased', 'before', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})

	local currentScene = self:getCurrentState()
	currentScene:mouseReleased(self, x, y, button, isTouch, presses)

	self:runHooks('mouseReleased', 'after', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})
end

function Screen:keyPressed(key)
	if self.freeze.keyPressed then
		return
	end

	self:runHooks('keyPressed', 'before', {key=key})

	local currentScene = self:getCurrentState()
	currentScene:keyPressed(self, key)

	self:runHooks('keyPressed', 'after', {key=key})
end

function Screen:textInput(text)
	if self.freeze.keyPressed then
		return
	end

	self:runHooks('textInput', 'before', {text=text})

	local currentScene = self:getCurrentState()
	currentScene:textInput(self, text)

	self:runHooks('textInput', 'after', {text=text})
end

-- @param Game game
-- @return void
function Screen:render()
	self:runHooks('render', 'before')

	local currentScene = self:getCurrentState()

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

function Screen:runEvent(name, ...)
	if self.freeze.keyPressed then
		return
	end

	self:runHooks(name, 'before', ...)

	local currentScene = self:getCurrentState()
	currentScene:runEvent(self, name, ...)

	self:runHooks(name, 'after', ...)
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

function Screen:isScene(sceneName)
	return self.__state__ == sceneName
end

function Screen:changeStateTo(sceneName)
	self:runHooks('changeSceneTo', 'before', {sceneName = sceneName})

	self.scene = sceneName

	Screen.super.changeStateTo(self, sceneName)
	local currentScene = self:getCurrentState()
	self:setViewLayers(currentScene:getViews(), 'scene_current')

	self:runHooks('changeSceneTo', 'after', {sceneName = sceneName})
end

function Screen:export()
	return self.layers.data
end

function Screen:freezeEvent(eventName)
	self.freeze[eventName] = true
end

function Screen:unfreezeEvent(eventName)
	self.freeze[eventName] = false
end

return Screen