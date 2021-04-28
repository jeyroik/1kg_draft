BattleFightBeforeImporter = AssetImporter:extend()

function BattleFightBeforeImporter:new()
    BattleFightBeforeImporter.super.new(self)

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
        board_background = { path = "board.png", initializer = "components/render/screens/battle/scenes/fight_before/initializer_background" },
        fs__btn = { path = "menu_btn.png" },
        fs__btn_pressed = { path = "menu_btn_pressed.png" },
    }
    self.cursors = {
        hand = "hand"
    }
    self.texts = {
        before_fight_header = { body = 'Choose mode', sx = 2, sy = 2, initializer = "components/render/screens/battle/scenes/fight_before/initializer_header"}
    }

    self.buttons = {
        pl1 = {
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = '1 player',
            text_scale = 0.7,
            border = 15,
            effect = 'color',
            color = {0, 0.5, 0}
        },
        pl2 = {
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = '2 players',
            text_scale = 0.7,
            border = 15,
            effect = 'color',
            color = {0, 0.5, 0}
        }
    }
end

return BattleFightBeforeImporter