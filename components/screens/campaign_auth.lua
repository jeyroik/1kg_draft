local Screen = require "components/screens/screen"

CampaignAuth = Screen:extend()

function CampaignAuth:new(config)
    config.name = 'campaign_auth'
	CampaignAuth.super.new(self, config)
end

function CampaignAuth:initState(...)
	self.__state__ = 'main'
    self.__states__ = {
        main = { path = 'components/screens/campaign_auth/scenes/main' }
    }
	CampaignAuth.super.initState(self, ...)
end

return CampaignAuth