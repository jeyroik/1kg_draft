Scene = GameObject:extend()

function Scene:new(config)
    self.id = self:getId()
    self.views = {}
    Scene.super.new(self, config)
end

function Scene:getViews()
    return self.views
end

function Scene:init(screen)
    Scene.super.init(self)
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