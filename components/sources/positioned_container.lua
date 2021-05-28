SourcePositioned = require 'components/sources/source_positioned'

PositionedContainer = SourcePositioned:extend()

function PositionedContainer:new(source)
    self.source = source
end

function PositionedContainer:drawSource()
    self.source.x = self.x
    self.source.y = self.y
    self.source.sx = self.sx
    self.source.sy = self.sy
    self.source:draw()
end

return PositionedContainer