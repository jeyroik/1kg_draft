InitializerText = require "components/sources/initializers/text"

InitializerModeHeader = SourceInitializer:extend()

function InitializerModeHeader:initSource(header)
    local textInitializer = InitializerText()
    textInitializer:initSource(header)

    header.x = love.graphics.getWidth()/2  - header:getWidth()/2
    header.y = love.graphics.getHeight()/3 - header:getHeight()/2
end

return InitializerModeHeader