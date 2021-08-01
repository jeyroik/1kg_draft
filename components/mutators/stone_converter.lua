local Mutator = require 'components/mutators/mutator'

MutatorStoneConverter = Mutator:extend()

function MutatorStoneConverter:new(config)
    self.target = 0
    self.mustBe = 0

    MutatorStoneConverter.super.new(self, config)
end

function MutatorStoneConverter:apply(layerData, context)
    self:applyConfig(context)

    for _, columns in pairs(layerData.board.cells) do
        for _, stone in pairs(columns) do
            if stone.magic == self.target then
                stone.magic = self.mustBe
            end
        end
    end
end

return MutatorStoneConverter