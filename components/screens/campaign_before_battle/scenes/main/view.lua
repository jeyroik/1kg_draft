local LayerView = require "components/screens/layers/layer_view"

MainView = LayerView:extend()

function MainView:new(config)
    MainView.super.new(self, config)
end

function MainView:render(data, scene)
    local hovered = false
    scene.back:draw()
    scene.header:draw()
    
    scene.playerTeam:draw()
    scene.playerCard:drawPart(scene.playerCard.avatar.part)

    if scene.playerCard.selected then
        scene.playerCard:drawSelection(7,7,{0.5,1,1,1})
        hovered = true
    end

    for _,card in pairs(scene.playerCharacters) do
        card:drawPart(3)
        if card.selected then
            card:drawSelection(7,7,{0.5,1,1,1})
            hovered = true
        end
    end

    scene.enemyTeam:draw()
    scene.enemyCard:drawPart(scene.enemyCard.avatar.part)
    if scene.enemyCard.selected then
        scene.enemyCard:drawSelection(7,7,{0.5,1,1,1})
        hovered = true
    end

    for _,card in pairs(scene.enemyCharacters) do
        card:drawPart(card.avatar.part)
        if card.selected then
            card:drawSelection(7,7,{0.5,1,1,1})
            hovered = true
        end
    end

    scene.changeBtn:draw()
    scene.submitBtn:draw()
    scene.cancelBtn:draw()

    if scene.changeBtn.pressed or scene.submitBtn.pressed or scene.cancelBtn.pressed then
        hovered = true
    end

    if hovered then
        game.assets:getCursor('hand'):setOn()
    else
        game.assets:getCursor('hand'):reset()
    end
end

return MainView