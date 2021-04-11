LayerView = Layer:extend()

function LayerView:new(config)
    LayerView.super.new(self, config)

    self.mode = 'view'
end

function LayerView:needRender(game, data)
    return true
end