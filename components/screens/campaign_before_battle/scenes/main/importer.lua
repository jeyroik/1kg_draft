local AssetImporter = require "components/assets/importers/importer"

Importer = AssetImporter:extend()

function Importer:new()
    Importer.super.new(self)

    self.quads = {
        chars = {
            path = 'chars.jpg',
            rows = 5,
            columns = 7
        }
    }
end

return Importer