local Data = require "components/screens/mode/data"
local Screen = require "components/screens/screen"

Mode = Screen:extend()

function Mode:new(config)
	self.name = 'screen.mode'

	Mode.super.new(self, config)
end

function Mode:initState()
	self:setDataLayer(Data(config))
	self.__state__ = 'main'
    self.__states__ = {
        { alias = 'main', path = 'components/screens/mode/scenes/main' }
    }
	Mode.super.initState(self)
end

return Mode