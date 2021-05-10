local Data   = require "components/screens/campaign_before_battle/data"
local Screen = require "components/screens/screen"

CampaignBeforeBattle = Screen:extend()

function CampaignBeforeBattle:new(config)
	CampaignBeforeBattle.super.new(self, config)
end

function CampaignBeforeBattle:initState(...)
    self:setDataLayer(Data(config))
	self.__state__ = 'main'
    self.__states__ = {
        { alias = 'main', path = 'components/screens/campaign_before_battle/scenes/main' },
        { alias = 'team', path = 'components/screens/campaign_before_battle/scenes/team' }
    }
	CampaignBeforeBattle.super.initState(self, ...)
end

return CampaignBeforeBattle