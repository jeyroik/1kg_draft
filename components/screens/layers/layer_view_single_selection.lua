local LayerView = require "components/screens/layers/layer_view"

LayerViewSingleSelection = LayerView:extend()

function LayerViewSingleSelection:new(config)
    self.default = {
        color = {1,1,1},
        line_width = 1
    }
    LayerViewSingleSelection.super.new(self, config)
end

function LayerViewSingleSelection:render(data)
    if data.selection and data.selection.x then
        local color = data.selection.color or self.default.color
        local lineWidth = data.selection.line_width or self.default.line_width
        local cLineWidth = love.graphics.getLineWidth()

        love.graphics.setColor(color)
        love.graphics.setLineWidth( lineWidth )
        love.graphics.rectangle('line', data.selection.x, data.selection.y, data.selection.width, data.selection.height)
        love.graphics.setColor({ 1,1,1 })
        love.graphics.setLineWidth(cLineWidth)
    end
end

return LayerViewSingleSelection