local LayerData = require "components/screens/layers/layer_data"

ModeLayerData = LayerData:extend()

function ModeLayerData:new(config)
    ModeLayerData.super.new(self, config)
end

return ModeLayerData