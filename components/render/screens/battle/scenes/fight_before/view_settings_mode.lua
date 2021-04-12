BattleFightBeforeViewSettingsMode = LayerView:extend()

function BattleFightBeforeViewSettingsMode:new(config)
    BattleFightTheEndViewTheEnd.super.new(self, config)

    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleFightBeforeViewSettingsMode:render(data)
    local btn = game.assets:getImage('fs__btn')
    local text = Text({body = 'Choose mode', x = self.center.x-50, y = 140})
    text:render()
    btn:render(100, 140)
    btn:render(200, 140)
end