LandscapeMainViewMap = LayerView:extend()

function LandscapeMainViewMap:new(config)
    self.map_name = 'main'
    LandscapeMainViewMap.super.new(self, config)
end

function LandscapeMainViewMap:render(data, scene)
    local map = game.assets:getMap(self.map_name)
    love.graphics.translate(scene.translate.x, scene.translate.y)
    map:render()
    love.graphics.translate(-scene.translate.x, -scene.translate.y)

    if scene.label.x then
        scene.label:render()
    end
end