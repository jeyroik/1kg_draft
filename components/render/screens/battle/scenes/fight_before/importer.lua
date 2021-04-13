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
end

return BattleFightBeforeImporter