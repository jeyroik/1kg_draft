local LayerView = require "components/screens/layers/layer_view"

MainView = LayerView:extend()

function MainView:new(config)
    MainView.super.new(self, config)
end

function MainView:draw(data, scene)
    
end

return MainView