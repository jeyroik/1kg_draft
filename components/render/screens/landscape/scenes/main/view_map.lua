LandscapeMainViewMap = LayerView:extend()

function LandscapeMainViewMap:new(config)
    self.map_name = 'main'
    LandscapeMainViewMap.super.new(self, config)
end

function LandscapeMainViewMap:render()
    local map = game.assets:getMap(self.map_name)
    map:render()
end