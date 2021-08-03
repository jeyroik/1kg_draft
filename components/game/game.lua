local Graphics   = require 'components/graphics/graphics'
local StateWith  = require 'components/states/state_with'
local Events 	 = require 'components/events/registry'
local GameCursor = require 'components/game/cursor'

Game = StateWith:extend()

function Game:new(config)
	self.profiles = {}
	self.profile = {}
	self.resources = {}
	self.assets = {}
	self.translate = {
		x=0,
		y=0,
		start = { x=0, y=0 },
		move = false
	}
	self.graphics = {}
	self.cursor = GameCursor({path = 'hand'})
	self.mouse = { x = 0, y = 0 }
	self.fps = 1
	self.events = Events()
	self.initialized = false
	self.debugOn = false
	self.tip = {}

	Game.super.new(self, config)
end

function Game:init()
	self.graphics = Graphics(self.graphics)

	self:initializeOne('assets')
	self:initializeOne('resources')
	self:initializeOne('tip')

	self:changeStateTo('main')
end

function Game:update(dt)
	self.fps = dt

	if not self.initialized then
		self.assets:init()
		self.initialized = true
	end

	self.events:riseEvent('update', { dt=dt })
	self:getCurrentState():update(dt)
end

function Game:draw()
	self.events:riseEvent('draw', {})
	self:getCurrentState():draw()
end

function Game:mouseMoved(x, y, dx, dy, isTouch)
	self.mouse.x, self.mouse.y = x,y

	self.events:riseEvent('mouseMoved', { x=x, y=y, dx=dx, dy=dy, isTouch=isTouch })
	game:getCurrentState():mouseMoved(x, y, dx, dy, isTouch)
end

function Game:mousePressed(x, y, button, isTouch, presses)
	self.events:riseEvent(
		'mousePressed', 
		{ x=x, y=y, button=button, isTouch=isTouch, presses=presses }
	)
	game:getCurrentState():mousePressed(x, y, button, isTouch, presses)
end

function Game:mouseReleased(x, y, button, isTouch, presses)
	self.events:riseEvent(
		'mouseReleased', 
		{ x=x, y=y, button=button, isTouch=isTouch, presses=presses }
	)
	game:getCurrentState():mouseReleased(x, y, button, isTouch, presses)
end

function Game:keyPressed(key)
	self.events:riseEvent('keyPressed', { key = key })
	game:getCurrentState():keyPressed(key)
end

function Game:textInput(text)
	self.events:riseEvent('textInput', { text = text })
	game:getCurrentState():textInput(text)
end

function Game:runEvent(name, ...)
	self.events:riseEvent(name, {...})
	game:getCurrentState():runEvent(name, ...)
end

function Game:getScreen(name)
	return self.__states__[name]
end

function Game:getScreenData(screenName)
	local screen = self:getScreen(screenName)
	
	return screen and screen:getData() or nil
end

function Game:getCurrentScreen()
	return self:getScreen(self.state)
end

function Game:getSceneFullname()
	local screen = self:getCurrentState()
	local scene  = screen:getCurrentState()

	return screen.name .. 
	'.' .. scene.name
end

function Game:getCurrentScreenLayerData()
	return self:getScreenData(self.state)
end

function Game:create(objectType, objectConfig)
	return self.resources:create(objectType, objectConfig)
end

function Game:put(obj, row,column, width,height)
	return self.graphics:put(obj, row, column, width, height)
end

return Game