Initializer = SourceInitializer:extend()

function Initializer:initSource(screen)
    screen.__state__ = 'main'
    screen.__states__ = {
        { alias = 'main', path = 'components/screens/arena_before_battle/scenes/main' }
    }
end

return Initializer