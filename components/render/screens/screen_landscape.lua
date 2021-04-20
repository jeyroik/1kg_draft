require "components/render/screens/landscape/data"
require "components/render/screens/landscape/scenes/main"

LandscapeScreen = Screen:extend()

function LandscapeScreen:new(config)
    LandscapeScreen.super.new(self, config)

    self.scene = 'main'
    self.scenes = {
        main = SceneMain()
    }

    self:setDataLayer(LandscapeLayerData(config))
end

function LandscapeScreen:getProfile()
    return self.layers.data:getProfile()
end