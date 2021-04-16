Quads = Source:extend()

function Quads:new(config)
    self.columns = 0
    self.rows = 0

    config.initializer = 'components/sources/initializers/quads'

    Quads.super.new(self, config)
end

function Quads:render(num, dx, dy, radian, sx, sy)
    dx = dx or 0
    dy = dy or 0
    radian = radian or self.radian
    sx = sx or self.sx
    sy = sy or self.sy

    love.graphics.draw(self.image.source, self.source[num], self.x+dx, self.y+dy, radian, sx, sy)
end