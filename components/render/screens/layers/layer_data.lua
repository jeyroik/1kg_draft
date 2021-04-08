LayerData = ScreenLayer:extend()

function LayerData:new(config)
    self.tip = {}

    LayerData.super.new(self, config)

    self.mode = 'data'
end