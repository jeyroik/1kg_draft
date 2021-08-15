local Screen = require "components/screens/screen"

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
        self.playersCards[i] = game:create('player', player)
        local team = player:getCurrentTeam()
        self.playersTeams[i] = team

        for p, char in pairs(team) do
            char.pointable = false
            char.label = char.title
            char.id = self:getId()
            char.tip = {
                draw = false, 
                type = 'label',
                dispatcher = function()
                    if char.tip.type == 'details' then
                        char.tip.subject:draw()
                        local desc = game:create('text_overlay', {
                            body = char.description..'\n\n--------------------------------------------\n\n'..char.skill.active.description,
                            overlay_mode = 'fill',
                            overlay_color = {0,0,0,0.8},
                            overlay_offset = 15,
                            x = char.tip.subject.x + char.tip.subject.width*char.tip.subject.sx + 17,
                            y = char.tip.subject.y + 15
                        })
                        local overlay = game:create('rectangle', {
                            mode = 'fill',
                            x = desc.x-15,
                            y = desc.y+desc.height+15,
                            width = desc.width+30,
                            height = char.tip.subject.height*char.tip.subject.sy-desc.height-25,
                            color = {0,0,0,0.8}
                        })
                        local usebtn = game:create('button_default', {
                            text = 'Apply now',
                            mousePressed = function()
                                char.tip.type = 'label'
                                char.tip.draw = false
                            end
                        })
                        game:put(usebtn, 9,14, 5,2)
                        overlay:draw()
                        usebtn:draw()
                        desc:draw()
                    end
                end , 
                subject = game:create('card', char)
            }
            char.tip.subject.id = self:getId()
            char.tip.subject.mousePressed = function () 
                char.tip.draw = false
                char.tip.type = 'label'
            end
            char.mousePressed = function ()
                game.graphics:put(char.tip.subject, 5,9, 4,6)
                char.tip.draw = true
                char.tip.type = 'details'
            end
            char.pointable = true
            
            local card = game:create('card', char)
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