local LayerView = require "components/screens/layers/layer_view"

ViewPlayers = LayerView:extend()

function ViewPlayers:draw(screen)
    self:renderCards(screen)
    --self:renderFrameCurrentPlayer(data)
    self:renderMagic(screen)
end

function ViewPlayers:renderFrameCurrentPlayer(screen)
    local current = data.players[data.current]
    local avatar = current.cards[1]
    local turn = game.assets:getImage('turn')
    turn.sx = 0.2
    turn.sy = 0.2
    turn:stickToTop(avatar)
    turn:setToCenterOfObject(avatar, true)
    turn:draw()

    local turn_enemy = game.assets:getImage('turn_enemy')
    local next = data.players[data.next]
    avatar = next.cards[1]
    turn_enemy.sx = 0.2
    turn_enemy.sy = 0.2
    turn_enemy:stickToTop(avatar)
    turn_enemy:setToCenterOfObject(avatar, true)
    turn_enemy:draw()
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
        

       -- gem:draw('image+amount')
      --  if gem.isHovered then
      --      gem:draw('title')
      --  end
    end
end

return ViewPlayers