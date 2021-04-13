require "components/game/initializer"
require "components/game/printer"
require "components/game/uuid"
require "components/game/config"

GameObject = Object:extend()
GameObject:implement(Config)
GameObject:implement(Printer)
GameObject:implement(Uuid)
GameObject:implement(Initializer)

function GameObject:new(config)
    self.can_be_exported = true
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

function GameObject:export(obj)
    obj = obj or self
    local result = {}

    for k,v in pairs(obj) do
        if type(v) == 'table' then
            if v.can_be_exported then
                v = v:export()
            end
        end

        result[k] = v
    end

    return result
end