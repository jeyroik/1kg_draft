local Mutator = require 'components/mutators/mutator'

MutatorSelfHealth = Mutator:extend()

function MutatorSelfHealth:new(config)
    self.amount = 0
    MutatorSelfHealth.super.new(self, config)

    self.toEnemy = false
end

function MutatorSelfHealth:apply(layerData, context)
    local target = self:getTarget()

    self:applyConfig(context)

    target.health = target.health + self.amount

    if target.health < 0 then
        target.health = 0
    end
end

return MutatorSelfHealth