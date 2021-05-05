InitializerScreenCampaignMap = SourceInitializer:extend()

function InitializerScreenCampaignMap:initSource(screen)
    screen.__state__ = 'main'
    screen.__states__ = {
        { alias = 'main', path = 'components/screens/campaign_map/scenes/main' }
    }
end

return InitializerScreenCampaignMap