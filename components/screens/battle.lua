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

            if i == 1 then
                char.mousePressed = function (event, selfCard)
                    selfCard.tip.draw = true
                    selfCard.tip.type = 'details'
                end
                char.mouseOut = function (event, selfCard)
                    game.cursor:reset() 
                    if selfCard.tip.type ~= 'details' then
                        selfCard.tip.draw = false
                    end
                end
                char.pointable = true
            else
                char.mousePressed = function ()
                    
                end
            end

            local card = game:create('card', char)
            
            table.insert(self.playersTeamsCards[i], card)

            if i == 1 then
                local tipImage = game:create('image', {path = card.avatar.path..'/'..card.avatar.frame..'.jpg'}) --todo
                game:put(tipImage, 5,9, 4,6)

                card.tip = {
                    draw = false, 
                    type = 'label',
                    data = {
                        image = tipImage,
                        desc = game:create('text_overlay', {
                            body = card.description..'\n\n--------------------------------------------\n\n'..card.skill.active.description,
                            overlay_mode = 'fill',
                            overlay_color = {0,0,0,0.8},
                            overlay_offset = 15,
                            x = tipImage.x + tipImage.width*tipImage.sx + 14,
                            y = tipImage.y + 15
                        }),
                        useBtn = game:create('button_default', {
                            text = 'Apply now',
                            mousePressed = function(event, button)
                                if card.tip.draw and button.visible then
                                    card.tip.type = 'label'
                                    card.tip.draw = false
                                    self.playersCards[i]:useCard(self, card)
                                end
                            end
                        })
                    },
                    dispatcher = function()
                        if card.tip.type == 'details' then
                            card.tip.data.image:draw()
                            card.tip.data.overlay:draw()
                            if self.playersCards[i]:isEnoughMagic(card) then
                                card.tip.data.useBtn.visible = true
                                card.tip.data.useBtn:draw()
                            else
                                card.tip.data.useBtn.visible = false
                            end
                            card.tip.data.desc:draw()
                            card.tip.data.close:draw()
                        end
                    end
                }

                card.tip.data.overlay = game:create('rectangle', {
                    mode = 'fill',
                    x = card.tip.data.desc.x-15,
                    y = card.tip.data.desc.y+card.tip.data.desc.height+15,
                    width = card.tip.data.desc.width+30,
                    height = tipImage.height * tipImage.sy - card.tip.data.desc.height-25,
                    color = {0,0,0,0.8}
                })
                card.tip.data.close = game:create('text', {
                    body = 'x',
                    pointable = true,
                    mousePressed = function (event, btn)
                        if btn.visible then 
                            card.tip.draw = false
                            card.tip.type = 'label'
                        end
                    end
                })

                game:put(card.tip.data.close, 5,19, 0.4,0.4)
                game:put(card.tip.data.useBtn, 10,15, 3,1)
      
                for manaName,amount in pairs(card.skill.active.cost) do
                    game.events:on(
                        'magic.inc.'..player.id..'.'..manaName,
                        function(name, event)
                            if self.playersCards[i]:isEnoughMagic(card) then
                                card.selection.color = {0.25, 0.51, 0.42, 1}
                                card.selection.lineWidth = 2
                            elseif card.selection.lineWidth == 2 then
                                card.selection.color = {1, 1, 1, 1}
                                card.selection.lineWidth = 1
                            end
                        end
                    )
                end
            end
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

    local isCurrentHuman = self:getCurrentPlayer().isHuman and 'true' or 'false'
    local isNextHuman = self:getNextPlayer().isHuman and 'true' or 'false'

    if not self:getCurrentPlayer().isHuman then
        game.ai:play(self:getCurrentPlayer())
    end
end

return Battle