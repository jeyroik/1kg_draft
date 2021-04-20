LandscapeMainImporter = AssetImporter:extend()

function LandscapeMainImporter:new()
    LandscapeMainImporter.super.new(self)

    self.images = {

    }

    self.quads = {
        map = {
            path = 'map_0.png',
            columns = 20,
            rows = 8
        }
    }

    self.cursors = {
        hand = "hand"
    }

    self.buttons = {

    }

    --self.menu = {} --pack of buttons?
end

return LandscapeMainImporter