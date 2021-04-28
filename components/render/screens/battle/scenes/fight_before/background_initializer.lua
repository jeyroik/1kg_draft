InitializerImage = require "components/sources/initializers/image"

InitializerFightBeforeBackground = SourceInitializer:extend()

function InitializerFightBeforeBackground:initSource(background)
    local imageInitializer = InitializerImage()
    imageInitializer:initSource(background)

    background.sx = love.graphics.getWidth() / background.source:getWidth()
    background.sy = love.graphics.getHeight() / background.source:getHeight()
end

return InitializerFightBeforeBackground