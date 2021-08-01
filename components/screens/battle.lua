local Screen = require "components/screens/screen"
local Player = require "components/sources/player"

Battle = Screen:extend()

function Battle:new(config)
    config.name = 'battle'
    
	self.board = {
        size = 5,
        deathPerc = 10,
        ultraDeathPerc = 20,
        stonesPerRound = 3,
        width  = 16,
        height = 16
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
    self.playersCards = {}
    self.playersTeams = {}
    self.playersTeamsCards = {{}, {}}

    self.current = 1
    self.next = 2
    self.nextScreen = ''
    self.magic = {}
    self.mode = ''
    self.theEndFlag = false
    self.fx = 'none'
    self.tip = {}

	Battle.super.new(self, config)
end

function Battle:initState(...)
	self.__state__ = 'main'
	self.__states__ = {
		main 		= { path = 'components/screens/battle/scenes/main'         },
		fight_after = { path = 'components/screens/battle/scenes/fight_after'  }
	}

    Battle.super.initState(self)
end

function Battle:stateChanged()
    for i, player in pairs(self.players) do
        self.playersCards[i] = Player(player)
        local team = player:getCurrentTeam()
        self.playersTeams[i] = team

        for p, char in pairs(team) do
            char.pointable = true
            char.label = char.title
            char.id = self:getId()
            local card = game.resources:create('card', char)
            table.insert(self.playersTeamsCards[i], card)
        end
    end
end

function Battle:getCurrentPlayer()
	return self.playersCards[self.current]
end

function Battle:getNextPlayer()
	return self.playersCards[self.next]
end

-- @param Player player
-- @return boolean
function Battle:isCurrentPlayer(player)
    return player.id == self:getCurrentPlayer().id
end

function Battle:nextTurn()
    local c      = self.current
    self.current = self.next
    self.next    = c

    if not self:getCurrentPlayer().isHuman then
        local gr = {'down', 'up', 'left', 'right'}
        love.event.push('keypressed', gr[love.math.random(1, 4)])
    end
end

return Battle