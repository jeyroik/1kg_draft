local SourceInitializer = require 'components/sources/initializers/initializer'
local InitializerCard   = require 'components/sources/initializers/card'
local MagicGem          = require 'components/sources/magic_gem'

InitializerPlayer = SourceInitializer:extend()

function InitializerPlayer:initSource(player)
    self:initCoords(player)
    self:initAvatar(player)
    self:initGems(player)
end

function InitializerPlayer:initAvatar(player)
    player:addCard(player)
end

function InitializerPlayer:initCoords(player)
    if player.number == 1 then
        player.x = love.graphics.getWidth()*0.1
        player.y = love.graphics.getHeight()*0.1
    else
        player.x = love.graphics.getWidth()*0.85
        player.y = love.graphics.getHeight()*0.1
    end

    local parentInit = InitializerCard({})
    parentInit:initSource(player)
end

function InitializerPlayer:initGems(player)
    local magics = game.assets:getMisc('magic')
    local gemsPack = game.assets:getImagePack('gems')
    local sx = player.cards[1].sx
    local magicX = player.x - 80*sx
    local magicY = player.y
    local magicYDelta = 50*sx
    local perRow = 1
    local onRow = 0

    for _,name in pairs(magics.namesOrder) do
        local magic = magics.items[magics.names[name]]

        if gemsPack:get(magic:getType()) then
            if onRow == perRow then
                magicX = player.x - 80*sx
                magicY = magicY + magicYDelta
                onRow = 0
            end

            local gem = gemsPack:get(magic:getType())
            local plMagic = player.magic[magic:getName()]

            player.gems[name] = MagicGem({
                amount = 0,
                amountText = Text({ body = '0', x = magicX+40, y = magicY }),
                mana = plMagic.mana,
                power = plMagic.power,
                magic = magic,
                image = {
                    x = magicX,
                    y = magicY,
                    sx = sx,
                    sy = sx,
                    path = gem.path
                },
                text = {
                    x = 0,
                    y = 0,
                    sx = sx,
                    sy = sy,
                    body = magic:getTitle() .. ': mana = '..plMagic.mana..', power = '..plMagic.power,
                    overlay_mode = 'fill',
                    overlay_color = {1,1,1,0.6},
                    overlay_offset = 5
                }
            })

            onRow = onRow + 1
        end
    end
end

return InitializerPlayer