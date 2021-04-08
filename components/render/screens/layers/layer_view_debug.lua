LayerViewDebug = LayerView:extend()
Screen:implement(Printer)

function LayerViewDebug:render()
    self:printDbg()
end