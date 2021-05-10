local Data   = require "components/screens/arena_before_battle/data"
local Screen = require "components/screens/screen"

ArenaBeforeBattle = Screen:extend()

function ArenaBeforeBattle:new(config)
	ArenaBeforeBattle.super.new(self, config)
end

function ArenaBeforeBattle:initState(...)
	self:setDataLayer(Data(config))
	self.__state__ = 'main'
    self.__states__ = {
        { alias = 'main', path = 'components/screens/arena_before_battle/scenes/main' }
    }
	ArenaBeforeBattle.super.initState(self, ...)
end

return ArenaBeforeBattle