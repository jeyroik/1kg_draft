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

function State:setActive(parent)
    self:initState(parent)
    self:onActive()
end

return State