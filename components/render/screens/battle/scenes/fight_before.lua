require "components/render/screens/battle/scenes/fight_before/view_background"
require "components/render/screens/battle/scenes/fight_before/view_settings_mode"

SceneFightBefore = Scene:extend()

function SceneFightBefore:new(config)
    SceneFightBefore.super.new(self, config)

    self.name = 'fight_before'
    self.views = {
        BattleFightBeforeViewSettingsMode()
    }
end

function SceneFightBefore:init(screen)
    screen:addViewLayers(
        { BattleFightBeforeViewBackground( {image = 'board_background'} ) },
        'scene_before'
    )

    game.assets:getButton('pl1'):setToCenter(true)
    game.assets:getButton('pl1'):stepByY(20)

    game.assets:getButton('pl2'):setToCenter(true)
    game.assets:getButton('pl2'):stepByY(20)
    game.assets:getButton('pl2'):stepByY(20)
end

function SceneFightBefore:mouseMoved(screen, x, y, dx, dy, isTouch)

    local pl1 = game.assets:getButton('pl1')
    local pl2 = game.assets:getButton('pl2')

    if pl1:isMouseOn(x, y) then
        pl1:hover()
    elseif pl2:isMouseOn(x, y) then
        pl2:hover()
    else
        pl1:released()
        pl2:released()
    end
end

function SceneFightBefore:mousePressed(screen, x, y, button, isTouch, presses)

    local pl1 = game.assets:getButton('pl1')
    local pl2 = game.assets:getButton('pl2')

    if pl1:isMouseOn(x, y) then
        pl1:click()
    elseif pl2:isMouseOn(x, y) then
        pl2:click()
    else
        pl1:released()
        pl2:released()
    end
end