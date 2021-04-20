LandscapeMainImporter = AssetImporter:extend()

function LandscapeMainImporter:new()
    LandscapeMainImporter.super.new(self)

    self.images = {

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