MapCell = Source:extend()

function MapCell:new(config)
    self.row = 0
    self.column = 0
    self.number = 0

    config.initializer = 'components/sources/initializers/map/cell'
    MapCell.super.new(self, config)
end