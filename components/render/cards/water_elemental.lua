require "components/skills/magic_change"

CardWaterElemental = Card:extend()

function CardWaterElemental:new(config)
    config = config or {}
    config.path = 'components/render/cards/water_elemental'
    config.name = 'Water elemental'
    config.description = 'In the age of Tratabor fury water elemental was born'
    config.health = 2
    config.attack = 1
    config.defense = 2
    config.skill = {
        active = SkillMagicChange({
            amount = 3,
            magicParameter = 'mana',
            toEnemy = false,
            cost = {
                air = 4,
                water = 3,
                tree = 2,
                fire = 1
            }
        }),
        passive = {}
    }
    config.avatar = config.avatar or {
        path = 'chars',
        frame = 35
    }

    CardWaterElemental.super.new(self, config)
end

return CardWaterElemental