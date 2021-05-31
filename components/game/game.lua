local Graphics  = require 'components/graphics/graphics'
local StateWith = require 'components/states/state_with'
local Events 	= require 'components/events/registry'

Game = StateWith:extend()

function Game:new(config)
	self.profiles = {}
	self.profile = {}
	self.assets = {}
	self.translate = {
		x=0,
		y=0,
		start = { x=0, y=0 },
		move = false
	}
	self.graphics = {}
	self.mouse = { x = 0, y = 0 }
	self.fps = 1
	self.events = Events()

	Game.super.new(self, config)
end

function Game:init()
	self.graphics = Graphics(self.graphics)

	self:initializeOne('assets')
	self.assets:init()

	self:changeStateTo('main')
end

function Game:update(dt)
	self.fps = dt

	self.events:riseEvent('update', { dt=dt })
	self:getCurrentState():update(dt)
end

function Game:draw()
	self.events.draw = Event({name = 'draw'})
	self:getCurrentState():draw()
end

function Game:mouseMoved(x, y, dx, dy, isTouch)
	self.mouse.x, self.mouse.y = x,y

	self.events.mouseMoved = Event({name = 'mouseMoved', args = { x=x, y=y, dx=dx, dy=dy, isTouch=isTouch }})
	game:getCurrentState():mouseMoved(x, y, dx, dy, isTouch)
end

function Game:mousePressed(x, y, button, isTouch, presses)
	self.events.mousePressed = Event({
		name = 'mousePressed', 
		args = { x=x, y=y, button=button, isTouch=isTouch, presses=presses }}
	)
	game:getCurrentState():mousePressed(x, y, button, isTouch, presses)
end

function Game:mouseReleased(x, y, button, isTouch, presses)
	self.events.mouseReleased = Event({
		name = 'mouseReleased', 
		args = { x=x, y=y, button=button, isTouch=isTouch, presses=presses }}
	)
	game:getCurrentState():mouseReleased(x, y, button, isTouch, presses)
end

function Game:keyPressed(key)
	self.events.keyPressed = Event({name = 'keyPressed', args = { key = key }})
	game:getCurrentState():keyPressed(key)
end

function Game:textInput(text)
	self.events.textInput = Event({name = 'textInput', args = { text = text }})
	game:getCurrentState():textInput(text)
end

function Game:buttonPressed(buttonName, button)
	game:getCurrentState():buttonPressed(buttonName, button)
end

function Game:runEvent(name, ...)
	self.events[name] = Event({name = name, args = {...}})
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

function Game:getCurrentScreenLayerData()
	return self:getScreenData(self.state)
end

return Game