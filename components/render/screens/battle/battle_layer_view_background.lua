BattleLayerViewBackground = LayerView:extend()

function BattleLayerViewBackground:new(config)
    self.image = ''
    self.scale = 2
    BattleLayerViewBackground.super.new(self, config)
end

function BattleLayerViewBackground:render(game)
    background = game.assets:getImage(self.image)
    background:setScale(self.scale)
    background:render(80, 0)
end