local Event = require 'components/events/event'
local Hook  = require 'components/hooks/hook'

HookDefault = Hook:extend()

function HookDefault:new(config)
    self.button = {}
    
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
    if self.button:isMouseOn(event.args.x, event.args.y) then
        event.target = self.button
        self.button:hover()

        game.events:riseEvent('buttonHovered', {target = self.button})
        game.events:riseEvent('buttonHovered.'..self.button.name, {target = self.button})
        return true
    elseif self.button.state ~= 'default' then
        if event.target.name == self.button.name then
            event.target = {}
        end
        self.button:release()
        game.events:riseEvent('buttonReleased', {target = self.button})
        game.events:riseEvent('buttonReleased.'..self.button.name, {target = self.button})
        return false
    end
end

function HookDefault:mousePressed(event)
    if self.button:isMouseOn(event.args.x, event.args.y) then
        event.target = self.button
        self.button:click()

        game.events:riseEvent('buttonPressed', {target = self.button})
        game.events:riseEvent('buttonPressed.'..self.button.name, {target = self.button})
        return true
    end
end

return HookDefault