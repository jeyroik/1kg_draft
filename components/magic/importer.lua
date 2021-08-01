local AssetImporter = require 'components/assets/importers/importer'
local AssetMagic    = require 'components/assets/magic'

MagicImporter = AssetImporter:extend()

function MagicImporter:new()
    MagicImporter.super.new(self)

    self.misc = {
        magic = AssetMagic()
    }
end

return MagicImporter