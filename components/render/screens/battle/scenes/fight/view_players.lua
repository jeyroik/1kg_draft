BattleFightViewPlayers = LayerView:extend()

function BattleFightViewPlayers:render(data)
    self:renderMagic(data)
    self:renderFrameCurrentPlayer(data)
    self:renderPlayersInfo(data)
    self:renderCards(data)
end

function BattleFightViewPlayers:renderPlayersInfo(data)
    local p1 = data.players[1]
    local p2 = data.players[2]

    p1.x = love.graphics.getWidth()*0.1
    p1.y = love.graphics.getHeight()*0.1
    p1.width = love.graphics.getWidth()*0.2
    p1.height = love.graphics.getHeight()*0.2
    p1.sx = love.graphics.getWidth()/960
    p1.sy = love.graphics.getHeight()/540

    love.graphics.print('\nw:'..love.graphics.getWidth()..', h:'.. love.graphics.getHeight(), p1.x, 50, 0, 1,1)
    love.graphics.print('\nPlayer 1:'..'\n\nHealth: '.. p1.health, p1.x, p1.y, 0, p1.sx,p1.sy)
    love.graphics.print('\nPlayer 2:'..'\n\nHealth: '.. p2.health, p2.x, 100, 0,2,2)
end

function BattleFightViewPlayers:renderFrameCurrentPlayer(data)
    local current = data.players[data.current]
    local top, _, size = current:getEdgesFrame(5)

    love.graphics.rectangle('line', top.left.x, top.left.y, size.width, size.height)
end

function BattleFightViewPlayers:renderCards(data)
    for i=1,2 do
        local player = data.players[i]
        for i=1,#player.cards do
            local card = player.cards[i]
            game.assets:getQuads('chars'):render(card.avatar, card.x, card.y)
        end
    end
end

function BattleFightViewPlayers:renderMagic(data)
    self:renderPlayer1Magic(data)
    self:renderPlayer2magic(data)
end

function BattleFightViewPlayers:renderPlayer1Magic(data)
    local player = data.players[1]

    local magicX = player.x - 80
    local magicXDelta = 150
    local magicY = player.y
    local magicYDelta = 50
    local perRow = 1
    local onRow = 0
    local current = data.players[1]
    local gemsPack = game.assets:getImagePack('gems')

    for i=0,10 do
        local id = 'c'..math.pow(2,i)
        value = data.magic[current.id][id]

        if gemsPack:get(id) then
            if onRow == perRow then
                magicX = player.x - 80
                magicY = magicY + magicYDelta
                onRow = 0
            end

            local gem = gemsPack:get(id)
            gem:render(magicX, magicY, 0, 0.5, 0.5)
            love.graphics.print(value, magicX+40, magicY, 0, 2,2)
            magicX = magicX + magicXDelta
            onRow = onRow + 1
        end
    end
end

function BattleFightViewPlayers:renderPlayer2magic(data)
    local player = data.players[2]

    local magicX = player.x + 180
    local magicXDelta = 150
    local magicY = player.y
    local magicYDelta = 50
    local perRow = 1
    local onRow = 0
    local enemy = data.players[2]
    local gemsPack = game.assets:getImagePack('gems')

    for i=0,10 do
        local id = 'c'..math.pow(2,i)
        value = data.magic[enemy.id][id]

        local img = gemsPack:get(id)
        if img then
            if onRow == perRow then
                magicX = player.x + 180
                magicY = magicY + magicYDelta
                onRow = 0
            end

            img:render(magicX, magicY, 0, 0.5, 0.5)
            --love.graphics.draw(game.assets.images.gems[id], magicX, magicY, 0, 0.5,0.5)
            love.graphics.print(value, magicX+40, magicY, 0, 2,2)
            magicX = magicX + magicXDelta
            onRow = onRow + 1
        end
    end
end