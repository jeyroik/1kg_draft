CardsImporter = AssetImporter:extend()

function CardsImporter:new()
    CardsImporter.super.new(self)

    self.quads = {
        chars = {
            path = 'chars.jpg',
            columns = 7,
            rows = 5
        }
    }
end

return CardsImporter