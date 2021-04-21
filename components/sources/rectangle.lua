Rectangle = Source:extend()

function Rectangle:new(config)
    self.color = {1,1,1,1}
    self.mode = 'line'

    config.initializer = 'components/sources/initializers/rectangle'

    Rectangle.super.new(self, config)
end

function Rectangle:render(dx, dy, radian, sx, sy)
    dx = dx or 0
    dy = dy or 0
    radian = radian or 0
    sx = sx or self.sx
    sy = sy or self.sy

    love.graphics.setColor(self.color)
    love.graphics.rectangle(
            self.mode,
            self.x+dx,
            self.y+dy,
            self.width,
            self.height,
            radian,
            sx,
            sy
    )
    love.graphics.setColor({1,1,1,1})
end