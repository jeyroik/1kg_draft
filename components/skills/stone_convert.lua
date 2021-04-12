SkillStoneConvert = Skill:extend()

function SkillStoneConvert:new(config)
    self.target = 0
    self.mustBe = 0

    SkillSelfHealthInc.super.new(self, config)

    local magic = game.assets:getMisc('magicTypes')
    local targetType = 'c'..self.target
    local mustBeType = 'c'..self.mustBe

    self.name = 'skill_stone_convert'
    self.description = 'Convert all stones '..magic[targetType].name..' to '..magic[mustBeType].name
    self.mutators = {
        stone_converter = {target = self.target, mustBe = self.mustBe}
    }
end