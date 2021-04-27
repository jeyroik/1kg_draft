InitializerScreenBattle = SourceInitializer:extend()

function InitializerScreenBattle:initSource(screen)
    self.__state__ = 'fight_before'
	self.__states__ = {
		{ alias = 'fight_before', path = 'components/render/screens/battle/scenes/fight_before' },
		{ alias = 'fight_cards',  path = 'components/render/screens/battle/scenes/fight_cards'  },
		{ alias = 'fight',        path = 'components/render/screens/battle/scenes/fight'        },
		{ alias = 'fight_after',  path = 'components/render/screens/battle/scenes/fight_after'  }
	}
    love.filesystem.append('log.txt', '\nInitializerScreenLandscape:initSource(): battle screen initialized')
end

return InitializerScreenBattle