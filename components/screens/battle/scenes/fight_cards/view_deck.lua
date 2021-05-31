local LayerView = require "components/screens/layers/layer_view"

BattleFightCardsViewDeck = LayerView:extend()

function BattleFightCardsViewDeck:new(config)
    self.image = ''
    BattleFightCardsViewDeck.super.new(self, config)
end

function BattleFightCardsViewDeck:draw(screen, scene)
    
    local head = Text({
        body = 'Player '..scene.player..'. Choose cards',
        sx = 2,
        sy = 2
    })
    head:setToPart(5, 2, 8)
    head:draw()

    scene.grid:draw()
    scene.addedCards:draw()

    local submit = game.assets:getButton('submitCards')
    local exit = game.assets:getButton('exitFight')

    submit:draw()
    exit:draw()
end

return BattleFightCardsViewDeck