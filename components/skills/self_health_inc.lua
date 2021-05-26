local Skill = require "components/skills/skill"

SkillSelfHealthInc = Skill:extend()

function SkillSelfHealthInc:new(config)
    self.amount = 0
    SkillSelfHealthInc.super.new(self, config)

    self.name = 'skill_self_health_inc'
    self.description = 'Increase self health by '..self.amount
    self.mutators = {
        self_health = {amount = self.amount}
    }
end

return SkillSelfHealthInc