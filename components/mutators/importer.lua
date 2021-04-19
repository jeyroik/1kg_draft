MutatorsImporter = AssetImporter:extend()

function MutatorsImporter:new()
    MutatorsImporter.super.new(self)

    self.mutators = {
        self_health = "components/mutators/self_health",
        enemy_health = "components/mutators/enemy_health",
        stone_converter = "components/mutators/stone_converter",
        magic_change = "components/mutators/magic_change"
    }
end

return MutatorsImporter