BattleFightViewPlayers = LayerView:extend()

function BattleFightViewPlayers:render(data)
    self:renderCards(data)
    self:renderFrameCurrentPlayer(data)
    self:renderMagic(data)
end

function BattleFightViewPlayers:renderFrameCurrentPlayer(data)
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

function BattleFightViewPlayers:renderCards(data)
    for i=1,2 do
        local player = data.players[i]
        for j=1,#player.cards do
            local card = player.cards[j]
            card:render()
        end
    end
end

function BattleFightViewPlayers:renderMagic(data)
    self:renderPlayerGems(data.players[1])
    self:renderPlayerGems(data.players[2])
end

function BattleFightViewPlayers:renderPlayerGems(player)
    local order = game.assets:getMisc('magic').namesOrder
    for _,name in pairs(order) do
        local gem = player.gems[name]

        gem:render('image+amount', 0, 0, 0, VisibleObject.globalScale, VisibleObject.globalScale)
        if gem.isHovered then
            gem:render('title')
        end
    end
end