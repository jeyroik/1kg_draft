BattleLayerViewPlayers = LayerView:extend()

function BattleLayerViewPlayers:render(game, data)
    self:renderMagic(game)
    self:renderFrameCurrentPlayer(data)
    self:renderPlayersInfo(data)
end

function Battle:renderPlayersInfo(data)
    local p1 = data.players[1]
    local p2 = data.players[2]

    love.graphics.print('\nPlayer 1:'..'\n\nHealth: '.. p1.health, p1.x, 100, 0, 2,2)
    love.graphics.print('\nPlayer 2:'..'\n\nHealth: '.. p2.health, p2.x, 100, 0,2,2)
end

function BattleLayerViewPlayers:renderFrameCurrentPlayer(data)
    local current = data.players[data.current]
    local frameX = current:getCoordsFrame(5)

    love.graphics.rectangle('line', frameX, 120, 200, 40)
end

function BattleLayerViewPlayers:renderMagic(game)
    self:renderPlayer1Magic(game)
    self:renderPlayer2magic(game)
end

function BattleLayerViewPlayers:renderPlayer1Magic(game)
    local magicX = 270
    local magicXDelta = 150
    local magicY = 750
    local magicYDelta = 50
    local perRow = 3
    local onRow = 0
    local current = self.players[1]

    for i=0,10 do
        local id = 'c'..math.pow(2,i)
        value = self.magic[current.id][id]

        if game.assets.images.gems[id] then
            if onRow == perRow then
                magicX = 270
                magicY = magicY + magicYDelta
                onRow = 0
            end

            love.graphics.draw(game.assets.images.gems[id], magicX, magicY, 0, 0.5,0.5)
            love.graphics.print(value, magicX+40, magicY, 0, 2,2)
            magicX = magicX + magicXDelta
            onRow = onRow + 1
        end
    end
end

function BattleLayerViewPlayers:renderPlayer2magic(game)
    local magicX = 1270
    local magicXDelta = 150
    local magicY = 750
    local magicYDelta = 50
    local perRow = 3
    local onRow = 0
    local enemy = self.players[2]

    for i=0,10 do
        local id = 'c'..math.pow(2,i)
        value = self.magic[enemy.id][id]

        if game.assets.images.gems[id] then
            if onRow == perRow then
                magicX = 1270
                magicY = magicY + magicYDelta
                onRow = 0
            end

            love.graphics.draw(game.assets.images.gems[id], magicX, magicY, 0, 0.5,0.5)
            love.graphics.print(value, magicX+40, magicY, 0, 2,2)
            magicX = magicX + magicXDelta
            onRow = onRow + 1
        end
    end
end