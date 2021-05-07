MapObject = Source:extend()

function MapObject:new(config)
    self.name = ''
    self.title = ''
    self.description = ''
    self.schema = {}
    self.map = {}
    self.layer = ''
    self.dispatcher = {}

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

function MapObject:mousePressed(screen, scene)
    if dispatcher.path then
        self:initializeOne('dispatcher')
        self.dispatcher:run(screen, scene)
    end
end