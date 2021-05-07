BattleFightCardsImporter = AssetImporter:extend()

function BattleFightCardsImporter:new()
    BattleFightCardsImporter.super.new(self)

    self.buttons = {
        submitCards = {
            alias = 'fight_cards_submit_btn',
            name = 'submit',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Submit',
            text_scale = 0.7,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            color = {0, 0.5, 0},
            initializer = 'components/screens/battle/scenes/fight_cards/initializer_submit',
            renderConfig = {
                scale = 'size',
                origin = {
                    w = 1920,
                    h = 1080,
                    x = 100,
                    y = 100
                }
            }
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
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            color = {0, 0.5, 0},
            initializer = 'components/screens/battle/scenes/fight_cards/initializer_exit',
            renderConfig = {
                scale = 'size',
                origin = {
                    w = 1920,
                    h = 1080,
                    x = 100,
                    y = 100
                }
            }
        }
    }
end

function BattleFightCardsImporter:importAssets(assetsManager)
    BattleFightCardsImporter.super.importAssets(self, assetsManager)

end

return BattleFightCardsImporter