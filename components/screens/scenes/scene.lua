local State = require 'components/states/state'

Scene = State:extend()

function Scene:new(config)
    self.views = {}
    self.arguments = {}

    Scene.super.new(self, config)
end

function Scene:getViews()
    return self.views
end

function Scene:initState(screen)
    
end

function Scene:update(screen, dt)

end

function Scene:mouseMoved(screen, x, y, dx, dy, isTouch)

end

function Scene:mousePressed(screen, x, y, button, isTouch, presses)

end

function Scene:mouseReleased(screen, x, y, button, isTouch, presses)

end

function Scene:keyPressed(screen, key)

end

function Scene:textInput(screen, text)

end

function Scene:buttonPressed(buttonName, button)
    
end

function Scene:runEvent(screen, name, ...)
    if self[name] then
        self[name](self, screen, ...)
    end
end

return Scene