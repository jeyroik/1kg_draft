local LayerView = require "components/screens/layers/layer_view"

MainView = LayerView:extend()

function MainView:new(config)
    MainView.super.new(self, config)
end

function MainView:render(data, scene)
    scene.back:draw()
    scene.header:draw()

    scene.playerName:draw()
    scene.playerCard:drawPart(1)

    for _,card in pairs(scene.playerTeam) do
        card:drawPart(3)
    end

    for i,card in pairs(scene.playerCharacters) do
        card:draw()
        love.graphics.print(i, card.x+5, card.y+5)
    end

    scene.scrollUp:draw()
    scene.scrollDown:draw()

    scene.submitBtn:draw()
    scene.cancelBtn:draw()
end

return MainView