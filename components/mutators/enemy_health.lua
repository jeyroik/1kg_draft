MutatorEnemyHealth = Mutator:extend()

function MutatorEnemyHealth:new(config)
    self.amount = 0
    MutatorEnemyHealth.super.new(self, config)

    self.toEnemy = true
end

function MutatorEnemyHealth:apply(layerData, context)
    local target = self:getTarget()

    self:applyConfig(context)

    target.health = target.health + self.amount

    if target.health < 0 then
        target.health = 0
    end
end

return MutatorEnemyHealth