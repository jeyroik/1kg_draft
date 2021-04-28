InitializerText = require "components/sources/initializers/text"

InitializerFightBeforeHeader = SourceInitializer:extend()

function InitializerFightBeforeHeader:initSource(header)
    local textInitializer = InitializerText()
    textInitializer:initSource(header)

    --love.filesystem.append('log.txt', '\n[InitializerFightBeforeHeader:initSource] initialized...')

    header.x = love.graphics.getWidth()/2  - header.source:getWidth()/2
    header.y = love.graphics.getHeight()/3 - header.source:getHeight()/2
end

return InitializerFightBeforeHeader