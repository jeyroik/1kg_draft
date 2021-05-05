local Layer = require "components/screens/layers/layer"

LayerData = Layer:extend()

function LayerData:new(config)
    self.tip = {}
    self.selection = {}

    LayerData.super.new(self, config)

    self.mode = 'data'
end

function LayerData:init()

end

return LayerData