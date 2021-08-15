return {
    alias = 'game.engine',
    debugOn = true,
    tip = { path = 'components/dispatchers/tip' },
    ai = { path = 'components/game/ai'}, -- artificial intelligence
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
        },
        printSys = {
            grid = { isOn = true, isDraw = false },
            fps = { isOn = true, isDraw = true }
        }
    },
    resources = {
        path = 'components/game/resources',
        items = {
            board               = { path = 'components/sources/board' },
            button              = { path = 'components/sources/button' },
            button_default      = { path = 'components/sources/buttons/default' },
            card                = { path = 'components/sources/card' },
            character           = { path = 'components/models/character'},
            fx                  = { path = 'components/sources/fx' },
            icon                = { path = 'components/sources/icon' },
            image_pack          = { path = 'components/sources/image_pack' },
            image_titled        = { path = 'components/sources/image_titled' },
            image               = { path = 'components/sources/image' },
            magic_gem           = { path = 'components/sources/magic_gem' },
            map                 = { path = 'components/sources/map' },
            map_cell            = { path = 'components/sources/map/cell' },
            map_object          = { path = 'components/sources/map_object' },
            player              = { path = 'components/sources/player' },
            quads               = { path = 'components/sources/quads' },
            rectangle           = { path = 'components/sources/rectangle' },
            source_positioned   = { path = 'components/sources/spurce_positioned' },
            stone               = { path = 'components/sources/stone' },
            text_overlay        = { path = 'components/sources/text_overlay' },
            text                = { path = 'components/sources/text'},
            window              = { path = 'components/sources/window' },
            window_header       = { path = 'components/sources/window/header' },
            window_body         = { path = 'components/sources/window_body' }
        }
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