Initializer = SourceInitializer:extend()

function Initializer:initSource(screen)
    screen.__state__ = 'main_'
    screen.__states__ = {
        { alias = 'main_', path = 'components/screens/campaign_before_battle/scenes/main' }
    }
end

return Initializer