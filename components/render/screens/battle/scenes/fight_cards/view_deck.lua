BattleFightCardsViewDeck = LayerView:extend()

function BattleFightCardsViewDeck:new(config)
    self.image = ''
    BattleFightCardsViewDeck.super.new(self, config)
end

function BattleFightCardsViewDeck:render()
    local grid = Grid({
        width   = love.graphics.getWidth(),
        height  = love.graphics.getHeight(),
        columns = 4,
        rows    = 4,
        padding = {
            top    = 50  * VisibleObject.globalScale,
            bottom = 50  * VisibleObject.globalScale,
            left   = 100 * VisibleObject.globalScale,
            right  = 100 * VisibleObject.globalScale
        }
    })

    grid:addCollection(game.assets.cards)
    grid:render()
end