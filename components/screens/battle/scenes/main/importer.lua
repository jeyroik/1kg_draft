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
    self.imagesPacks = { gems = {} }

    for i=0, 12 do
        self.imagesPacks.gems['c'..math.pow(2, i)] = {
            path = "gem" .. math.pow(2, i) .. ".png"
        }
    end
end

return Importer