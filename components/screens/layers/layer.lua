local GameObject = require 'components/game/object'

Layer = GameObject:extend()

function Layer:new(config)
    self.mode = ''
    self.name = ''
    self.data = {}

    Layer.super.new(self, config)
end

return Layer