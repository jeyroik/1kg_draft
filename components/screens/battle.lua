local Data   = require "components/screens/battle/data"
local Screen = require "components/screens/screen"

Battle = Screen:extend()

function Battle:new(config)
	Battle.super.new(self, config)
end

function Battle:initState(...)
	self:setDataLayer(Data(config))
	self.__state__ = 'main'
	self.__states__ = {
		{ alias = 'main',        path = 'components/screens/battle/scenes/main'         },
		{ alias = 'fight_after', path = 'components/screens/battle/scenes/fight_after'  }
	}
	Battle.super.initState(self, ...)
end

function Battle:getCurrentPlayer()
	return self.layers.data:getCurrentPlayer()
end

function Battle:getNextPlayer()
	return self.layers.data:getNextPlayer()
end

return Battle