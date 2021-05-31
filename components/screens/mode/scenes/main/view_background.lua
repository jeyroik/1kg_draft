local LayerView = require "components/screens/layers/layer_view"

Background = LayerView:extend()

function Background:new(config)
    self.image = ''
    Background.super.new(self, config)
end

function Background:draw()
    local background = game.assets:getImage(self.image)

    background:draw()
end

return Background