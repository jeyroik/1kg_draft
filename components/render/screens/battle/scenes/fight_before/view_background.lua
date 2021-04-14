BattleFightBeforeViewBackground = LayerView:extend()

function BattleFightBeforeViewBackground:new(config)
    self.image = ''
    BattleFightBeforeViewBackground.super.new(self, config)
end

function BattleFightBeforeViewBackground:render()
    local background = game.assets:getImage(self.image)

    local sx = love.graphics.getWidth() / background:getWidth()
    local sy = love.graphics.getHeight() / background:getHeight()

    background:render(0, 0, 0, sx, sy)
end