InitializerScreenLandscape = SourceInitializer:extend()

function InitializerScreenLandscape:initSource(screen)
    screen.__state__ = 'main'
    screen.__states__ = {
        { alias = 'main', path = 'components/screens/landscape/scenes/main' }
    }
end

return InitializerScreenLandscape