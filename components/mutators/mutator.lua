Mutator = Object:extend()
Mutator:implement(Config)

function Mutator:new(config)
    self.toEnemy = false
    self.name = ''

    self:applyConfig(config)
end

function Mutator:getTarget(game)
    return self.toEnemy
            and game.screens.battle.battle:getNextPlayer()
            or game.screens.battle.battle:getCurrentPlayer()
end