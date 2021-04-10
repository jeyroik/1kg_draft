require "components/printer"
require "components/uuid"
require "components/config"
require "components/visible_object"

require "components/mutators/mutator"
require "components/mutators/mutator_enemy_health"
require "components/mutators/mutator_self_health"

require "components/skill"
require "components/render"
require "components/render/image"
require "components/render/text"
require "components/render/icon"
require "components/render/card"
require "components/render/cards/character"
require "components/render/cards/player"
require "components/assets"
require "components/render/board"
require "components/render/screen"
require "components/render/screens/battle_screen"
require "components/magic_type"

require "components/battle"


Game = Object:extend()
Game:implement(Printer)

function Game:new(config)
	self.config = config
	self.assets = Assets(config.assets.base_path)
	self.idIncrementer = 1
	self.magicTypes = {}
	self.tip = nil
	self.screens = {
		battle = BattleScreen(config.screens.battle)
	}
	self.state = config.state or 'auth'
end

function Game:init()
	self:loadMagicTypes()
	self.assets:init()
	
	for i, screen in pairs(self.screens) do
		screen:init(self)
	end
	
	love.window.setFullscreen(true, "desktop")
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

function Game:loadMagicTypes()
	self.magicTypes = {
		c1	 = MagicType('Deck', 0, false, false),
		c2   = MagicType('Air', 2, true, true),
		c4   = MagicType('Water', 4, true, true),
		c8   = MagicType('Tree', 8, true, true),
		c16  = MagicType('Fire', 16, true, true),
		c32  = MagicType('Life', 32, true, true),
		c64  = MagicType('Ultra air', 64, true, true),
		c128 = MagicType('Ultra water', 128, true, true),
		c256 = MagicType('Ultra tree', 256, true, true),
		c512 = MagicType('Ultra fire', 512, true, true),
		c1024 = MagicType('Ultra life', 1024, false, true),
		c2048 = MagicType('Death', 2048, false, true),
		c4096 = MagicType('Ultra Death', 2048, false, true),
		total = MagicType('Total', 0, false, false, 0)
	}
end