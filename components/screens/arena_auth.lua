local Data = require "components/screens/arena_auth/data"
local Screen = require "components/screens/screen"

ArenaAuth = Screen:extend()

function ArenaAuth:new(config)
	config.initializer = config.initializer or 'components/screens/arena_auth/initializer'
	ArenaAuth.super.new(self, config)

	self:setDataLayer(Data(config))
end

return ArenaAuth