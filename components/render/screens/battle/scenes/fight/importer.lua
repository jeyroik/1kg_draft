BattleFightImporter = AssetImporter:extend()

function BattleFightImporter:new()
    BattleFightImporter.super.new(self)

    self.fxs = {
        merge = { path = "merge.wav", mode = "static" },
        damage = { path = "damage.wav", mode = "static" },
        move = { path = "move.wav", mode = "static", volume = 0.1 },
        skill = { path = "skill.wav", mode = "static" },
        skill_not = { path = "skill_not.wav", mode = "static", volume = 0.5 },
    }
    self.imagesPacks = { gems = {} }
    self.quads = {
        chars = {
            path = 'chars.jpg',
            columns = 7,
            rows = 5
        }
    }

    for i=1, 12 do
        self.imagesPacks.gems['c'..math.pow(2, i)] = "gem"..math.pow(2, i)..".png"
    end
end

return BattleFightImporter