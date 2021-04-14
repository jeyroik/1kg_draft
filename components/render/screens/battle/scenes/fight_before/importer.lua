BattleFightBeforeImporter = AssetImporter:extend()

function BattleFightBeforeImporter:new()
    BattleFightBeforeImporter.super.new(self)

    self.images = {
        tip = { path = "tip.png" },
        board_background = { path = "board.png" },
        fs__btn = { path = "menu_btn.png" },
        fs__btn_pressed = { path = "menu_btn_pressed.png" },
    }
    self.cursors = {
        hand = "hand"
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