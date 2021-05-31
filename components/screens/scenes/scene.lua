local State = require 'components/states/state'

Scene = State:extend()

function Scene:new(config)
    self.views = {}
    self.arguments = {}
    self.name = ''

    Scene.super.new(self, config)
end

function Scene:getViews()
    return self.views
end

function Scene:initState(screen)
    
end

function Scene:update(screen, dt)
    game.events:riseEvent('update.scene', {dt=dt, screen=screen, scene=self})
	game.events:riseEvent('update.scene.'..screen.name..'.'..self.name, {dt=dt, screen=screen, scene=self})
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

function Screen:createButton(config)
    config.name = game.__state__ .. '__' .. self.name .. '__' .. config.name .. '_button_'
    config.screenName = game.__state__
    config.sceneName  = self.name
    
    return Button(config)
end

return Scene