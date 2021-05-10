local Data = require "components/screens/campaign_auth/data"
local Screen = require "components/screens/screen"

CampaignAuth = Screen:extend()

function CampaignAuth:new(config)
	CampaignAuth.super.new(self, config)
end

function CampaignAuth:initState(...)
	self:setDataLayer(Data(config))
	self.__state__ = 'main'
    self.__states__ = {
        { alias = 'main', path = 'components/screens/campaign_auth/scenes/main' }
    }
	CampaignAuth.super.initState(self, ...)
end

return CampaignAuth