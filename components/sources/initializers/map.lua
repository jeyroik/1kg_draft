local SourceInitializer = require 'components/sources/initializers/initializer'
local InitializerQuads  = require 'components/sources/initializers/quads'
local MapCell           = require 'components/sources/map/cell'
local MapObject         = require 'components/sources/map/object'

InitializerMap = SourceInitializer:extend()

function InitializerMap:initSource(map)
    InitializerQuads.initSource(self, map)

    for layerName, layer in pairs(map.layers) do
        map.map[layerName] = {}
        for row, columns in pairs(layer) do
            map.map[layerName][row] = {}
            for column, number in pairs(columns) do
                local cell = game.graphics:getItem(row, column)

                map.map[layerName][row][column] = MapCell({
                    alias   = 'map_cell',
                    path    = map.alias,
                    x       = cell.x,
                    y       = cell.y,
                    width   = map.width,
                    height  = map.height,
                    number  = number,
                    row     = row,
                    column  = column
                })
                game.graphics:setScale(map.map[layerName][row][column], 1, 1)
            end
        end
    end

    self:initObjects(map)
end

function InitializerMap:initObjects(map)
    for name, mapObject in pairs(map.objects) do
        map.mapObjects[name] = MapObject({
            name        = name,
            map         = map,
            title       = mapObject.title,
            description = mapObject.description,
            schema      = mapObject.schema,
            layer       = mapObject.layer,
            width       = mapObject.width,
            height      = mapObject.height
        })
    end
end

return InitializerMap