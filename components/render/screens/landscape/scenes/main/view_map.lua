LandscapeMainViewMap = LayerView:extend()

function LandscapeMainViewMap:new(config)
    self.image = ''
    LandscapeMainViewMap.super.new(self, config)
end

function LandscapeMainViewMap:render()
    local background = game.assets:getImage(self.image)

    local sx = love.graphics.getWidth() / background:getWidth()
    local sy = love.graphics.getHeight() / background:getHeight()

    background:render(0, 0, 0, sx, sy)
end