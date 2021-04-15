BattleFightBeforeViewSettingsMode = LayerView:extend()

function BattleFightBeforeViewSettingsMode:new(config)
    BattleFightBeforeViewSettingsMode.super.new(self, config)

    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleFightBeforeViewSettingsMode:render(data, scene)
    local buttons = {
        game.assets:getButton('pl1'),
        game.assets:getButton('pl2')
    }

    for i, btn in pairs(buttons) do
        btn:render()
    end

    local title = Text({ body = 'Choose mode', sx = 2, sy = 2 })
    title:setToCenter(true)
    title:render(0, 40)
end