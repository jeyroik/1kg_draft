require "components/render/screens/battle/scenes/fight_after/view_the_end"
require "components/render/screens/battle/scenes/fight_after/view_statistics"

SceneFightAfter = Scene:extend()

function SceneFightAfter:new(config)
    SceneFightAfter.super.new(self, config)

    self.views = {
        BattleFightAfterViewTheEnd(),
        BattleFightAfterViewStatistics()
    }
end