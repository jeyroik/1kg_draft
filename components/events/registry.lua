local GameObject = require 'components/game/object'
local Listeners  = require 'components/events/listeners'

EventRegistry = GameObject:extend()

function EventRegistry:new(config)
    self.events    = {}
    self.listeners = Listeners()

    EventRegistry.super.new(self, config)
end

function EventRegistry:setEvent(name, ...)
    self.events[name] = Event({...})
end

function EventRegistry:getEvent(name)
    return self.events[name]
end

function EventRegistry:on(eventName, listener, execTimes)
    self.listeners:add(eventName, listener, execTimes)
end

function EventRegistry:riseEvent(eventName, ...)
    self:setEvent('before.'..eventName, ...)
    self:runEvent('before.'..eventName, ...)
    
    self:setEvent(eventName, ...)
    self:runEvent(eventName)

    self:setEvent('after.'..eventName, ...)
    self:runEvent('after.'..eventName)
end

function EventRegistry:runEvent(eventName)
    local listeners = self.listeners:getListeners(eventName)
    for i, listener in pairs(listeners) do
        if type(listener) == 'table' then
            listener:on(eventName, self:getEvent(eventName))
        else
            listener(eventName, self:getEvent(eventName))
        end
    end
end

return EventRegistry