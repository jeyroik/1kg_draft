require "components/skills/stone_convert"

CardLifeElemental = Card:extend()

function CardLifeElemental:new(config)
    config = config or {}
    config.path = 'components/render/cards/life_elemental'
    config.name = 'Life elemental'
    config.description = 'In the age of Tratabor fury life elemental was born'
    config.health = 7
    config.attack = 2
    config.defense = 2
    config.skill = {
        active = SkillStoneConvert({
            target = 4,
            mustBe = 16,
            cost = {
                air = 4,
                life = 1
            }
        }),
        passive = {}
    }
    config.avatar = config.avatar or 5

    CardLifeElemental.super.new(self, config)
end

return CardLifeElemental