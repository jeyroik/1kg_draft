BattleFightCardsViewDeck = LayerView:extend()

function BattleFightCardsViewDeck:new(config)
    self.image = ''
    BattleFightCardsViewDeck.super.new(self, config)
end

function BattleFightCardsViewDeck:render(screen, scene)
    
    local head = Text({
        body = 'Player '..scene.player..'. Choose cards',
        sx = 2*VisibleObject.globalScale,
        sy = 2*VisibleObject.globalScale
    })
    head:setToPart(5, 2, 8)
    head:render()

    scene.grid:setToCenter(true, true)
    scene.grid:render()
    scene.addedCards:render()

    local submit = game.assets:getButton('submitCards')
    submit:setToPart(5, 7, 8)

    local exit = game.assets:getButton('exitFight')
    exit:setToPart(5, 7, 8)
    exit:stepByY(50)
    exit:stepByY(20)

    scene.buttonsGrid.width  = 800*VisibleObject.globalScale
    scene.buttonsGrid:setToPart(5,7,8)
    scene.buttonsGrid.sx = VisibleObject.globalScale
    scene.buttonsGrid.sy = VisibleObject.globalScale
    scene.buttonsGrid:reload()
    scene.buttonsGrid:render()
end