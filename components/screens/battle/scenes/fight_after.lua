local BattleFightAfterViewTheEnd     = require "components/screens/battle/scenes/fight_after/view_the_end"
local BattleFightAfterViewStatistics = require "components/screens/battle/scenes/fight_after/view_statistics"

SceneFightAfter = Scene:extend()

function SceneFightAfter:new(config)
    SceneFightAfter.super.new(self, config)

    self.views = {
        BattleFightAfterViewTheEnd(),
        BattleFightAfterViewStatistics()
    }
end

return SceneFightAfter