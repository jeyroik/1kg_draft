require "components/game/object"
require "components/game/visible_object"
require "components/game/render"

require "components/models/character"
require "components/models/player"

require "components/game/profile"
require "components/sources/source"
require "components/sources/empty"
require "components/sources/rectangle"
require "components/sources/image"
require "components/sources/image_pack"
require "components/sources/image_titled"
require "components/sources/magic_gem"
require "components/sources/card"
require "components/sources/player"
require "components/sources/board"
require "components/sources/fx"
require "components/sources/quads"
require "components/sources/map"
require "components/sources/text"
require "components/sources/text_overlay"
require "components/sources/icon"
require "components/sources/cursor"
require "components/sources/button"
require "components/sources/grid"
require "components/sources/grids/deck"
require "components/sources/group"

require "components/hooks/hook"
require "components/mutators/mutator"

require "components/assets/importers/importer"
require "components/assets/asset_magic"
require "components/assets/assets"

require "components/graphics/graphics"

Game = GameObject:extend()

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

	Game.super.new(self, config)
end

function Game:init()

	self.graphics = Graphics(self.graphics)

	Game.super.init(self)

	self:initializeOne('assets')
	self.assets:init()

	--self:initializeOne('profile')

	local currentScreen = self:getCurrentState()
	currentScreen:init()
end

function Game:update(dt)
	VisibleObject.updateGlobals(self)
	self.graphics:update()
	self:getCurrentState():update(dt)
end

function Game:render()
	self:getCurrentState():render()
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