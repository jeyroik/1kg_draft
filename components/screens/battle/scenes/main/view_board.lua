local LayerView = require "components/screens/layers/layer_view"

ViewBoard = LayerView:extend()

function ViewBoard:render(data)
    data.board:render()
end

return ViewBoard