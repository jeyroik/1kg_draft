Source = require 'components/sources/source'

SourcePositioned = Source:extend()

function SourcePositioned:new(config)
    self.position = {
        row    = 0,
        column = 0
    }
    self.size = {
        width = 0,
        height = 0
    }

    SourcePositioned.super.new(self, config)
end

function SourcePositioned:setPosition(column, row)
    self.position.row    = row
    self.position.column = column
end

function SourcePositioned:offsetPosition(column, row)
    self.position.row    = self.position.row + row
    self.position.column = self.position.column + column
end

function SourcePositioned:setGridSize(width, height)
    self.size.width  = width
    self.size.height = height
end

function SourcePositioned:draw()
    game.graphics:put(self.source, self.position.column,self.position.row, self.size.width,self.size.height)
    self:drawSource()
end

function SourcePositioned:drawSource()
    love.graphics.print('Missed drawSource() realization', self.x, self.y, 0, self.sx, self.sy)
end

return SourcePositioned