PlayerSceneMainView = LayerView:extend()

function PlayerSceneMainView:new(config)
    PlayerSceneMainView.super.new(self, config)
end

function PlayerSceneMainView:render(data, scene)
    
    scene.back:render()
    scene.inputField:draw()
    scene.playerName:draw()
    
    if scene.textCursor then
        scene.inputCursor:draw()
    end
end

return PlayerSceneMainView