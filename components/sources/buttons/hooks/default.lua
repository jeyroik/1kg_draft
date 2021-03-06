local Hook = require 'components/hooks/hook'

HookDefault = Hook:extend()

function HookDefault:new(config)
    self.buttons = {} -- <screen>.<scene>.<button> = button
    
    HookDefault.super.new(self, config)

    self.alias = config.alias
end

function HookDefault:catch(screen, args, event, stage)
    local screenName = game.__state__
    local sceneName  = screen.__state__

    if event == 'mouseMoved' and stage == 'after' then
        if self.buttons[screenName] and self.buttons[screenName][sceneName] then
            for name, button in pairs(self.buttons[screenName][sceneName]) do
                local matchButton = self:mouseMoved(name, button, args)
                if matchButton then
                    return
                end
            end
        end 
    elseif event == 'mousePressed' and stage == 'after' then
        if self.buttons[screenName] and self.buttons[screenName][sceneName] then
            for name, button in pairs(self.buttons[screenName][sceneName]) do
                
                local matchButton = self:mousePressed(name, button, args)
                if matchButton then
                    return
                end
            end
        end
    end
end

function HookDefault:mouseMoved(name, button, args)
    if button:isMouseOn(args.x, args.y) then
        button:hover()
        return true
    elseif button.state ~= 'default' then
        button:released()
        return false
    end
end

function HookDefault:mousePressed(name, button, args)
    if button:isMouseOn(args.x, args.y) then
        button:click()
        button:released()
        game:buttonPressed(name, button)
        return true
    end
end

function HookDefault:addButton(screen, scene, button)
    self.buttons[screen]                     = self.buttons[screen]        or {}
    self.buttons[screen][scene]              = self.buttons[screen][scene] or {}
    self.buttons[screen][scene][button.name] = button
end

return HookDefault