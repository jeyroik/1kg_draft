local Mutator = require 'components/mutators/mutator'

MutatorEnemyHealth = Mutator:extend()

function MutatorEnemyHealth:new(config)
    self.amount = 0
    MutatorEnemyHealth.super.new(self, config)

    self.toEnemy = true
end

function MutatorEnemyHealth:apply(layerData, context)
    local target = self:getTarget()

    self:applyConfig(context)

    if self.amount < 0 then
        target:takeDamage(-self.amount)
    else
        target.health = target.health + self.amount
    end
end

return MutatorEnemyHealth