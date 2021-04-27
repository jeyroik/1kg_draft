return {
    alias = 'game.engine',
    assets = {
        path = 'components/assets/assets',
        base_path = 'assets/',
        importers = {
            { path = 'components/magic/importer'                                     },
            { path = 'components/mutators/importer'                                  },
            { path = 'components/render/cards/importer'                              },
            { path = 'components/render/screens/battle/scenes/fight_before/importer' },
            { path = 'components/render/screens/battle/scenes/fight_cards/importer'  },
            { path = 'components/render/screens/battle/scenes/fight/importer'        },
            { path = 'components/render/screens/battle/scenes/fight_after/importer'  },
            { path = 'components/hooks/render/after/fullscreen_importer'             },
            { path = 'components/render/screens/landscape/scenes/main/importer'      }
        }
    },
    profile = {
        path    = 'components/game/profile',
        name    = 'Player1', 
        health  = 50,
        attack  = 2,
        defense = 1,
        magic   = {
            air         = { power = 1, mana = 5 },
            water       = { power = 1, mana = 5 },
            tree        = { power = 1, mana = 5 },
            fire        = { power = 1, mana = 5 },
            life        = { power = 1, mana = 5 },
            air_ultra   = { power = 1, mana = 2 },
            water_ultra = { power = 1, mana = 2 },
            tree_ultra  = { power = 1, mana = 2 },
            fire_ultra  = { power = 1, mana = 2 },
            life_ultra  = { power = 1, mana = 1 }
        },
        skill = {
            active = {

            },
            passive = {

            }
        }
    },
    __state__ = 'landscape', -- choose start screen
    __states__ = {
        { alias = 'battle',    path = 'components/render/screens/screen_battle'    },
        { alias = 'landscape', path = 'components/render/screens/screen_landscape' }
    },
    screens = {
        battle = {},
        landscape = {}
    }
}