local CampaignAuthLayerData = require "components/screens/campaign_auth/data"
local Screen = require "components/screens/screen"

CampaignAuthScreen = Screen:extend()

function CampaignAuthScreen:new(config)
	config.initializer = config.initializer or 'components/screens/campaign_auth/initializer'
	CampaignAuthScreen.super.new(self, config)

	self:setDataLayer(CampaignAuthLayerData(config))
end

return CampaignAuthScreen