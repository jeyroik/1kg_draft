local GameObject = require 'components/game/object'
local Listeners  = require 'components/events/listeners'
local Event      = require 'components/events/event'

EventRegistry = GameObject:extend()

function EventRegistry:new(config)
    self.events    = {}
    self.listeners = Listeners()

    EventRegistry.super.new(self, config)
end

function EventRegistry:hasEvent(name)
    return self.listeners:has(name)
end

function EventRegistry:setEvent(name, args)
    self.events[name] = Event({args = args})
end

function EventRegistry:getEvent(name)
    return self.events[name]
end

function EventRegistry:on(eventName, listener, execTimes)
    self.listeners:add(eventName, listener, execTimes)
end

function EventRegistry:riseEvent(eventName, args)    
    self:setEvent('before.'..eventName, args)
    self:runEvent('before.'..eventName, args)
    
    self:setEvent(eventName, args)
    self:runEvent(eventName)

    self:setEvent('after.'..eventName, args)
    self:runEvent('after.'..eventName)
end

function EventRegistry:runEvent(eventName)
    local listeners = self.listeners:get(eventName)
    local event = self:getEvent(eventName)

    for i, listener in pairs(listeners) do
        if type(listener) == 'table' then
            listener:on(eventName, event)
        else
            listener(eventName, event)
        end
    end
end

function EventRegistry:flush(eventName)
    self.listeners:remove(eventName)
end

function EventRegistry:flushLike(text)
    for name, event in pairs(self.events) do
        if name:find(text) then
            self:flush(name)
        end
    end
end

return EventRegistry