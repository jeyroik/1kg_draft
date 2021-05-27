local Skill = require 'components/skills/skill'

TrophiExperience = Skill:extend()

function TrophiExperience:new(config)
    self.min = 0
    self.max = 0

    config.scope = config.scope or 'map'

    TrophiExperience.super.new(self, config)

    self.name = 'skill_trophi_experience'
    self.description = 'Allow to get experience for a battle'
    self.mutators = {
        property_random_inc = {min = self.min, max = self.max, property = 'experience'}
    }
end

return TrophiExperience