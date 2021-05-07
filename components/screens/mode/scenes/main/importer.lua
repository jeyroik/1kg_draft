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

    self.buttons = {
        pl1 = {
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Campaign',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            color = {0, 0.5, 0}
        },
        pl2 = {
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Arena',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            color = {0, 0.5, 0}
        }
    }
end

return ModeImporter