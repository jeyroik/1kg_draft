local LayerView = require "components/screens/layers/layer_view"

ViewBoard = LayerView:extend()

function ViewBoard:draw(data)
    data.board:draw()
end

return ViewBoard