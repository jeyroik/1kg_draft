local Skill = require 'components/skills/skill'

TrophiGold = Skill:extend()

function TrophiGold:new(config)
    self.min = 0
    self.max = 0

    config.scope = config.scope or 'map'

    TrophiGold.super.new(self, config)

    self.name = 'skill_trophi_gold'
    self.description = 'Allow to get gold for a battle'
    self.mutators = {
        property_random_inc = {min = self.min, max = self.max, property = {main = 'valuable', sub = 'gold'}}
    }
end

return TrophiGold