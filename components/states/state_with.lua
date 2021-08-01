local State = require 'components/states/state'

StateWith = State:extend()
StateWith:implement(Initializer)

function StateWith:new(config)
    self.__state__  = 'main'
    self.__states__ = {}

    StateWith.super.new(self, config)
end

function StateWith:changeStateTo(stateName, context)
    if not self.__states__[stateName] then
        return
    end

    self.__state__ = stateName

    local statePath = self.__states__[stateName].path
    local state = require(statePath)
    
    context = context or {}

    self.__states__[stateName] = state(context)
    self.__states__[stateName].path = statePath
    self.__states__[stateName]:setActive(self)

    self:stateChanged()
end

function StateWith:getCurrentState()
    return self:getState(self.__state__)
end

function StateWith:getState(name)
    return self.__states__[name]
end

function StateWith:stateChanged()
end

return StateWith