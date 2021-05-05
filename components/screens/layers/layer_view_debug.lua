local LayerView = require "components/screens/layers/layer_view"

LayerViewDebug = LayerView:extend()

function LayerViewDebug:render()
    self:printDbg()
end

return LayerViewDebug