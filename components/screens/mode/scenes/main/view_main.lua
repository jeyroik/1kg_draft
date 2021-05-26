local LayerView = require "components/screens/layers/layer_view"

MainView = LayerView:extend()

function MainView:new(config)
    MainView.super.new(self, config)
end

function MainView:render(data, scene)
    scene.vsPCBtn:draw()
    scene.vsPlayerBtn:draw()
    scene.header:draw()
end

return MainView