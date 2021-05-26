return {
    alias = 'game.engine',
    assets = {
        path = 'components/assets/assets',
        base_path = 'assets/',
        importers = {
            { path = 'components/magic/importer'                                        },
            { path = 'components/mutators/importer'                                     },
            { path = 'components/characters/importer'                                   },
            { path = 'components/screens/mode/scenes/main/importer'                     },
            { path = 'components/screens/campaign_auth/scenes/main/importer'            },
            { path = 'components/screens/campaign_before_battle/scenes/main/importer'   },
            { path = 'components/screens/battle/scenes/main/importer'                   },
            { path = 'components/screens/battle/scenes/fight_after/importer'            },
            { path = 'components/screens/campaign_map/scenes/main/importer'             },
            { path = 'components/hooks/fullscreen/importer'                             }
        }
    },
    graphics = {
        width = 800,
        height = 600,
        onResize = 'change size',
        item = {
            width = 32,
            height = 32
        }
    },
    sources = {
        image = { path = 'components/sources/image' } -- game:newSource('image', {...})
    },
    profiles = {
        jeyroik = {
            path    = 'components/game/profile',
            name    = 'player@funcraft.ru',
            title   = 'Player1',
            description = 'Game creator',
            level   = 1,
            health  = 5,
            attack  = 1,
            defense = 0,
            conviction = 5,
            will = 10,
            captured = {},
            magic   = {
                air         = { power = 1, mana = 3 },
                water       = { power = 1, mana = 3 },
                tree        = { power = 1, mana = 3 },
                fire        = { power = 1, mana = 3 },
                life        = { power = 1, mana = 3 },
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
        }
    },
    __state__ = 'main', -- choose start screen
    __states__ = {
        main                   = { path = 'components/screens/mode'                   }, -- +
        campaign_auth          = { path = 'components/screens/campaign_auth'          }, -- +
        campaign_map           = { path = 'components/screens/campaign_map'           }, -- +
        campaign_before_battle = { path = 'components/screens/campaign_before_battle' }, -- + 

        arena_auth             = { path = 'components/screens/arena_auth'             }, -- + nog
        arena_before_battle    = { path = 'components/screens/arena_before_battle'    }, -- + nog
        
        battle                 = { path = 'components/screens/battle'                 }  -- + 
    }
}