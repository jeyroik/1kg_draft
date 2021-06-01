local GridView  = require 'components/screens/views/grid'
local StateWith = require 'components/states/state_with'
local Window 	= require 'components/sources/window'

Screen = StateWith:extend()

-- @param table config
-- @return void
function Screen:new(config)
	self.freeze = {
		mouseMoved    = false,
		mousePressed  = false,
		mouseReleased = false,
		keyPressed 	  = false,
		buttonPressed = false
	}

	self.views = {
		scene_before  = {},
		scene_current = {},
		scene_after   = {},
		system        = {}
	}

	self.tips = {}

	Screen.super.new(self, config)

	self:addViewLayers({ GridView() }, 'system')
end

function Screen:initState(game, ...)	
	self:changeStateTo('main', ...)
end

function Screen:releaseEvent(event, stage, hookAlias)
	if self.events[event][stage][hookAlias] then
		self.events[event][stage][hookAlias] = false
	end
end

function Screen:update(dt)
	game.events:riseEvent('update.screen', {dt=dt, screen = self})
	game.events:riseEvent('update.screen.'..self.name, {dt=dt, screen = self})

	local currentScene = self:getCurrentState()
	currentScene:update(self, dt)
end

function Screen:mouseMoved(x, y, dx, dy, isTouch)
	if self.freeze.mouseMoved then
		return
	end

	game.events:riseEvent('mouseMoved.screen', {x=x, y=y, dx=dx, dy=dy, isTouch=isTouch})
	game.events:riseEvent('mouseMoved.screen.'..self.name, {x=x, y=y, dx=dx, dy=dy, isTouch=isTouch})

	local currentScene = self:getCurrentState()
	currentScene:mouseMoved(self, x, y, dx, dy, isTouch)
end

function Screen:mousePressed(x, y, button, isTouch, presses)
	if self.freeze.mousePressed then
		return
	end

	game.events:riseEvent('mousePressed.screen', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})
	game.events:riseEvent('mousePressed.screen.'..self.name, {x=x, y=y, button=button, isTouch=isTouch, presses=presses})

	local currentScene = self:getCurrentState()
	currentScene:mousePressed(self, x, y, button, isTouch, presses)
end

function Screen:mouseReleased(x, y, button, isTouch, presses)
	if self.freeze.mouseReleased then
		return
	end

	game.events:riseEvent('mouseReleased.screen', {x=x, y=y, button=button, isTouch=isTouch, presses=presses})
	game.events:riseEvent('mouseReleased.screen.'..self.name, {x=x, y=y, button=button, isTouch=isTouch, presses=presses})

	local currentScene = self:getCurrentState()
	currentScene:mouseReleased(self, x, y, button, isTouch, presses)
end

function Screen:keyPressed(key)
	if self.freeze.keyPressed then
		return
	end

	game.events:riseEvent('keyPressed.screen', {key=key})
	game.events:riseEvent('keyPressed.screen.'..self.name, {key=key})

	local currentScene = self:getCurrentState()
	currentScene:keyPressed(self, key)
end

function Screen:textInput(text)
	if self.freeze.keyPressed then
		return
	end

	game.events:riseEvent('textInput.screen', {text=text})
	game.events:riseEvent('textInput.screen.'..self.name, {text=text})

	local currentScene = self:getCurrentState()
	currentScene:textInput(self, text)
end

-- @param Game game
-- @return void
function Screen:draw()
	game.events:riseEvent('draw.screen', 'before')
	game.events:riseEvent('draw.screen.'..self.name, 'before')

	local currentScene = self:getCurrentState()

	for i = 1, #self.views.scene_before do
		local layer = self.views.scene_before[i]
		layer:draw(self, currentScene)
	end

	for i = 1, #self.views.scene_current do
		local layer = self.views.scene_current[i]
		layer:draw(self, currentScene)
	end

	for i = 1, #self.views.scene_after do
		local layer = self.views.scene_after[i]
		layer:draw(self, currentScene)
	end

	for i = 1, #self.views.system do
		local layer = self.views.system[i]
		layer:draw(self, currentScene)
	end
end

function Screen:buttonPressed(buttonName, button)
	if self.freeze.buttonPressed then
		return
	end

	self:runHooks('buttonPressed', 'before', {buttonName=buttonName, button=button})

	local currentScene = self:getCurrentState()
	currentScene:buttonPressed(self, buttonName, button)

	self:runHooks('buttonPressed', 'after', {buttonName=buttonName, button=button})
end

function Screen:runEvent(name, ...)
	if self.freeze[name] then
		return
	end

	game.events:riseEvent(name, ...)
end

-- @param LayerView[] layers
-- @return void
function Screen:addViewLayers(layers, stage)
	for i=1,#layers do
		table.insert(self.views[stage], layers[i])
	end
end

function Screen:setViewLayers(layers, stage)
	self.views[stage] = layers
end

function Screen:isScene(sceneName)
	return self.__state__ == sceneName
end

function Screen:changeStateTo(sceneName)

	game.events:flushLike('.scene.'..self.name..'.'..self.__state__)
	
	Screen.super.changeStateTo(self, sceneName)
	
	local currentScene = self:getCurrentState()
	game.events:riseEvent('changeSceneTo',                    { screen=self,   scene=currentScene })
	game.events:riseEvent('changeSceneTo.screen.'..self.name, { screen=screen, scene=currentScene })

	self:setViewLayers(currentScene:getViews(), 'scene_current')
end

function Screen:freezeEvent(eventName)
	self.freeze[eventName] = true
end

function Screen:unfreezeEvent(eventName)
	self.freeze[eventName] = false
end

function Screen:registerTip(config)
	table.insert(self.tips, Window(config))
end

return Screen