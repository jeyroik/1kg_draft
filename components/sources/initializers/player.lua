require "components/sources/initializers/card"

InitializerPlayer = SourceInitializer:extend()

function InitializerPlayer:initSource(player)
    self:initBattleMagic(player)
    self:initCoords(player)
    self:initAvatar(player)
end

function InitializerPlayer:initAvatar(player)
    player:addCard(player)
end

function InitializerPlayer:initCoords(player)
    if player.number == 1 then
        player.x = love.graphics.getWidth()*0.1
        player.y = love.graphics.getHeight()*0.1
        player.sx = love.graphics.getWidth()/960
        player.sy = love.graphics.getHeight()/540
    else
        player.x = love.graphics.getWidth()*0.85
        player.y = love.graphics.getHeight()*0.1
        player.sx = love.graphics.getWidth()/960
        player.sy = love.graphics.getHeight()/540
    end

    InitializerCard.initSource(self, player)
end

function InitializerPlayer:initBattleMagic(player)
    local magics = game.assets:getMisc('magic')

    for _, magic in pairs(magics.items) do
        player.battle_magic[magic:getName()] = 0
    end
end

return InitializerPlayer