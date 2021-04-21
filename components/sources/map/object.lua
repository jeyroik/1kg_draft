MapObject = Source:extend()

function MapObject:new(config)
    self.name = ''
    self.schema = {}
    self.map = {}
    self.layer = ''

    config.initializer = config.initializer or 'components/sources/initializers/map/object'

    MapObject.super.new(self, config)
end

function MapObject:isMouseOn(x, y)
    for _, particle in pairs(self.schema) do
        local row, column = particle[1], particle[2]
        if self.map.map[self.layer][row][column]:isMouseOn(x, y) then
            return true
        end
    end

    return false
end