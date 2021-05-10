local LayerData = require "components/screens/layers/layer_data"

Data = LayerData:extend()

function Data:new(config)
    Data.super.new(self, config)
end

return Data