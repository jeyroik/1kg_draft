Initializer = SourceInitializer:extend()

function Initializer:initSource(screen)
    screen.__state__ = 'main'
    screen.__states__ = {
        { alias = 'main', path = 'components/screens/campaign_before_battle/scenes/main' },
        { alias = 'team', path = 'components/screens/campaign_before_battle/scenes/team' }
    }
end

return Initializer