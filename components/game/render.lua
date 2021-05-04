Render = Object:extend()
Render:implement(Printer)
Render:implement(Config)
Render.previousResolution = '0x0'

function Render:new(config)
    self.scale = 'size' -- size | position | none
    self.origin = {
        x = 0,
        y = 0,
        w = 800,
        h = 600
    }

    self:applyConfig(config)

    self.windowWidth  = love.graphics.getWidth()
    self.windowHeight = love.graphics.getHeight()
end

function Render:draw(object, ...)
    local args = {...}
    local scale = {
        size = function ()
            self:assignParameters(object, object.x, object.y, object.radian, self.windowWidth/self.origin.w, self.windowHeight/self.origin.h)
        end,
        position = function ()
            local sx = self.windowWidth/self.origin.w
            local sy = self.windowHeight/self.origin.h
            local dx = sx * self.origin.x
            local dy = sy * self.origin.y

            self:assignParameters(object, dx, dy, object.radian, sx, sy)
        end,
        size_position = function ()
            local sx = self.windowWidth/self.origin.w
            local sy = self.windowHeight/self.origin.h
            local dx = sx * self.origin.x
            local dy = sy * self.origin.y

            self:assignParameters(object, dx, dy, object.radian, sx, sy)
        end,
        none = function()
            self:assignParameters(object, object.x, object.y, object.radian, object.sx, object.sy)
        end
    }

    local currentResolution = love.graphics.getWidth()..'x'..love.graphics.getHeight()

    if object.previousResolution ~= currentResolution then
        if scale[self.scale] then
            scale[self.scale]()
        elseif object.renderConfig.render then
            object.renderConfig.render(args)
        end

        object:reload()
        object.previousResolution = currentResolution
    end

    object:draw(args)
end

function Render:assignParameters(object, dx, dy, radian, sx, sy)
    object.x      = dx
    object.y      = dy
    object.radian = radian
    object.sx     = sx
    object.sy     = sy
end