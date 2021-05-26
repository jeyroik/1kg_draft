local AssetImporter = require 'components/assets/importers/importer'

BattleFightAfterImporter = AssetImporter:extend()

function BattleFightAfterImporter:new()
    BattleFightAfterImporter.super.new(self)

    self.fxs = {
        the_end = { path = "the_end.wav", mode = "static"}
    }
    self.images = {
        theEnd = { path = 'notice.png' }
    }
end

return BattleFightAfterImporter