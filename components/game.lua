require "components/game/object"
require "components/game/visible_object"

require "components/game/profile"
require "components/sources/source"
require "components/sources/screen"
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

require "components/hooks/hook"
require "components/mutators/mutator"
require "components/skills/skill"

require "components/assets/importers/importer"
require "components/assets/asset_magic"
require "components/assets/assets"

require "components/render/screens/screen_battle"
require "components/render/screens/screen_landscape"

Game = GameObject:extend()

function Game:new(config)
	self.profile = Profile(config.profile)
	self.assets = config.assets
	self.screens = config.screens
	self.state = 'auth'
	self.translate = {
		x=0,
		y=0,
		start = {x=0,y=0},
		move = false
	}

	Game.super.new(self, config)
end

function Game:init()

	self:initializeOne('assets')
	self.assets:init()

	self.screens = {
		battle = BattleScreen(self.screens.battle),
		landscape = LandscapeScreen(self.screens.landscape)
	}

	local currentScreen = self:getCurrentScreen()
	currentScreen:init()
end

function Game:update(dt)
	VisibleObject.updateGlobals(self)
	self:getCurrentScreen():update(dt)
end

function Game:render()
	self:getCurrentScreen():render()
end

function Game:mouseMoved(x, y, dx, dy, isTouch)
	game:getCurrentScreen():mouseMoved(x, y, dx, dy, isTouch)
end

function Game:mousePressed(x, y, button, isTouch, presses)
	game:getCurrentScreen():mousePressed(x, y, button, isTouch, presses)
end

function Game:mouseReleased(x, y, button, isTouch, presses)
	game:getCurrentScreen():mouseReleased(x, y, button, isTouch, presses)
end

function Game:keyPressed(key)
	game:getCurrentScreen():keyPressed(key)
end

function Game:changeStateTo(stateName)
	self.state = stateName
	local currentScreen = self:getCurrentScreen()
	currentScreen:init()
end

function Game:getScreen(name)
	return self.screens[name]
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

function Game:export()
	local cfg = {
		state = self.state,
		assets = self.assets__config,
		screens = {}
	}

	for alias, screen in pairs(self.screens) do
		cfg.screens[alias] = screen:export()
	end

	return cfg
end