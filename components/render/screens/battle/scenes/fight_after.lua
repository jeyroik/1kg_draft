require "components/render/screens/battle/scenes/fight_after/view_the_end"

SceneFightAfter = Scene:extend()

function SceneFightAfter:new(config)
    SceneFightAfter.super.new(self, config)

    self.views = {
        BattleFightAfterViewTheEnd()
    }
end