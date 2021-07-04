local LayerView = require "components/screens/layers/layer_view"

CampaignAuthSceneMainView = LayerView:extend()

function CampaignAuthSceneMainView:new(config)
    CampaignAuthSceneMainView.super.new(self, config)
end

function CampaignAuthSceneMainView:draw(data, scene)
    scene.back:draw()
    scene.header:draw()
    scene.inputField:draw()
    scene.playerName:draw()
    
    scene.submit:draw()

    if scene.textCursor then
        scene.inputCursor:draw()
    end
end

return CampaignAuthSceneMainView