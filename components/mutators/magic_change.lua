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

    target.magic[self.magicName][self.magicParameter] = target.magic[self.magicName][self.magicParameter] + self.amount

    if target.magic[self.magicName][self.magicParameter] < 0 then
        target.magic[self.magicName][self.magicParameter] = 0
    end
end

return MutatorMagicChange