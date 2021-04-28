BattleFightBeforeViewBackground = LayerView:extend()

function BattleFightBeforeViewBackground:new(config)
    self.image = ''
    BattleFightBeforeViewBackground.super.new(self, config)
end

function BattleFightBeforeViewBackground:render()
    local background = game.assets:getImage(self.image)

    background:render()
end