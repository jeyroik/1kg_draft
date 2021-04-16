require "components/skills/enemy_health_dec"

CardFireElemental = Card:extend()

function CardFireElemental:new(config)
    config = config or {}
    config.path = 'components/render/cards/fire_elemental'
    config.name = 'Fire elemental'
    config.description = 'In the age of Tratabor fury fire elemental was born'
    config.health = 5
    config.attack = 1
    config.defense = 0
    config.skill = {
        active = SkillEnemyHealthDec({
            amount = 5,
            cost = {
                fire = 2
            }
        }),
        passive = {}
    }
    config.avatar = config.avatar or {
        path = 'chars',
        frame = 31
    }

    CardFireElemental.super.new(self, config)
end

return CardFireElemental