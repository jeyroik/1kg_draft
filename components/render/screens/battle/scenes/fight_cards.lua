require "components/render/screens/battle/scenes/fight_cards/view_deck"

SceneFightCards = Scene:extend()

function SceneFightCards:new(config)
    SceneFightCards.super.new(self, config)

    self.name = 'fight_cards'
    self.views = {
        BattleFightCardsViewDeck()
    }
end

function SceneFightCards:init(screen)

end

function SceneFightCards:mouseMoved(screen, x, y, dx, dy, isTouch)


end

function SceneFightCards:mousePressed(screen, x, y, button, isTouch, presses)


end

function SceneFightCards:mouseReleased(screen, x, y, button, isTouch, presses)

end

function SceneFightCards:update(screen)

end