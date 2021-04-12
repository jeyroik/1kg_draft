require "components/initializer"
require "components/printer"
require "components/uuid"
require "components/config"

GameObject = Object:extend()
GameObject:implement(Config)
GameObject:implement(Printer)
GameObject:implement(Uuid)
GameObject:implement(Initializer)

function GameObject:new(config)
    self.__state__ = ''
    self.__states__ = {}

    self:applyConfig(config)
end

function GameObject:initStates()
    self:initializeMany('__states__')
end

function GameObject:changeStateTo(stateName)
    self.__state__ = stateName
    local current = self:getCurrentState()
    current:init(self)
end

function GameObject:getCurrentState()
    return self.__states__[self.__state__]
end