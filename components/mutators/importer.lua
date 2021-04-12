MutatorsImporter = AssetImporter:extend()

function MutatorsImporter:new()
    MutatorsImporter.super.new(self)

    self.mutators = {
        self_health = "components/mutators/self_health",
        enemy_health = "components/mutators/enemy_health"
    }
end

return MutatorsImporter