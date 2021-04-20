MutatorMagicChange = Mutator:extend()

function MutatorMagicChange:new(config)
    self.amount = 0
    self.magicParameter = ''
    self.magicName = ''
    self.toEnemy = false

    MutatorMagicChange.super.new(self, config)
end

function MutatorMagicChange:apply(layerData, context)
    local target = self:getTarget()

    self:applyConfig(context)

    love.filesystem.append('log.txt', '\nMutatorMagicChange:apply() - change '
            ..self.magicName..' '..self.magicParameter..' by '..self.amount
    )
    target:incMagicParameter(self.magicName, self.magicParameter, self.amount)
end

return MutatorMagicChange