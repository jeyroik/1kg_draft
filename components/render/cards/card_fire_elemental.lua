CardFireElemental = Card:extend()

function CardFireElemental:new()
    CardFireElemental.super.new(self, {
        name = 'Fire elemental',
        description = 'In the age of Tratabor fury fire elemental was born',
        health = 5,
        attack = 1,
        defense = 0,
        skill = {
            active = SkillEnemyHealthDec({
                amount = 1,
                cost = {
                    fire = 2
                }
            }),
            passive = {}
        },
        avatar = 3
    })
end