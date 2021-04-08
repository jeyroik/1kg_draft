SkillEnemyHealthDec = Skill:extend()

function SkillEnemyHealthDec:new(config)
    self.amount = 0
    SkillEnemyHealthDec.super.new(self, config)

    self.mutators = {
        enemy_health = {amount = self.amount}
    }
end