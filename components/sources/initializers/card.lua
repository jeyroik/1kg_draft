InitializerCard = SourceInitializer:extend()

function InitializerCard:initSource(card)
    local cardDefault = game.assets:getQuads(card.avatar.path)
    card.width = cardDefault:getWidth()
    card.height = cardDefault:getHeight()
    card.sx = love.graphics.getHeight()/1080
    card.sy = card.sx
end

return InitializerCard