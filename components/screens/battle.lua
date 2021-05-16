local Screen = require "components/screens/screen"

Battle = Screen:extend()

function Battle:new(config)
	self.board = {
        size = 5,
        deathPerc = 10,
        ultraDeathPerc = 20,
        stonesPerRound = 3,
        width = love.graphics.getHeight()*0.6,
        height = love.graphics.getHeight()*0.6
    }
    self.statistics = {
        {
            damage_taken = 0,
            damaged = 0,
            stones = 0,
            spells = 0,
            win = false
        },
        {
            damage_taken = 0,
            damaged = 0,
            stones = 0,
            spells = 0,
            win = false
        }
    }
    self.players = {}
    self.current = 1
    self.next = 2
    self.magic = {}
    self.mode = ''
    self.theEndFlag = false
    self.fx = 'none'

	Battle.super.new(self, config)
end

function Battle:initState(...)
	self.__state__ = 'main'
	self.__states__ = {
		main 		= { path = 'components/screens/battle/scenes/main'         },
		fight_after = { path = 'components/screens/battle/scenes/fight_after'  }
	}
	Battle.super.initState(self, ...)
end

function Battle:getCurrentPlayer()
	return self.players[self.current]
end

function Battle:getNextPlayer()
	return self.players[self.next]
end

-- @param Player player
-- @return boolean
function Battle:isCurrentPlayer(player)
    return player.id == self:getCurrentPlayer().id
end

function Battle:nextTurn()
    local c = self.current
    self.current = self.next
    self.next = c

    if not self:getCurrentPlayer().isHuman then
        local gr = {'down', 'up', 'left', 'right'}
        love.event.push('keypressed', gr[love.math.random(1, 4)])
    end
end

return Battle