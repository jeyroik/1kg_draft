InitializerScreenBattle = SourceInitializer:extend()

function InitializerScreenBattle:initSource(screen)
    screen.__state__ = 'fight_before'
	screen.__states__ = {
		{ alias = 'fight_before', path = 'components/screens/battle/scenes/fight_before' },
		{ alias = 'fight_cards',  path = 'components/screens/battle/scenes/fight_cards'  },
		{ alias = 'fight',        path = 'components/screens/battle/scenes/fight'        },
		{ alias = 'fight_after',  path = 'components/screens/battle/scenes/fight_after'  }
	}
end

return InitializerScreenBattle