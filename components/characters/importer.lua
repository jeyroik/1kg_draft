local AssetImporter = require 'components/assets/importers/importer'

CharactersImporter = AssetImporter:extend()

function CharactersImporter:new()
    CharactersImporter.super.new(self)

    self.characters = {
        fire_elemental = {
            name = 'Fire elemental',
            title = 'Fire elemental',
            description = 'In the age of Tratabor fury fire elemental was born',
            health = 5,
            attack = 1,
            defense = 0,
            level = 1,
            avatar = {
                path = 'chars',
                frame = 31,
                part = 3
            },
            skill = {
                active = {
                    path = 'components/skills/enemy_health_dec',
                    amount = 3,
                    cost = {
                        fire = 2
                    }
                },
                passive = {}
            },
            pointable = true
        },
        water_elemental = {
            name = 'Water elemental',
            title = 'Water elemental',
            description = 'In the age of Tratabor fury water elemental was born',
            health = 2,
            attack = 1,
            defense = 2,
            level = 1,
            avatar = {
                path = 'chars',
                frame = 35,
                part = 3
            },
            skill = {
                active = {
                    path = 'components/skills/magic_change',
                    amount = 3,
                    magicParameter = 'mana',
                    toEnemy = false,
                    cost = {
                        air = 4,
                        water = 3,
                        tree = 2,
                        fire = 1
                    }
                },
                passive = {}
            },
            pointable = true
        },
        tree_elemental = {
            name = 'Tree elemental',
            title = 'Tree elemental',
            description = 'In the age of Tratabor fury tree elemental was born',
            health = 6,
            attack = 0,
            defense = 2,
            level = 1,
            avatar = {
                path = 'chars',
                frame = 30,
                part = 3
            },
            skill = {
                active = {
                    path = 'components/skills/self_health_inc',
                    amount = 3,
                    cost = {
                        tree = 2
                    }
                },
                passive = {}
            },
            pointable = true
        },
        life_elemental = {
            name = 'Life elemental',
            title = 'Life elemental',
            description = 'In the age of Tratabor fury life elemental was born',
            health = 7,
            attack = 2,
            defense = 2,
            level = 1,
            avatar = {
                path = 'chars',
                frame = 5,
                part = 3
            },
            skill = {
                active = {
                    path = 'components/skills/stone_convert',
                    target = 4,
                    mustBe = 16,
                    cost = {
                        air = 4,
                        life = 1
                    }
                },
                passive = {}
            },
            pointable = true
        }
    }
end

return CharactersImporter