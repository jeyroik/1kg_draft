local Skill = require "components/skills/skill"

SkillEnemyHealthDec = Skill:extend()

function SkillEnemyHealthDec:new(config)
    self.amount = 0
    SkillEnemyHealthDec.super.new(self, config)

    self.name = 'skill_enemy_health_dec'
    self.description = 'Decrease enemy health by '..self.amount
    self.mutators = {
        enemy_health = {amount = -self.amount}
    }
end

return SkillEnemyHealthDec