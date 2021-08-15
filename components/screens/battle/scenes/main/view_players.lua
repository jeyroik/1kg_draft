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
            card:drawPart(card.avatar.part)
            local skill = card.skill.active
            local totalCost = 0
            local playerHave = 0
            for magicName,amount in pairs(skill.cost) do
                totalCost = totalCost + amount
                playerHave = playerHave + player:getMagicAmount(magicName)
            end
            local havePerc = 1 - playerHave/totalCost
            if havePerc < 0 then
                havePerc = 0
            elseif havePerc > 1 then
                havePerc = 1
            end

            love.graphics.setColor(0,0,0,0.4)
            love.graphics.rectangle('fill', card.x, card.y, card.width*card.sx, card.height*card.sy*havePerc)
            love.graphics.setColor(1,1,1,1)
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