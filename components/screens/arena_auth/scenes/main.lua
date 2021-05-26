local MainView = require "components/screens/arena_auth/scenes/main/view"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        MainView()
    }
end

return SceneMain