local SourceInitializer = require 'components/sources/initializers/initializer'

InitializerText = SourceInitializer:extend()

function InitializerText:initSource(text)
    text.source = love.graphics.newText(love.graphics.getFont(text.font or nil))
    text.source:set(text.body)
    text:setSize(text.source:getWidth(), text.source:getHeight())
end

return InitializerText