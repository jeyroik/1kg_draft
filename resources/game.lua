return {
    assets = {
        path = 'components/assets/assets',
        base_path = 'assets/',
        importers = {
            {path = 'components/magic/importer'},
            {path = 'components/mutators/importer'},
            {path = 'components/render/screens/battle/scenes/fight_before/importer'},
            {path = 'components/render/screens/battle/scenes/fight/importer'},
            {path = 'components/render/screens/battle/scenes/fight_after/importer'}
        }
    },
    profile = {
        name = 'Player1', health = 50, attack = 2, defense = 1,
        magic = {
            air = { power = 1, mana = 5 },
            water = { power = 1, mana = 5 },
            tree = { power = 1, mana = 5 },
            fire = { power = 1, mana = 5 },
            life = { power = 1, mana = 5 },
            air_ultra = { power = 1, mana = 2 },
            water_ultra = { power = 1, mana = 2 },
            tree_ultra = { power = 1, mana = 2 },
            fire_ultra = { power = 1, mana = 2 },
            life_ultra = { power = 1, mana = 1 }
        },
        skill = {
            active = {

            },
            passive = {

            }
        }
    },
    state = 'battle', -- choose start screen
    screens = {
        battle = {}
    }
}