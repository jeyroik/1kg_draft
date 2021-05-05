local LayerData = require "components/screens/layers/layer_data"

PlayerLayerData = LayerData:extend()

function PlayerLayerData:new(config)
    PlayerLayerData.super.new(self, config)
end

return PlayerLayerData