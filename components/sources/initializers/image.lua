InitializerImage = SourceInitializer:extend()

function InitializerImage:initSource(image)
    love.filesystem.append('log.txt', '\nInitializerImage:sourceInit() - got in')

    image.source = love.graphics.newImage(self:buildPath(image.path))

    love.filesystem.append('log.txt', '\nInitializerImage:sourceInit() - path is ' .. self:buildPath(image.path))
end

function InitializerImage:getPath()
    return 'images/'
end

return InitializerImage