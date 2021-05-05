local CampaignMapLayerData = require "components/screens/campaign_map/data"
local Screen = require "components/screens/screen"

CampaignMapScreen = Screen:extend()

function CampaignMapScreen:new(config)
    config.initializer = config.initializer or 'components/screens/campaign_map/initializer'

    CampaignMapScreen.super.new(self, config)

    self:setDataLayer(CampaignMapLayerData(config))
end

function CampaignMapScreen:getProfile()
    return self.layers.data:getProfile()
end

return CampaignMapScreen