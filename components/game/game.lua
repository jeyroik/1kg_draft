local Graphics  = require 'components/graphics/graphics'
local StateWith = require 'components/states/state_with'

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
	self.graphics:update()
	self:getCurrentState():update(dt)
end

function Game:draw()
	self:getCurrentState():draw()
end

function Game:mouseMoved(x, y, dx, dy, isTouch)
	self.mouse.x, self.mouse.y = x,y

	game:getCurrentState():mouseMoved(x, y, dx, dy, isTouch)
end

function Game:mousePressed(x, y, button, isTouch, presses)
	game:getCurrentState():mousePressed(x, y, button, isTouch, presses)
end

function Game:mouseReleased(x, y, button, isTouch, presses)
	game:getCurrentState():mouseReleased(x, y, button, isTouch, presses)
end

function Game:keyPressed(key)
	game:getCurrentState():keyPressed(key)
end

function Game:textInput(text)
	game:getCurrentState():textInput(text)
end

function Game:buttonPressed(buttonName, button)
	game:getCurrentState():buttonPressed(buttonName, button)
end

function Game:runEvent(name, ...)
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