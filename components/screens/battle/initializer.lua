Initializer = SourceInitializer:extend()

function Initializer:initSource(screen)
    screen.__state__ = 'main'
	screen.__states__ = {
		{ alias = 'main',        path = 'components/screens/battle/scenes/main'         },
		{ alias = 'fight_after', path = 'components/screens/battle/scenes/fight_after'  }
	}
end

return Initializer