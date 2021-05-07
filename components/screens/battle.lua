local Data = require "components/screens/battle/data"
local Screen = require "components/screens/screen"

Battle = Screen:extend()

function Battle:new(config)
	config.initializer = config.initializer or 'components/screens/battle/initializer'
	Battle.super.new(self, config)

	self:setDataLayer(Data(config))
end

function Battle:getCurrentPlayer()
	return self.layers.data:getCurrentPlayer()
end

function Battle:getNextPlayer()
	return self.layers.data:getNextPlayer()
end

return Battle