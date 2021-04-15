InitializerText = SourceInitializer:extend()

function InitializerText:initSource(text)
    text.source = love.graphics.newText(love.graphics.getFont(text.font or nil))
    text.source:set(text.body)
end

return InitializerText