local LayerView = require "components/screens/layers/layer_view"

Background = LayerView:extend()

function Background:new(config)
    self.image = ''
    Background.super.new(self, config)
end

function Background:render()
    local background = game.assets:getImage(self.image)

    background:render()
end

return Background