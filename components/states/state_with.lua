local State = require 'components/states/state'

StateWith = State:extend()
StateWith:implement(Initializer)

function StateWith:new(config)
    self.__state__  = 'main'
    self.__states__ = {}

    StateWith.super.new(self, config)
end

function StateWith:init(...)
    self:initializeMany('__states__', true)
end

function StateWith:changeStateTo(stateName, ...)
    if not self.__states__[stateName] then
        return
    end

    self.__state__ = stateName
    self.__states__[stateName]:setActive(self, ...)
end

function StateWith:getCurrentState()
    return self:getState(self.__state__)
end

function StateWith:getState(name)
    return self.__states__[name]
end

return StateWith