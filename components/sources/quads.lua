Quads = Source:extend()

function Quads:new(config)
    self.columns = 0
    self.rows = 0

    config.source_type = 'quads'

    Quads.super.new(self, config)
end

function Quads:render(num, dx, dy)
    love.graphics.draw(self.image.source, self.source[num], self.x+dx, self.y+dy)
end