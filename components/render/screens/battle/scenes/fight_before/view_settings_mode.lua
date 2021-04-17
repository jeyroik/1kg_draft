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

    local title = Text({ body = 'Choose mode', sx = 4, sy = 4 })
    title:stickToTop(buttons[1])
    title:render(0, -40)
end