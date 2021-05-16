local Screen = require "components/screens/screen"

CampaignBeforeBattle = Screen:extend()

function CampaignBeforeBattle:new(config)
    self.location = ''
    self.enemy = {}

	CampaignBeforeBattle.super.new(self, config)
end

function CampaignBeforeBattle:initState(...)
	self.__state__ = 'main'
    self.__states__ = {
        main = { path = 'components/screens/campaign_before_battle/scenes/main' },
        team = { path = 'components/screens/campaign_before_battle/scenes/team' }
    }
	CampaignBeforeBattle.super.initState(self, ...)
end

return CampaignBeforeBattle