local ModeViewBackground   = require "components/screens/mode/scenes/main/view_background"
local ModeViewSettingsMode = require "components/screens/mode/scenes/main/view_settings_mode"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'fight_before'
    self.views = {
        ModeViewSettingsMode()
    }

    self.vsPCBtn     = game.assets:getButton('pl1')
    self.vsPlayerBtn = game.assets:getButton('pl2')
    self.header      = Text({ body = 'Choose mode' })
end

function SceneMain:init(screen)
    screen:addViewLayers(
        { ModeViewBackground( {image = 'board_background'} ) },
        'scene_before'
    )
    self:updateUI()
end

function SceneMain:mouseMoved(screen, x, y, dx, dy, isTouch)

    if self.vsPCBtn:isMouseOn(x, y) then
        self.vsPCBtn:hover()
    elseif self.vsPCBtn.state ~= 'default' then
        self.vsPCBtn:released()
    end

    if self.vsPlayerBtn:isMouseOn(x, y) then
        self.vsPlayerBtn:hover()
    elseif self.vsPlayerBtn.state ~= 'default' then
        self.vsPlayerBtn:released()
    end
end

function SceneMain:mousePressed(screen, x, y, button, isTouch, presses)

    local data = screen:getData()
    local modeIsChosen = false

    if self.vsPCBtn:isMouseOn(x, y) then
        self.vsPCBtn:click()
        game:changeStateTo('campaign_auth')
    elseif self.vsPlayerBtn:isMouseOn(x, y) then
        self.vsPlayerBtn:click()
        game:changeStateTo('arena_auth')
    end
end

function SceneMain:update(screen)
    self:updateUI()
end

function SceneMain:updateUI()
    game.graphics:put(self.vsPCBtn, 9, 11, 6, 2)
    game.graphics:put(self.vsPlayerBtn, 12, 11, 6, 2)
    game.graphics:put(self.header, 6, 10, 8, 2)
end

return SceneMain