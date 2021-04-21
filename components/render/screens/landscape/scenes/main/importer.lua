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
                constructions = {
                    {0, 132, 110, 110, 110, 110, 110, 130},
                    {0, 109, 0, 0, 0, 0, 0, 109, 0}
                },
                characters = {
                    {},
                    {0, 0, 0, 1}
                }
            },
            objects = {
                farm = {
                    layer = 'terrain',
                    schema = {
                        { 1,2 },{ 1,3 },{ 1,4 },{ 1,5 },{ 1,6 },{ 1,7 },{ 1,8 },
                        { 2,2 },{ 2,3 },{ 2,4 },{ 2,5 },{ 2,6 },{ 2,7 },{ 2,8 }
                    }
                }
            },
            renderPath = {'terrain', 'constructions', 'characters'}
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