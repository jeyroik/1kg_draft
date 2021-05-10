local GameObject = require 'components/game/object'

Mutator = GameObject:extend()

function Mutator:new(config)
    self.toEnemy = false
    self.name = ''

    Mutator.super.new(self, config)
end

function Mutator:getTarget()
    local layer = game:getCurrentScreenLayerData()
    return self.toEnemy and layer:getNextPlayer() or layer:getCurrentPlayer()
end

return Mutator