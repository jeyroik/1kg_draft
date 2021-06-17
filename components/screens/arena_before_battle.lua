local Screen = require "components/screens/screen"

ArenaBeforeBattle = Screen:extend()

function ArenaBeforeBattle:new(config)
    config.name = 'arena_before_battle'

	ArenaBeforeBattle.super.new(self, config)
end

function ArenaBeforeBattle:initState(...)
	self.__state__ = 'main'
    self.__states__ = {
        main = { path = 'components/screens/arena_before_battle/scenes/main' }
    }
	ArenaBeforeBattle.super.initState(self, ...)
end

return ArenaBeforeBattle