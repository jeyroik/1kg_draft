CampaignAuthScreenInitializer = SourceInitializer:extend()

function CampaignAuthScreenInitializer:initSource(screen)
    screen.__state__ = 'main'
    screen.__states__ = {
        { alias = 'main', path = 'components/screens/campaign_auth/scenes/main' }
    }
end

return CampaignAuthScreenInitializer