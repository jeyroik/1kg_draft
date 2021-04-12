require "components/skills/self_health_inc"

CardTreeElemental = Card:extend()

function CardTreeElemental:new(config)
    config = config or {}
    config.name = 'Tree elemental'
    config.description = 'In the age of Tratabor fury tree elemental was born'
    config.health = 6
    config.attack = 0
    config.defense = 2
    config.skill = {
        active = SkillSelfHealthInc({
            amount = 1,
            cost = {
                tree = 2
            }
        }),
        passive = {}
    }
    config.avatar = config.avatar or 30

    CardFireElemental.super.new(self, config)
end