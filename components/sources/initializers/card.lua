local SourceInitializer = require 'components/sources/initializers/initializer'
local Image = require 'components/sources/image'

InitializerCard = SourceInitializer:extend()

function InitializerCard:initSource(card)
    local cardDefault = game.resources:create('image', {path = card.avatar.path..'/'..card.avatar.frame..'.jpg'})
    card.width  = cardDefault:getWidth()
    card.height = cardDefault:getHeight()

    self:initSkills(card)
    self:registerHooks(card)
end

function InitializerCard:registerHooks(card)
    local hook = require 'components/sources/cards/hooks/default'

    game.events:on('mousePressed.'..card.screenName..'.'..card.sceneName, hook({card = card}))
    game.events:on('mouseMoved.'..card.screenName..'.'..card.sceneName, hook({card = card}))
end

function InitializerCard:initSkills(card)
    if card.initialized then
        return
    end
    
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