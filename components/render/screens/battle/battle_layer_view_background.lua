BattleLayerViewBackground = LayerView:extend()

function BattleLayerViewBackground:render(game, data)
    background = game.assets:getImage(self.background)
    background:setScale(data.background.scale or 2)
    background:render(80, 0)
end