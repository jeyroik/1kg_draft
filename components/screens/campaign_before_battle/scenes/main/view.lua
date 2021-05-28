local LayerView = require "components/screens/layers/layer_view"

MainView = LayerView:extend()

function MainView:new(config)
    MainView.super.new(self, config)
end

function MainView:render(data, scene)
    scene.back:draw()
    scene.header:draw()
    
    scene.playerTeam:draw()
    scene.playerCard:drawPart(scene.playerCard.avatar.part)

    for _,card in pairs(scene.playerCharacters) do
        card:drawPart(3)
    end

    scene.enemyTeam:draw()
    scene.enemyCard:drawPart(scene.enemyCard.avatar.part)

    for _,card in pairs(scene.enemyCharacters) do
        card:drawPart(card.avatar.part)
    end

    scene.changeBtn:draw()
    scene.submitBtn:draw()
    scene.cancelBtn:draw()
end

return MainView