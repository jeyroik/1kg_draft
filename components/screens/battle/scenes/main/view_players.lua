local LayerView = require "components/screens/layers/layer_view"

ViewPlayers = LayerView:extend()

function ViewPlayers:render(screen)
    self:renderCards(screen)
    --self:renderFrameCurrentPlayer(data)
    --self:renderMagic(data)
end

function ViewPlayers:renderFrameCurrentPlayer(screen)
    local current = data.players[data.current]
    local avatar = current.cards[1]
    local turn = game.assets:getImage('turn')
    turn.sx = 0.2
    turn.sy = 0.2
    turn:stickToTop(avatar)
    turn:setToCenterOfObject(avatar, true)
    turn:render()

    local turn_enemy = game.assets:getImage('turn_enemy')
    local next = data.players[data.next]
    avatar = next.cards[1]
    turn_enemy.sx = 0.2
    turn_enemy.sy = 0.2
    turn_enemy:stickToTop(avatar)
    turn_enemy:setToCenterOfObject(avatar, true)
    turn_enemy:render()
end

function ViewPlayers:renderCards(screen)
    for i=1,2 do
        local player = screen.playersCards[i]
        
        player:drawPart(player.avatar.part)
        for i, card in pairs(screen.playersTeamsCards[i]) do
            card:drawPart(card.avatar.part)
        end
    end
end

function ViewPlayers:renderMagic(screen)
    self:renderPlayerGems(data.players[1])
    self:renderPlayerGems(data.players[2])
end

function ViewPlayers:renderPlayerGems(player)
    local order = game.assets:getMisc('magic').namesOrder
    for _,name in pairs(order) do
        local gem = player.gems[name]

        gem:render('image+amount')
        if gem.isHovered then
            gem:render('title')
        end
    end
end

return ViewPlayers