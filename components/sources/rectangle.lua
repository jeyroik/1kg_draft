local Source = require 'components/sources/source'

Rectangle = Source:extend()

function Rectangle:new(config)
    config = config or {}

    self.color = {1,1,1,1}
    self.mode = 'line'

    config.initializer = config.initializer or 'components/sources/initializers/rectangle'

    Rectangle.super.new(self, config)
end

function Rectangle:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle(
        self.mode,
        self.x,
        self.y,
        self.width*self.sx,
        self.height*self.sy,
        self.radian
    )
    love.graphics.setColor({1,1,1,1})
end

return Rectangle