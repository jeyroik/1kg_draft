require "components/render/screens/battle/scenes/fight_the_end/view_the_end"

SceneFightTheEnd = Scene:extend()

function SceneFightTheEnd:new(config)
    SceneFight.super.new(self, config)

    self.views = {
        BattleFightTheEndViewTheEnd()
    }
end