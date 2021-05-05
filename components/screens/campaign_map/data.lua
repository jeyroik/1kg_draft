local LayerData = require "components/screens/layers/layer_data"

CampaignMapLayerData = LayerData:extend()

function CampaignMapLayerData:new(config)
    CampaignMapLayerData.super.new(self, config)
end

return CampaignMapLayerData