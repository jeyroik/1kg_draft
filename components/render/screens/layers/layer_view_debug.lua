LayerViewDebug = LayerView:extend()

function LayerViewDebug:render()
    self:printDbg()
    --self:flushDbg()
end