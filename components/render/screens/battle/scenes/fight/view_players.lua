BattleFightViewPlayers = LayerView:extend()

function BattleFightViewPlayers:render(data)
    self:renderMagic(data)
    self:renderFrameCurrentPlayer(data)
    self:renderCards(data)
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
    self:renderPlayer1Magic(data)
    self:renderPlayer2magic(data)
end

function BattleFightViewPlayers:renderPlayer1Magic(data)
    local player = data.players[1]
    local sx = player.cards[1].sx
    local magicX = player.x - 80*sx
    local magicY = player.y
    local magicYDelta = 50*sx
    local perRow = 1
    local onRow = 0
    local gemsPack = game.assets:getImagePack('gems')
    local magics = game.assets:getMisc('magic').items

    for i=0,10 do
        local id = 'c'..math.pow(2, i)
        local magic = magics[id]
        local value = player:getMagicAmount(magic:getName())

        if gemsPack:get(magic:getType()) then
            if onRow == perRow then
                magicX = player.x - 80*sx
                magicY = magicY + magicYDelta
                onRow = 0
            end

            local gem = gemsPack:get(magic:getType())
            gem:render(magicX, magicY, 0, 0.5*sx, 0.5*sx)
            love.graphics.print(value, magicX+40*sx, magicY, 0, 2*sx,2*sx)
            onRow = onRow + 1
        end
    end
end

function BattleFightViewPlayers:renderPlayer2magic(data)
    local player = data.players[2]
    local sx = player.cards[1].sx
    local magicX = player.x + player.cards[1].width*sx + 20*sx
    local magicY = player.y
    local magicYDelta = 50*sx
    local perRow = 1
    local onRow = 0
    local gemsPack = game.assets:getImagePack('gems')
    local magics = game.assets:getMisc('magic').items

    for i=0,10 do
        local id = 'c'..math.pow(2, i)
        local magic = magics[id]
        local value = player:getMagicAmount(magic:getName())

        if gemsPack:get(magic:getType()) then
            if onRow == perRow then
                magicX = player.x + player.cards[1].width*sx + 20*sx
                magicY = magicY + magicYDelta
                onRow = 0
            end

            local gem = gemsPack:get(magic:getType())
            gem:render(magicX, magicY, 0, 0.5*sx, 0.5*sx)
            love.graphics.print(value, magicX+40*sx, magicY, 0, 2*sx,2*sx)
            onRow = onRow + 1
        end
    end
end