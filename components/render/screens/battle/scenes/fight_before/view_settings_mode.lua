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
        btn:setToCenter(true)
        btn:render(0,0,0,VisibleObject.globalScale, VisibleObject.globalScale)
    end

    local title = Text({ body = 'Choose mode', sx = 4*VisibleObject.globalScale, sy = 4*VisibleObject.globalScale })
    title:stickToTop(buttons[1])
    title:render(0, -40)
end