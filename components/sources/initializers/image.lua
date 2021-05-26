local SourceInitializer = require 'components/sources/initializers/initializer'

InitializerImage = SourceInitializer:extend()

function InitializerImage:initSource(image)
    image.source = love.graphics.newImage(self:buildPath(image.path))
end

function InitializerImage:getPath()
    return 'images/'
end

return InitializerImage