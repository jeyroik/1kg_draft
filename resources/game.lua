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
    state = 'battle', -- choose start screen
    screens = {
        battle = {
            players = {
                { name = 'Player1', x = 270, y = 250, health = 50, attack = 2, defense = 1, isHuman = true },
                { name = 'Player2', x = 1540, y = 250, health = 50, attack = 2, defense = 1 }
            }
        }
    }
}