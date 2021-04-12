require "components/game_object"
require "components/visible_object"
require "components/mutators/mutator"
require "components/skill"
require "components/render"
require "components/render/image"
require "components/render/text"
require "components/render/icon"
require "components/render/card"
require "components/render/cards/player"
require "components/assets/importers/importer"
require "components/assets"
require "components/render/board"
require "components/render/screen"
require "components/render/screens/screen_battle"
require "components/magic/magic_type"

Game = GameObject:extend()

function Game:new(config)
	self.config = config
	self.assets = Assets(config.assets)
	self.idIncrementer = 1
	self.screens = {
		battle = BattleScreen(config.screens.battle)
	}
	self.state = config.state or 'auth'

	--Game.super.new(self, config)
end

function Game:init()
	self.assets:init()

	local currentScreen = self:getCurrentScreen()
	currentScreen:init(self)
	
	love.window.setFullscreen(true, "desktop")
end

function Game:changeStateTo(stateName)
	self.state = stateName
	local currentScreen = self:getCurrentScreen()
	currentScreen:init(self)
end

function Game:getScreen(name)
	return self.screens[name] or nil
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