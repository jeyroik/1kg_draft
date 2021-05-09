local MainView = require 'components/screens/campaign_before_battle/scenes/team/view'
local Scene = require 'components/screens/scenes/scene'

SceneTeam = Scene:extend()

function SceneTeam:new(config)
    SceneTeam.super.new(self, config)

    self.name = 'team'
    self.views = {
        MainView()
    }
    
    self.back = {}
    self.header = {}
    self.header = Text({ body = 'Change team' })
    self.playerTeam = {}
    self.playerCard = Card(game.profile)
    self.playerCharacters = {}

    self.submitBtn = {}
    self.cancelBtn = {}
end

function SceneTeam:init(screen)
    if not self.initialized then
        self.back = Image({ path = 'board_stone.png'})
        self.back.x = 0
        self.back.y = 0
        self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))


        self.playerTeam = Text({ body = game.profile.title })
        for _, char in pairs(game.profile.characters) do
            table.insert(
                self.playerCharacters,
                Card(char)
            )
        end

        self.submitBtn = Button({
            name = 'ready',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Submit',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            parent = screen,
            screenName = 'campaign_before_battle',
            sceneName = 'team',
            color = {0, 0.5, 0}
        })
        self.cancelBtn = Button({
            name = 'cancel',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Cancel',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            parent = screen,
            screenName = 'campaign_before_battle',
            sceneName = 'team',
            color = {0, 0.5, 0}
        })

        self.initialized = true
        self:updateUI()
    end
end

function SceneTeam.readyButtonPressed()
    game:getCurrentState():changeStateTo('main')
end

function SceneTeam.cancelButtonPressed()
    game:getCurrentState():changeStateTo('main')
end

function SceneTeam.fullscreenChanged(this)
    this.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
end

function SceneTeam:updateUI()
    game.graphics:put(self.header, 2,8, 10,1)

    game.graphics:put(self.playerTeam, 5,3, 6,1)
    game.graphics:put(self.playerCard, 7,3, 5,2)

    for i, playerChar in pairs(self.playerCharacters) do
        game.graphics:put(playerChar, 7+i*3,3, 5,2)
    end

    game.graphics:put(self.submitBtn, 13,11, 5,2)
    game.graphics:put(self.cancelBtn, 16,11, 5,2)
end

return SceneTeam