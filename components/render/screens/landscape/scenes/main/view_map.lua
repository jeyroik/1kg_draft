LandscapeMainViewMap = LayerView:extend()

function LandscapeMainViewMap:new(config)
    self.image = 'map'
    LandscapeMainViewMap.super.new(self, config)
end

function LandscapeMainViewMap:render()
    local background = game.assets:getQuads(self.image)

    for i=1, 20 do
        background:render(i, i*60)
    end
end