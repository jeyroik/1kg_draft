local Source = require 'components/sources/source'

MapCell = Source:extend()

function MapCell:new(config)
    self.row = 0
    self.column = 0
    self.number = 0
    self.previous = 0
    self.cell = {}

    config.initializer = config.initializer or 'components/sources/initializers/map/cell'
    MapCell.super.new(self, config)
end

function MapCell:draw(map)
    local cell = map
    cell.x = self.x
    cell.y = self.y
    cell.width = self.width
    cell.height = self.height
    cell.sx = self.sx
    cell.sy = self.sy
    cell.super.draw(cell, self.number)
end

function MapCell:changeNumberTo(number)
    self.previous = self.number
    self.number = number
end

function MapCell:restoreNumber()
    self.number = self.previous
end

return MapCell