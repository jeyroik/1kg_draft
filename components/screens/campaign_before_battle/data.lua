local LayerData = require "components/screens/layers/layer_data"

Data = LayerData:extend()

function Data:new(config)
    self.location = ''
    self.enemy = {}
    
    Data.super.new(self, config)
end

function Data:init(location, enemy)
    self.location = location
    self.enemy = enemy
end

return Data