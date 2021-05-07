local LayerView = require "components/screens/layers/layer_view"

MainView = LayerView:extend()

function MainView:new(config)
    MainView.super.new(self, config)
end

function MainView:render(data, scene)
    scene.back:draw()
    scene.header:draw()
    scene.playerTeam:draw()
    scene.enemyTeam:draw()
end

return MainView