local AssetImporter = require 'components/assets/importers/importer'
local AssetMagic    = require 'components/assets/magic'

Importer = AssetImporter:extend()

function Importer:new()
    Importer.super.new(self)

    self.images = {
        turn = { path = "turn.png" },
        turn_enemy = { path = "turn_enemy.png" }
    }
    self.fxs = {
        merge = { path = "merge.wav", mode = "static" },
        damage = { path = "damage.wav", mode = "static" },
        move = { path = "move.wav", mode = "static", volume = 0.1 },
        skill = { path = "skill.wav", mode = "static" },
        skill_not = { path = "skill_not.wav", mode = "static", volume = 0.5 },
    }
    self.imagesPacks = { 
        magic = {
            deck        = {path = 'deck.png'},
            death       = {path = 'death.png'},
            death_ultra = {path = 'death_ultra.png'}
        } 
    }

    local magic = AssetMagic()
    local order = magic.namesOrder
    for _,name in pairs(order) do
        self.imagesPacks.magic[name] = {
            path = name .. ".png"
        }
    end
end

return Importer