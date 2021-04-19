SkillMagicChange = Skill:extend()

function SkillMagicChange:new(config)
    self.toEnemy = false
    self.amount = 0
    self.magicParameter = ''
    self.magicName = ''

    SkillMagicChange.super.new(self, config)

    local magic = game.assets:getMisc('magic')
    local target = magic:getByName(self.magicName)
    local to = self.toEnemy and 'enemy' or 'self'

    self.name = 'skill_magic_change'
    self.description = 'Change '..to..' '..target:getTitle()..' magic '..self.magicParameter..' by '..self.amount
    self.mutators = {
        magic_change = {
            toEnemy = self.toEnemy,
            amount = self.amount,
            magicParameter = self.magicParameter,
            magicName = self.magicName
        }
    }
end