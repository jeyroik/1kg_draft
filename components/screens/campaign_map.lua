local Screen = require "components/screens/screen"

CampaignMap = Screen:extend()

function CampaignMap:new(config)
    config.name = 'campaign_map'
    CampaignMap.super.new(self, config)
end

function CampaignMap:initState(...)
    self.__state__ = 'main'
    self.__states__ = {
        main = { path = 'components/screens/campaign_map/scenes/main' }
    }
    CampaignMap.super.initState(self, ...)
end

function CampaignMap:getProfile()
    return self.layers.data:getProfile()
end

return CampaignMap