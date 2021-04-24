BattleFightCardsImporter = AssetImporter:extend()

function BattleFightCardsImporter:new()
    BattleFightCardsImporter.super.new(self)

    self.buttons = {
        submitCards = {
            name = 'submit',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Submit',
            text_scale = 0.7,
            border = 15,
            effect = 'color',
            color = {0, 0.5, 0}
        },
        exitFight = {
            name = 'exit',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Exit fight',
            text_scale = 0.7,
            border = 15,
            effect = 'color',
            color = {0, 0.5, 0}
        }
    }
end

return BattleFightCardsImporter