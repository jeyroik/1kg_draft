BattleFightBeforeImporter = AssetImporter:extend()

function BattleFightBeforeImporter:new()
    BattleFightBeforeImporter.super.new(self)

    self.images = {
        tip = "tip.png",
        board_background = "board.png",
        fs__btn = "menu_btn.png",
        fs__btn_pressed = "menu_btn_pressed.png",
    }
    self.cursors = {
        hand = "hand"
    }
end

return BattleFightBeforeImporter