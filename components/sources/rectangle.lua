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
        self.width,
        self.height,
        self.radian,
        self.sx,
        self.sy
    )
    love.graphics.setColor({1,1,1,1})
end