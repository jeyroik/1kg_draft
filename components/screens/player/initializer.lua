PlayerScreenInitializer = SourceInitializer:extend()

function PlayerScreenInitializer:initSource(screen)
    screen.__state__ = 'main'
    screen.__states__ = {
        { alias = 'main', path = 'components/screens/player/scenes/main' }
    }
end

return PlayerScreenInitializer