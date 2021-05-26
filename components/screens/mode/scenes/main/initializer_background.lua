InitializerImage = require "components/sources/initializers/image"

InitializerModeBackground = SourceInitializer:extend()

function InitializerModeBackground:initSource(background)
    local imageInitializer = InitializerImage()
    imageInitializer:initSource(background)

    background.sx = love.graphics.getWidth() / background.source:getWidth()
    background.sy = love.graphics.getHeight() / background.source:getHeight()
end

return InitializerModeBackground