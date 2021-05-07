local Data = require "components/screens/arena_before_battle/data"
local Screen = require "components/screens/screen"

ArenaBeforeBattle = Screen:extend()

function ArenaBeforeBattle:new(config)
	config.initializer = config.initializer or 'components/screens/arena_before_battle/initializer'
	ArenaBeforeBattle.super.new(self, config)

	self:setDataLayer(Data(config))
end

return ArenaBeforeBattle