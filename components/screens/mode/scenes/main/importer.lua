local AssetImporter = require 'components/assets/importers/importer'

ModeImporter = AssetImporter:extend()

function ModeImporter:new()
    ModeImporter.super.new(self)

    self.images = {
        tip = { 
            path = "tip.png", 
            renderConfig = {
                scale = 'size',
                origin = {
                    w = 1600,
                    h = 1080
                }
            } 
        },
        board_background = { path = "board.png", initializer = "components/screens/mode/scenes/main/initializer_background" },
        btn = { path = "menu_btn.png" },
        btn_pressed = { path = "menu_btn_pressed.png" },
    }
    self.cursors = {
        hand = "hand"
    }
    self.texts = {
        before_fight_header = { body = 'Choose mode', sx = 2, sy = 2, initializer = "components/screens/mode/scenes/main/initializer_header"}
    }
end

return ModeImporter