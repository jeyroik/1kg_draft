MutatorSelfHealth = Mutator:extend()

MutatorCollection.registerMutator(
    'self_health',
    MutatorSelfHealth({
        name = 'self_health',
        toEnemy = false
    })
)

function MutatorSelfHealth:new(config)
    self.amount = 0
    MutatorSelfHealth.super.new(self, config)
end

function MutatorSelfHealth:apply(game, context)
    local target = self:getTarget(game)

    self:applyConfig(context)

    target.health = target.health + self.amount
end