local LayerData = require "components/screens/layers/layer_data"

CampaignAuthLayerData = LayerData:extend()

function CampaignAuthLayerData:new(config)
    CampaignAuthLayerData.super.new(self, config)
end

return CampaignAuthLayerData