local Layer = require "components/screens/layers/layer"

LayerView = Layer:extend()

function LayerView:new(config)
    LayerView.super.new(self, config)

    self.mode = 'view'
end

function LayerView:needRender(screen)
    return true
end

return LayerView