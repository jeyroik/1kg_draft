local SourceInitializer = require 'components/sources/initializers/initializer'
local Image = require 'components/sources/image'

InitializerCard = SourceInitializer:extend()

function InitializerCard:initSource(card)
    local cardDefault = Image({path = card.avatar.path..'/'..card.avatar.frame..'.jpg'})
    card.width  = cardDefault:getWidth()
    card.height = cardDefault:getHeight()

    self:initSkills(card)
    self:registerHooks(card)
end

function InitializerCard:registerHooks(card)
    local screen = game:getCurrentState()

    if not screen:hasHook('cards') then
        local hook = require 'components/sources/cards/hooks/default'
        screen:catchEvent('mousePressed', 'after', hook({alias = 'cards'}))
        screen:catchEvent('mouseMoved', 'after', hook({alias = 'cards'}))
    end
    
    local hook = screen:getHook('cards')
    hook:addCard(card.screenName, card.sceneName, card)
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