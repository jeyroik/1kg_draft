local Source = require 'components/sources/source'

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

function Quads:draw(num)
    if num > 0 then
        love.graphics.draw(self.image.source, self.source[num], self.x, self.y, self.radian, self.sx, self.sy)
    end
end

function Quads:count()
    return #self.source
end

return Quads