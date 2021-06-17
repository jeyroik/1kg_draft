local Background = require 'components/screens/mode/scenes/main/view_background'
local MainView   = require 'components/screens/mode/scenes/main/view_main'
local Scene      = require 'components/screens/scenes/scene'

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        MainView()
    }
    
    self.header = Text({ body = 'Choose mode' })
end

function SceneMain:initState(screen)
    screen:addViewLayers(
        { Background( {image = 'board_background'} ) },
        'scene_before'
    )

    self.campaignBtn = game.resources:create('button_default', { text = 'Campaign' })
    self.arenaBtn    = game.resources:create('button_default', { text = 'Arena' })

    -- 1 - сколько раз реагировать на это событие
    game.events:on(
        self.campaignBtn:getEventName('buttonPressed'), 
        function () 
            game:changeStateTo('campaign_auth') 
        end, 
        1
    )
    game.events:on(
        self.arenaBtn:getEventName('buttonPressed'),
        function ()
            game:changeStateTo('arena_auth')
        end,
        1
    )
end

function SceneMain:onActive(...)
    self:updateUI()
end

function SceneMain:update()
    self:updateUI()
end

function SceneMain:updateUI()
    local pos = game.graphics:getItem(9,11)

    if pos.x ~= self.campaignBtn.x then
        game.graphics:put(self.campaignBtn, 9, 11, 6, 2)
        game.graphics:put(self.arenaBtn, 12, 11, 6, 2)
        game.graphics:put(self.header, 6, 10, 8, 2)
    end
end

return SceneMain