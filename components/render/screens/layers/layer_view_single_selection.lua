LayerViewSingleSelection = LayerView:extend()

function LayerViewSingleSelection:render(game, data)
    if data.selection and data.selection.x then
        local cColor = love.graphics.getColor()
        local cLineWidth = love.graphics.getLineWidth()
        love.graphics.setColor({0.5,0.5,0.5})
        love.graphics.setLineWidth( 5 )
        love.graphics.rectangle('line', data.selection.x, data.selection.y, data.selection.width, data.selection.height)
        love.graphics.setColor({ 1,1,1 })
        love.graphics.setLineWidth(cLineWidth)
    end
end