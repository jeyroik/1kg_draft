BattleFightCardsViewDeck = LayerView:extend()

function BattleFightCardsViewDeck:new(config)
    self.image = ''
    BattleFightCardsViewDeck.super.new(self, config)
end

function BattleFightCardsViewDeck:render(screen, scene)
    
    local head = Text({
        body = 'Player '..scene.player..'. Choose cards',
        sx = 2,
        sy = 2
    })
    head:setToPart(5, 2, 8)
    head:render()

    scene.grid:render()
    scene.addedCards:render()

    local submit = game.assets:getButton('submitCards')
    local exit = game.assets:getButton('exitFight')

    submit:render()
    --exit:render()
end