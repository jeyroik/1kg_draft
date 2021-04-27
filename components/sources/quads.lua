Quads = Source:extend()

function Quads:new(config)
    self.columns = 0
    self.rows = 0

    config.initializer = config.initializer or 'components/sources/initializers/quads'

    Quads.super.new(self, config)
end

function Quads:render(num)
    local render = Render(self.renderConfig)
    render:draw(self, num)
end

function Quads:draw(dx, dy, radian, sx, sy, num)
    dx     = dx     + self.x
    dy     = dy     + self.y
    radian = radian * self.radian
    sx     = sx     * self.sx
    sy     = sy     * self.sy

    if num > 0 then
        love.graphics.draw(self.image.source, self.source[num], dx, dy, radian, sx, sy)
    end
end