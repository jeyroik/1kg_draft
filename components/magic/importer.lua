MagicImporter = AssetImporter:extend()

function MagicImporter:new()
    MagicImporter.super.new(self)

    self.misc = {
        magic = MagicAsset()
    }
end

return MagicImporter