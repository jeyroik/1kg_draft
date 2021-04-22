InitializerMap = SourceInitializer:extend()

function InitializerMap:initSource(map)
    InitializerQuads.initSource(self, map)

    for layerName, layer in pairs(map.layers) do
        map.map[layerName] = {}
        for row, columns in pairs(layer) do
            map.map[layerName][row] = {}
            for column, number in pairs(columns) do
                map.map[layerName][row][column] = MapCell({
                    x = (column-1)*(map.width*map.sx),
                    y = (row-1)*(map.width*map.sy),
                    width = map.width,
                    height = map.height,
                    sx = map.sx,
                    sy = map.sy,
                    number = number,
                    row = row,
                    column = column
                })
            end
        end
    end

    self:initObjects(map)
end

function InitializerMap:initObjects(map)
    for name, mapObject in pairs(map.objects) do
        map.mapObjects[name] = MapObject({
            name = name,
            title = mapObject.title,
            description = mapObject.description,
            schema = mapObject.schema,
            layer = mapObject.layer,
            map = map
        })
    end
end

return InitializerMap