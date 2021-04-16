Rectangle = Source:extend()

function Rectangle:new(config)
    self.color = {1,1,1,1}
    self.mode = 'line'

    config.initializer = 'components/sources/initializers/rectangle'

    Rectangle.super.new(self, config)
end

function Rectangle:render(dx, dy)
    dx = dx or 0
    dy = dy or 0

    love.graphics.setColor(self.color)
    love.graphics.rectangle(
            self.mode,
            self.x+dx,
            self.y+dy,
            self.width,
            self.height
    )
    love.graphics.setColor({1,1,1,1})
end