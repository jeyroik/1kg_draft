local Mutator = require 'components/mutators/mutator'

MutatorPropertyRandomInc = Mutator:extend()

function MutatorPropertyRandomInc:new(config)
    self.min = 0
    self.max = 0
    self.property = {}

    MutatorSelfHealth.super.new(self, config)
end

function MutatorPropertyRandomInc:apply(screen, context)
    self:applyConfig(context)

    local propInc = love.random(self.min, self.max)

    if self.property is 'string' then
        game.profile[self.property] = game.profile[self.property] + propInc
    else
        game.profile[self.property.main][self.property.sub] = game.profile[self.property.main][self.property.sub] + propInc
    end

    return propInc
end

return MutatorPropertyRandomInc