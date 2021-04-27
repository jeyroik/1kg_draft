Render = Object:extend()
Render:implement(Printer)
Render:implement(Config)

function Render:new(config)
    self.scale = 'size' -- size | position | none
    self.origin = {
        x = 0,
        y = 0,
        w = 800,
        h = 600
    }
    Render.super.new(self, config)

    self.windowWidth  = love.graphics.getWidth()
    self.windowHeight = love.graphics.getHeight()
end

function Render:draw(object, ...)
    local scale = {
        size = function ()
            object:draw(0, 0, 0, self.windowWidth/self.origin.w, self.windowHeight/self.origin.h, {...})
        end,
        position = function ()
            local sx = self.windowWidth/self.origin.w
            local sy = self.windowHeight/self.origin.h
            local dx = sx * self.origin.x
            local dy = sy * self.origin.y

            object:draw(dx, dy, 0, sx, sy, {...})
        end,
        none = function()
            object:draw(0, 0, 0, 1, 1, {...})
        end
    }

    if scale[self.scale] then
        scale[self.scale]()
    elseif object.renderConfig.render then
        object.renderConfig.render({...})
    else
        object:draw(0, 0, 0, 1, 1, {...})
    end
end
