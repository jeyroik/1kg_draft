local LayerView = require "components/screens/layers/layer_view"

BattleFightBeforeViewSettingsMode = LayerView:extend()

function BattleFightBeforeViewSettingsMode:new(config)
    BattleFightBeforeViewSettingsMode.super.new(self, config)
end

function BattleFightBeforeViewSettingsMode:render(data, scene)
    
    scene.grid:render()
    game.assets:getText('before_fight_header'):render()
end