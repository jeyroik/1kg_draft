local ModeViewBackground   = require "components/screens/mode/scenes/main/view_background"
local ModeViewSettingsMode = require "components/screens/mode/scenes/main/view_settings_mode"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'fight_before'
    self.views = {
        ModeViewSettingsMode()
    }
    
    self.header      = Text({ body = 'Choose mode' })
end

function SceneMain:init(screen)
    if not self.initialized then
        screen:addViewLayers(
            { ModeViewBackground( {image = 'board_background'} ) },
            'scene_before'
        )

        self.vsPCBtn = Button({
            name = 'campaign',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Campaign',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            parent = screen,
            screenName = 'mode',
            sceneName = 'main',
            color = {0, 0.5, 0}
        })
        self.vsPlayerBtn = Button({
            name = 'arena',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Arena',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            color = {0, 0.5, 0},
            parent = screen,
            screenName = 'mode',
            sceneName = 'main'
        })
        self:updateUI()
        self.initialized = true
    end
end

function SceneMain.campaignButtonPressed()
    game:changeStateTo('campaign_auth')
end

function SceneMain.arenaButtonPressed()
    game:changeStateTo('arena_auth')
end

function SceneMain:update()
    self:updateUI()
end

function SceneMain:updateUI()
    local pos = game.graphics:getItem(9,11)

    if pos.x ~= self.vsPCBtn.x then
        game.graphics:put(self.vsPCBtn, 9, 11, 6, 2)
        game.graphics:put(self.vsPlayerBtn, 12, 11, 6, 2)
        game.graphics:put(self.header, 6, 10, 8, 2)
    end
end

return SceneMain