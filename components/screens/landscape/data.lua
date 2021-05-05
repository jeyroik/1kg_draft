local LayerData = require "components/screens/layers/layer_data"

LandscapeLayerData = LayerData:extend()

function LandscapeLayerData:new(config)
    LandscapeLayerData.super.new(self, config)
end

return LandscapeLayerData