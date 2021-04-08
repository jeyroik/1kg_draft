Object = require "classic"

require "printer"
require "uuid"
require "visible_object"
require "renderable"
require "image"
require "text"
require "icon"
require "card"
require "magic_type"
require "player"
require "assets"
require "board"
require "battle"
require "screen"
require "battle_screen"

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

function Game:init(basePath)
	self:loadMagicTypes()
	self.assets:init()
	
	for i, screen in pairs(self.screens) do
		screen:init()
	end
	
	love.window.setFullscreen(true, "desktop")
end

function Game:render()
	self.screens[self.state]:render(self)
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