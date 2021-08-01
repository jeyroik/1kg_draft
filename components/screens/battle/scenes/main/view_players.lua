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