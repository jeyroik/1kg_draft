local GameObject = require 'components/game/object'

Listeners = GameObject:extend()

function Listeners:new(config)
    self.items = {}

    Listeners.super.new(self, config)
end

function Listeners:add(eventName, listener, execTimes)
    execTimes = execTimes or -1

    self.items[eventName] = self.items[eventName] or {}

    table.insert(self.items[eventName], {
        dispatcher = listener,
        times = execTimes
    })
end

function Listeners:remove(eventName)
    self.items[eventName] = nil
end

function Listeners:get(eventName)
    if not self.items[eventName] then
        return {}
    end

    local items = {}

    for i, listener in pairs(self.items[eventName]) do
        if listener.times >= 1 then
            listener.times = listener.times - 1
            table.insert(items, listener.dispatcher)
        elseif listener.times == 0 then
            self.items[eventName][i] = nil
        else
            table.insert(items, listener.dispatcher)
        end
    end

    return items
end

return Listeners