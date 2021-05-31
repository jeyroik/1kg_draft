local GameObject = require 'components/game/object'

Event = GameObject:extend()

function Event:new(config)
    self.name = ''
    self.target = ''
    self.args = {}

    Event.super.new(self, config)
end

return Event