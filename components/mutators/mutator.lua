local GameObject = require 'components/game/object'

Mutator = GameObject:extend()

function Mutator:new(config)
    self.toEnemy = false
    self.name = ''

    Mutator.super.new(self, config)
end

function Mutator:getTarget()
    local screen = game:getCurrentState()
    return self.toEnemy and screen:getNextPlayer() or screen:getCurrentPlayer()
end

return Mutator