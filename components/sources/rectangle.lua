Rectangle = Source:extend()

function Rectangle:new(config)
    config = config or {}

    self.color = {1,1,1,1}
    self.mode = 'line'

    config.initializer = 'components/sources/initializers/rectangle'

    Rectangle.super.new(self, config)
end

function Rectangle:draw(dx, dy, radian, sx, sy)
    dx     = dx     + self.x
    dy     = dy     + self.y
    radian = radian * self.radian
    sx     = sx     * self.sx
    sy     = sy     * self.sy

    love.graphics.setColor(self.color)
    love.graphics.rectangle(
        self.mode,
        dx,
        dy,
        self.width,
        self.height,
        radian,
        sx,
        sy
    )
    love.graphics.setColor({1,1,1,1})
end