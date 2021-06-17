local Hook = require 'components/hooks/hook'

HookDefault = Hook:extend()

function HookDefault:new(config)
    self.card = {} 
    HookDefault.super.new(self, config)
end

function HookDefault:on(eventName, event)
    if eventName:find('mouseMoved') then
        self:mouseMoved(event)
    elseif eventName:find('mousePressed') then
        self:mousePressed(event)
    end
end

function HookDefault:mouseMoved(event)
    if self.card:isMouseOn(event.args.x, event.args.y) then
        self:log('[HookDefault:mouseMoved] card mouse on')
        game:runEvent('cardMouseOn', {name=name, card=self.card})
        return true
    end

    return false
end

function HookDefault:mousePressed(event)
    if self.card:isMouseOn(event.args.x, event.args.y) then
        game:runEvent('cardPressed', {name=name, card=self.card})
        return true
    end

    return false
end

return HookDefault