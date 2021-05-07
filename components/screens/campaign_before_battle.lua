local Data = require "components/screens/campaign_before_battle/data"
local Screen = require "components/screens/screen"

CampaignBeforeBattle = Screen:extend()

function CampaignBeforeBattle:new(config)
	config.initializer = config.initializer or 'components/screens/campaign_before_battle/initializer'
	CampaignBeforeBattle.super.new(self, config)

	self:setDataLayer(Data(config))
end

return CampaignBeforeBattle