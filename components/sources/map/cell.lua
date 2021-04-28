MapCell = Source:extend()

function MapCell:new(config)
    self.row = 0
    self.column = 0
    self.number = 0
    self.previous = 0

    config.initializer = 'components/sources/initializers/map/cell'
    MapCell.super.new(self, config)
end

function MapCell:draw()
    local cell = game.assets:getQuads(self.path)
    cell.x = self.x
    cell.y = self.y
    cell.width = self.width
    cell.height = self.height
    cell.sx = self.sx
    cell.sy = self.sy
    cell:draw(self.number)
end

function MapCell:changeNumberTo(number)
    self.previous = self.number
    self.number = number
end

function MapCell:restoreNumber()
    self.number = self.previous
end