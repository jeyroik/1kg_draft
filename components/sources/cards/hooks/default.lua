local Hook = require 'components/hooks/hook'

HookDefault = Hook:extend()

function HookDefault:new(config)
    self.cards = {} -- <screen>.<scene>.<card> = card
    
    HookDefault.super.new(self, config)

    self.alias = config.alias
end

function HookDefault:catch(screen, args, event, stage)
    local screenName = game.__state__
    local sceneName  = screen.__state__

    if event == 'mouseMoved' and stage == 'after' then
        if self.cards[screenName] and self.cards[screenName][sceneName] then
            for name, card in pairs(self.cards[screenName][sceneName]) do
                local matchCard = self:mouseMoved(name, card, args)
                if matchCard then
                    card.selected = true
                    return
                elseif card.selected then
                    card.selected = false
                    game:runEvent('cardMouseOut', {card=card})
                end
            end
        end 
    elseif event == 'mousePressed' and stage == 'after' then
        if self.cards[screenName] and self.cards[screenName][sceneName] then
            for name, card in pairs(self.cards[screenName][sceneName]) do
                
                local matchCard = self:mousePressed(name, card, args)
                if matchCard then
                    return
                end
            end
        end
    end
end

function HookDefault:mouseMoved(name, card, args)
    if card:isMouseOn(args.x, args.y) then
        game:runEvent('cardMouseOn', {name=name, card=card})
        return true
    end

    return false
end

function HookDefault:mousePressed(name, card, args)
    if card:isMouseOn(args.x, args.y) then
        game:runEvent('cardPressed', {name=name, card=card})
        return true
    end

    return false
end

function HookDefault:addCard(screenName, sceneName, card)
    self.cards[screenName]                          = self.cards[screenName]            or {}
    self.cards[screenName][sceneName]               = self.cards[screenName][sceneName] or {}
    self.cards[screenName][sceneName][self:getId()] = card
end

return HookDefault