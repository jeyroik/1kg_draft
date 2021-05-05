local LayerView = require "components/screens/layers/layer_view"

PlayerSceneMainView = LayerView:extend()

function PlayerSceneMainView:new(config)
    PlayerSceneMainView.super.new(self, config)

    self.isOn = false
end

function PlayerSceneMainView:render(data, scene)
    scene.back:draw()
    scene.header:draw()
    scene.inputField:draw()
    scene.playerName:draw()
    scene.submit:draw()

    if scene.textCursor then
        scene.inputCursor:draw()
    end
end

return PlayerSceneMainView