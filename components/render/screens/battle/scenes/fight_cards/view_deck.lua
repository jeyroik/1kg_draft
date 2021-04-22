BattleFightCardsViewDeck = LayerView:extend()

function BattleFightCardsViewDeck:new(config)
    self.image = ''
    BattleFightCardsViewDeck.super.new(self, config)
end

function BattleFightCardsViewDeck:render()
    local perRow = 2
    local onRow = 0
    local dx = 100
    local dy = 0
    for alias, card in pairs(game.assets.cards) do
        if onRow == perRow then
            onRow = 0
            dy = dy + card.height
            dx = 100
        end

        card:render(dx, dy)
        onRow = onRow + 1
        dx = dx + card.width
    end
end