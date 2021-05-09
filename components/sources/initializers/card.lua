InitializerCard = SourceInitializer:extend()

function InitializerCard:initSource(card)
    local cardDefault = game.assets:getQuads(card.avatar.path)
    card.width = cardDefault:getWidth()
    card.height = cardDefault:getHeight()
    card.sx = love.graphics.getHeight()/1080
    card.sy = card.sx

    self:initSkills(card)
end

function InitializerCard:initSkills(card)
    if card.skill.active.path then
        local active = require(card.skill.active.path)
        card.skill.active = active(card.skill.active)
    end
    
    for alias,skill in pairs(card.skill.passive) do
        local passive = require(skill.path)
        card.skill.passive[alias] = passive(skill)
    end
end

return InitializerCard