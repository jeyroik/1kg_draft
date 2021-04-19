require "components/skills/self_health_inc"

CardTreeElemental = Card:extend()

function CardTreeElemental:new(config)
    config = config or {}
    config.path = 'components/render/cards/tree_elemental'
    config.name = 'Tree elemental'
    config.description = 'In the age of Tratabor fury tree elemental was born'
    config.health = 6
    config.attack = 0
    config.defense = 2
    config.skill = {
        active = SkillSelfHealthInc({
            amount = 3,
            cost = {
                tree = 2
            }
        }),
        passive = {}
    }
    config.avatar = config.avatar or {
        path = 'chars',
        frame = 30
    }

    CardFireElemental.super.new(self, config)
end

return CardTreeElemental