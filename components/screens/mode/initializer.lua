ModeScreenInitializer = SourceInitializer:extend()

function ModeScreenInitializer:initSource(screen)
    screen.__state__ = 'main'
    screen.__states__ = {
        { alias = 'main', path = 'components/screens/mode/scenes/main' }
    }
end

return ModeScreenInitializer