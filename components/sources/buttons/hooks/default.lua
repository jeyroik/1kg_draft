HookDefault = Hook:extend()

function HookDefault:new(config)
    self.button = config.button or {}
    
    HookDefault.super.new(self, config)

    self.alias = config.alias
end

function HookDefault:catch(screen, args, event, stage)
    if event == 'mouseMoved' and stage == 'before' then
        self:mouseMoved(args)
    elseif event == 'mousePressed' and stage == 'before' then
        self:mousePressed(args)
    end
end

function HookDefault:mouseMoved(args)
    if self.button:isMouseOn(args.x, args.y) then
        self.button:hover()
    elseif self.button.state ~= 'default' then
        self.button:released()
    end
end

function HookDefault:mousePressed(args)
    if self.button:isMouseOn(args.x, args.y) then
        self.button:click()
        game:runEvent(self.button.name..'ButtonPressed', self.button)
    end
end

return HookDefault