LandscapeMainImporter = AssetImporter:extend()

function LandscapeMainImporter:new()
    LandscapeMainImporter.super.new(self)

    self.images = {

    }

    self.maps = {
        main = {
            path = 'map_0.png',
            columns = 20,
            rows = 8,
            scale = 2,
            layers = {
                terrain = {
                    {72, 72, 72, 72, 72, 72, 72, 72, 85, 88, 88, 87},
                    {29, 72, 85, 86, 86, 86, 87, 72, 89, 85, 86, 89}
                },
                objects = {
                    {0, 132, 110, 110, 110, 110, 110, 130},
                    {0, 109, 0, 0, 0, 0, 0, 109, 0}
                },
                characters = {
                    {},
                    {0, 0, 0, 1}
                }
            },
            renderPath = {'terrain', 'objects', 'characters'}
        }
    }
    self.quads = {

    }

    self.cursors = {
        hand = "hand"
    }

    self.buttons = {

    }

    --self.menu = {} --pack of buttons?
end

return LandscapeMainImporter