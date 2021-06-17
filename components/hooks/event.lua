local Hook = require 'components/hooks/hook'

HookEvent = Hook:extend()

function HookEvent:new(config)
    self.gameObject = {}
    
    HookEvent.super.new(self, config)
end

function HookEvent:on(eventName, event)
    if eventName:find('mouseMoved') then
        self.gameObject:eventMouseMoved(event)
    elseif eventName:find('mousePressed') then
        self.gameObject:eventMousePressed(event)
    end
end

return HookEvent