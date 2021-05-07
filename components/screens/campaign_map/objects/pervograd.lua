Pervograd = Object:extend()
Pevograd:implement(Config)

function Pervograd:new(config)
    self:applyConfig(config)
end

function Pervograd:run(screen, scene)
    game.assets:getCursor('hand'):reset()
    game:changeStateTo(
        'campaign_before_battle',
        { 
            player1 = game.profile,
            player2 = {
                name = 'elemental',
                title = 'Elemental',
                description = 'Something very strange',
                isHuman = false,
                level = 1,
                health = 10,
                attack = 1,
                defense = 0,
                magic = {
                    air         = { power = 1, mana = 3 },
                    water       = { power = 1, mana = 3 },
                    tree        = { power = 1, mana = 3 },
                    fire        = { power = 1, mana = 3 },
                    life        = { power = 1, mana = 3 },
                    air_ultra   = { power = 1, mana = 3 },
                    water_ultra = { power = 1, mana = 2 },
                    tree_ultra  = { power = 1, mana = 2 },
                    fire_ultra  = { power = 1, mana = 2 },
                    life_ultra  = { power = 1, mana = 1 }
                },
                skill = {
                    active = {

                    },
                    passive = {}
                },
                avatar = {
                    path = 'chars',
                    frame = 10
                },
                characters = {}
            } 
        }
    )
end