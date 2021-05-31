local LayerView = require "components/screens/layers/layer_view"

LayerViewDebug = LayerView:extend()

function LayerViewDebug:draw()
    self:printDbg()
end

return LayerViewDebug