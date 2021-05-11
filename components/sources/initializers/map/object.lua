local SourceInitializer = require 'components/sources/initializers/initializer'

InitializerMapObject = SourceInitializer:extend()

function InitializerMapObject:initSource(mapObject)
    local cell = game.graphics:getItem(mapObject.schema[1][1], mapObject.schema[1][2])

    mapObject.x = cell.x
    mapObject.y = cell.y
    mapObject.width = cell.width * mapObject.width
    mapObject.height = cell.height * mapObject.height
end

return InitializerMapObject