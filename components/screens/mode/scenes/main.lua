local Background = require 'components/screens/mode/scenes/main/view_background'
local MainView   = require 'components/screens/mode/scenes/main/view_main'
local Scene      = require 'components/screens/scenes/scene'

SceneMain = Scene:extend()

function SceneMain:new(config)
    config.name = 'main'
    
    SceneMain.super.new(self, config)

    self.views = {
        MainView()
    }
end

function SceneMain:initState(screen)
    screen:addViewLayers(
        { Background( {image = 'board_background'} ) },
        'scene_before'
    )

    self.header = game:create('text', { body = 'Choose mode'})

    self.campaignBtn = game:create('button_default', { 
        text = 'Campaign', 
        mousePressed = function() 
            game:changeStateTo('campaign_auth') 
        end
    })
    self.arenaBtn = game:create('button_default', { 
        text = 'Arena', 
        mousePressed = function() 
            game:changeStateTo('arena_auth') 
        end
    })
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