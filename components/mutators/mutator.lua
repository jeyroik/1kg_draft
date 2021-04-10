Mutator = Object:extend()
Mutator:implement(Config)
Mutator:implement(Printer)

function Mutator:new(config)
    self.toEnemy = false
    self.name = ''

    self:applyConfig(config)
end

function Mutator:getTarget(game)
    local layer = game:getCurrentScreenLayerData()
    return self.toEnemy and layer:getNextPlayer() or layer:getCurrentPlayer()
end