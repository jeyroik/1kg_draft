local LayerView = require "components/screens/layers/layer_view"

CampaignMapMainViewMap = LayerView:extend()

function CampaignMapMainViewMap:new(config)
    self.map_name = 'main'
    CampaignMapMainViewMap.super.new(self, config)
end

function CampaignMapMainViewMap:render(data, scene)
    local map = game.assets:getMap(self.map_name)
    love.graphics.translate(game.translate.x, game.translate.y)
    map:render()
    if scene.label.x then
        game.assets:getCursor('hand'):setOn()
        scene.label:render()
        local selectedObject = map:getObject(scene.selected)
        selectedObject:drawSelection()
    else
        game.assets:getCursor('hand'):reset()
    end
    love.graphics.translate(-game.translate.x, -game.translate.y)
end

return CampaignMapMainViewMap