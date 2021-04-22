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

    self.cards = {
         fire_elemental = 'components/render/cards/fire_elemental' ,
         life_elemental = 'components/render/cards/life_elemental' ,
         tree_elemental = 'components/render/cards/tree_elemental' ,
         water_elemental = 'components/render/cards/water_elemental'
    }
end

return CardsImporter