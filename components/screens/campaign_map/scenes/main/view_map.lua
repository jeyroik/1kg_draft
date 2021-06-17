local LayerView = require "components/screens/layers/layer_view"

ViewMap = LayerView:extend()

function ViewMap:new(config)
    self.map_name = 'main'
    ViewMap.super.new(self, config)
end

function ViewMap:draw(data, scene)
    local map = scene.map
    love.graphics.translate(game.translate.x, game.translate.y)
    map:draw()
    if scene.label.x then
        game.assets:getCursor('hand'):setOn()
        scene.label:draw()
        local selectedObject = map:getObject(scene.selected)
        selectedObject:drawSelection()
    else
        game.assets:getCursor('hand'):reset()
    end
    love.graphics.translate(-game.translate.x, -game.translate.y)
end

return ViewMap