Scene = GameObject:extend()

function Scene:new(config)
    self.id = self:getId()
    self.views = {}
    Scene.super.new(self, config)
end

function Scene:getViews()
    return self.views
end

function Scene:init(game, screen)

end

function Scene:update(game, screen, dt)

end

function Scene:mouseMoved(game, screen, x, y, dx, dy, isTouch)

end

function Scene:mousePressed(game, screen, x, y, button, isTouch, presses)

end

function Scene:keyPressed(game, screen, key)

end