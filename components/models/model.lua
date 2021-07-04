local GameObject = require 'components/game/object'

Model = GameObject:extend()

function Model:new(config)
    Model.super.new(self, config)
end

return Model