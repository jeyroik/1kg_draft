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
    game.events:riseEvent('sceneInitialized.'..screen.name..'.'..self.name, { screen=screen, scene=self })
end

function Scene:update(screen, dt)
    game.events:riseEvent('update.scene', {dt=dt, screen=screen, scene=self})
	game.events:riseEvent('update.scene.'..screen.name..'.'..self.name, {dt=dt, screen=screen, scene=self})
end

function Scene:mouseMoved(screen, x, y, dx, dy, isTouch)
    game.events:riseEvent(
        'mouseMoved.'..screen.name..'.'..self.name, 
        { x=x, y=y, dx=dx, dy=dy, isTouch=isTouch, screen=screen, scene=self }
    )
end

function Scene:mousePressed(screen, x, y, button, isTouch, presses)
    self:log('[Scene:mousePressed] runEvent "'..'mousePressed.'..screen.name..'.'..self.name..'"')
    game.events:riseEvent(
        'mousePressed.'..screen.name..'.'..self.name, 
        { x=x, y=y, button=button, isTouch=isTouch, presses=presses, screen=screen, scene=self }
    )
end

function Scene:mouseReleased(screen, x, y, button, isTouch, presses)
    game.events:riseEvent(
        'mouseReleased.'..screen.name..'.'..self.name, 
        { x=x, y=y, button=button, isTouch=isTouch, presses=presses, screen=screen, scene=self }
    )
end

function Scene:keyPressed(screen, key)
    game.events:riseEvent('keyPressed.'..screen.name..'.'..self.name, { key=key, screen=screen, scene=self })
end

function Scene:textInput(screen, text)
    game.events:riseEvent('textInput.'..screen.name..'.'..self.name, { text=text, screen=screen, scene=self })
end

return Scene