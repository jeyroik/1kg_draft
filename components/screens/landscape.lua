local LandscapeLayerData = require "components/screens/landscape/data"
local Screen = require "components/screens/screen"

LandscapeScreen = Screen:extend()

function LandscapeScreen:new(config)
    config.initializer = config.initializer or 'components/screens/landscape/initializer'

    LandscapeScreen.super.new(self, config)

    self:setDataLayer(LandscapeLayerData(config))
end

function LandscapeScreen:getProfile()
    return self.layers.data:getProfile()
end

return LandscapeScreen