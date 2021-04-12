require "components/render/screens/battle/scenes/fight_before/view_background"

SceneFightBefore = Scene:extend()

function SceneFightBefore:new(config)
    self.fx = ''

    SceneFightBefore.super.new(self, config)

    self.views = {

    }
end

function SceneFightBefore:init(game, screen)
    screen:addViewLayers(
        { BattleFightBeforeViewBackground( {image = 'board_background'} ) },
        'scene_before'
    )
end