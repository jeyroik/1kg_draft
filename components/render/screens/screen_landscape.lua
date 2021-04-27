require "components/render/screens/landscape/data"

LandscapeScreen = Screen:extend()

function LandscapeScreen:new(config)
    config.initializer = config.initializer or 'components/render/screens/landscape/initializer'

    LandscapeScreen.super.new(self, config)

    self:setDataLayer(LandscapeLayerData(config))
end

function LandscapeScreen:getProfile()
    return self.layers.data:getProfile()
end

return LandscapeScreen