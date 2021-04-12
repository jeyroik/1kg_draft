BattleFightBeforeViewBackground = LayerView:extend()

function BattleFightBeforeViewBackground:new(config)
    self.image = ''
    self.scale = 2
    BattleFightBeforeViewBackground.super.new(self, config)
end

function BattleFightBeforeViewBackground:render(game)
    local background = game.assets:getImage(self.image)
    background:setScale(self.scale)
    background:render(80, 0)
end