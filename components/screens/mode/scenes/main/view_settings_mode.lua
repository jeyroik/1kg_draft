local LayerView = require "components/screens/layers/layer_view"

ModeViewSettingsMode = LayerView:extend()

function ModeViewSettingsMode:new(config)
    ModeViewSettingsMode.super.new(self, config)
end

function ModeViewSettingsMode:render(data, scene)
    scene.vsPCBtn:draw()
    scene.vsPlayerBtn:draw()
    scene.header:draw()
end

return ModeViewSettingsMode