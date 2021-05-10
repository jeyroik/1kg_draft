local GameObject = require 'components/game/object'

State = GameObject:extend()

function State:new(config)
    self.stateInitialized = false

    State.super.new(self, config)
end

function State:initState(...)
end

function State:onActive(...)
end

function State:setActive(...)
    if not self.stateInitialized then
        self:initState(...)
        self.stateInitialized = true

        self:setActive(...)
    else
        self:onActive()
    end
end

return State