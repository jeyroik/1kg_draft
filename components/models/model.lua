local GameObject = require 'components/game/object'

Model = GameObject:extend()

function Model:new(config)
    self.name = ''
    Model.super.new(self, config)
end

return Model