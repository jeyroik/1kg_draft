MutatorEnemyHealth = Mutator:extend()

MutatorCollection.registerMutator(
    'enemy_health',
    MutatorEnemyHealth({
        name = 'enemy_health',
        toEnemy = true
    })
)

function MutatorEnemyHealth:new(config)
    self.amount = 0
    MutatorEnemyHealth.super.new(self, config)
end

function MutatorEnemyHealth:apply(game, context)
    local target = self:getTarget(game)

    self:applyConfig(context)

    target.health = target.health + self.amount
end