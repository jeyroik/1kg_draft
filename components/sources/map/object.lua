MapObject = Source:extend()

function MapObject:new(config)
    self.name = ''
    self.schema = {}
    self.map = {}
    self.layer = ''

    config.initializer = config.initializer or 'components/sources/initializers/map/object'

    MapObject.super.new(self, config)
end