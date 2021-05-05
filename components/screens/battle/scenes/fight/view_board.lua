local LayerView = require "components/screens/layers/layer_view"

BattleFightViewBoard = LayerView:extend()

function BattleFightViewBoard:render(data)
    data.board:render()
end