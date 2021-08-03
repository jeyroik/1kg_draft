local LayerView = require "components/screens/layers/layer_view"

ViewPlayers = LayerView:extend()

function ViewPlayers:draw(screen, scene)
    self:renderCards(screen)
    self:renderFrameCurrentPlayer(screen, scene)
    self:renderMagic(screen)
end

function ViewPlayers:renderFrameCurrentPlayer(screen, scene)
    scene.p1health:draw()
    scene.p2health:draw()
    scene.turn:draw()
end

function ViewPlayers:renderCards(screen)
    local cardWithTip = false
    for i=1,2 do
        local player = screen.playersCards[i]
        
        player:drawPart(player.avatar.part)
        for i, card in pairs(screen.playersTeamsCards[i]) do
            if card.tip.draw then
                cardWithTip = card
            else
                card:drawPart(card.avatar.part)
            end
        end
    end

    if cardWithTip then
        cardWithTip:drawPart(cardWithTip.avatar.part)
        if cardWithTip.tip.type == 'details' then
            cardWithTip.tip.subject:draw()
            
            local desc = game:create('text_overlay', {
                body = cardWithTip.description..'\n\n--------------------------------------------\n\n'..cardWithTip.skill.active.description,
                overlay_mode = 'fill',
                overlay_color = {0,0,0,0.8},
                overlay_offset = 15,
                x = cardWithTip.tip.subject.x + cardWithTip.tip.subject.width*cardWithTip.tip.subject.sx + 17,
                y = cardWithTip.tip.subject.y + 15
            })
            local overlay = game:create('rectangle', {
                mode = 'fill',
                x = desc.x-15,
                y = desc.y+desc.height+15,
                width = desc.width+30,
                height = cardWithTip.tip.subject.height*cardWithTip.tip.subject.sy-desc.height-25,
                color = {0,0,0,0.8}
            })
            local usebtn = game:create('button_default', {
                text = 'Apply now',
                mousePressed = function()
                    cardWithTip.tip.type = 'label'
                    cardWithTip.tip.draw = false
                end
            })
            game:put(usebtn, 9,14, 5,2)
            overlay:draw()
            usebtn:draw()
            desc:draw()
        end
    end
end

function ViewPlayers:renderMagic(screen)
    self:renderPlayerMagic(screen.players[1])
    self:renderPlayerMagic(screen.players[2])
end

function ViewPlayers:renderPlayerMagic(player)
    local magic = game.assets:getMisc('magic')
    local order = magic.namesOrder
    for _,name in pairs(order) do
        local pm = player.magic[name]
        local m = magic:getByName(name)
        

        pm:draw('image')
        if pm.isHovered then
            pm:draw('title')
        end
    end
end

return ViewPlayers