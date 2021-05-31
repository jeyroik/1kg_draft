local Hook = require 'components/hooks/hook'

HookEvent = Hook:extend()

function HookEvent:new(config)
    self.objects = {} -- <screen>.<scene>.<object> = object
    self.objectName = 'object'
    
    HookEvent.super.new(self, config)

    self.alias = config.alias
end

function HookEvent:catch(screen, args, event, stage)
    local screenName = game.__state__
    local sceneName  = screen.__state__

    if event == 'mouseMoved' and stage == 'after' then
        if self.objects[screenName] and self.objects[screenName][sceneName] then
            for name, object in pairs(self.objects[screenName][sceneName]) do
                local matchObject = self:mouseMoved(name, object, args)
                if matchObject then
                    object.selected = true
                    return
                elseif object.selected then
                    object.selected = false
                    game:runEvent(self.objectName..'MouseOut', {object=object})
                end
            end
        end 
    elseif event == 'mousePressed' and stage == 'after' then
        if self.objects[screenName] and self.objects[screenName][sceneName] then
            for name, object in pairs(self.objects[screenName][sceneName]) do
                
                local matchObject = self:mousePressed(name, object, args)
                if matchObject then
                    return
                end
            end
        end
    end
end

function HookEvent:mouseMoved(name, object, args)
    if object:isMouseOn(args.x, args.y) then
        game:runEvent(self.objectName..'MouseOn', {name=name, object=object})
        return true
    end

    return false
end

function HookEvent:mousePressed(name, object, args)
    if object:isMouseOn(args.x, args.y) then
        game:runEvent(self.objectName..'Pressed', {name=name, object=object})
        return true
    end

    return false
end

function HookEvent:add(screenName, sceneName, object)
    self.objects[screenName]                          = self.objects[screenName]            or {}
    self.objects[screenName][sceneName]               = self.objects[screenName][sceneName] or {}
    self.objects[screenName][sceneName][self:getId()] = object
end

return HookEvent