SkillStoneConvert = Skill:extend()

function SkillStoneConvert:new(config)
    self.target = 0
    self.mustBe = 0

    SkillSelfHealthInc.super.new(self, config)

    local magic = game.assets:getMisc('magic')
    local target = magic:getByType('c'..self.target)
    local mustBe = magic:getByType('c'..self.mustBe)

    self.name = 'skill_stone_convert'
    self.description = 'Convert all stones '..target.name..' to '..mustBe.name
    self.mutators = {
        stone_converter = {target = self.target, mustBe = self.mustBe}
    }
end