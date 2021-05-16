local Screen = require "components/screens/screen"

ArenaAuth = Screen:extend()

function ArenaAuth:new(config)
	ArenaAuth.super.new(self, config)
end

function ArenaAuth:initState(...)
	self.__state__ = 'main'
    self.__states__ = {
        main = { path = 'components/screens/arena_auth/scenes/main' }
    }
	ArenaAuth.super.initState(self, ...)
end

return ArenaAuth