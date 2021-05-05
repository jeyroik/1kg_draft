local LayerView = require "components/screens/layers/layer_view"

ModeViewBackground = LayerView:extend()

function ModeViewBackground:new(config)
    self.image = ''
    ModeViewBackground.super.new(self, config)
end

function ModeViewBackground:render()
    local background = game.assets:getImage(self.image)

    background:render()
end

return ModeViewBackground