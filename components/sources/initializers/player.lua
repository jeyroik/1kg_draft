local SourceInitializer = require 'components/sources/initializers/initializer'
local InitializerCard   = require 'components/sources/initializers/card'
local MagicGem          = require 'components/sources/magic_gem'

InitializerPlayer = SourceInitializer:extend()

function InitializerPlayer:initSource(player)
    self:initCoords(player)
    self:initAvatar(player)
    self:initMagic(player)
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

function InitializerPlayer:initMagic(player)
    local magics        = game.assets:getMisc('magic')
    local magicPack     = game.assets:getImagePack('magic')
    local sx            = player.cards[1].sx
    local magicX        = player.x - 80*sx
    local magicY        = player.y
    local magicYDelta   = 50*sx
    local perRow        = 1
    local onRow         = 0

    for _,name in pairs(magics.namesOrder) do
        

        if magicPack:get(name) then
            if onRow == perRow then
                magicX = player.x - 80*sx
                magicY = magicY + magicYDelta
                onRow = 0
            end

            local magic      = magics:getByName(name)
            local magicImage = magicPack:get(name)
            local plMagic    = player.magic[name]

            player.magic[name] = MagicGem({
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
                    path = magicImage.path
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