local AssetImporter = require 'components/assets/importers/importer'
local MagicAsset    = require 'components/assets/asset_magic'

MagicImporter = AssetImporter:extend()

function MagicImporter:new()
    MagicImporter.super.new(self)

    self.misc = {
        magic = MagicAsset()
    }
end

return MagicImporter