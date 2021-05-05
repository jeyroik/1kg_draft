ModelPlayer = ModelCharacter:extend()

function ModelPlayer:new(config)
    config = config or {}
    
    self.name = ''
    self.magic = {
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
    }

    self.characters = {}

    config.health = config.health or 5
    config.attack = config.attack or 1

    ModelPlayer.super.new(self, config)
end