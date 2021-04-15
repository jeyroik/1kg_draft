InitializerStone = SourceInitializer:extend()

function InitializerStone:initSource(stone)

--[[    local sw = love.graphics.getWidth()
    local calcSize = sw * 0.2 / stone.boardSize

    if calcSize > stone.size then
        local scale = calcSize/stone.size
        if scale > 1 then


            stone.size = stone.size * scale
            stone.scale = scale
        end
    end

    stone.x = stone.column * stone.size + stone.deltaX
    stone.y = stone.row * stone.size
    stone.width = stone.size
    stone.height = stone.size]]
end

return InitializerStone