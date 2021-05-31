Source = require 'components/sources/source'

SourcePositioned = Source:extend()

function SourcePositioned:new(config)
    SourcePositioned.super.new(self, config)
end

function SourcePositioned:draw()
    game.graphics:put(self, self.grid.column,self.grid.row, self.grid.width,self.grid.height)
    self:drawSource()
end

function SourcePositioned:drawSource()
    love.graphics.print('Missed drawSource() realization', self.x, self.y, 0, self.sx, self.sy)
end

return SourcePositioned