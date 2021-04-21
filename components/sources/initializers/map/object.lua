InitializerMapObject = SourceInitializer:extend()

function InitializerMapObject:initSource(mapObject)
    local x = '-'
    local y = '-'
    local width = 0
    local height = 0
    
    local schema = mapObject.schema

    for _,particle in pairs(schema) do
        local row, column = particle[1], particle[2]
        local cell = mapObject.map.map[mapObject.layer][row][column]
        local px, py = cell.x, cell.y

        if x == '-' then
            x = px
        end

        if y == '-' then
            y = py
        end

        if px < x then
            x = px
        end

        if py < y then
            y = py
        end

        if px > width then
            width = px
        end

        if py > height then
            height = py
        end
    end

    mapObject.x = x
    mapObject.y = y
    mapObject.width = width
    mapObject.height = height+mapObject.map.height
    mapObject.map = nil
end

return InitializerMapObject