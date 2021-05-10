local MainView = require "components/screens/campaign_before_battle/scenes/main/view"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        MainView()
    }
    
    self.back = {}
    self.header = {}
    self.playerTeam = {}
    self.playerCard = Card(game.profile)
    self.playerCharacters = {}

    self.enemyTeam = {}
    self.enemyCard = {}
    self.enemyCharacters = {}

    self.changeBtn = {}
    self.submitBtn = {}
    self.cancelBtn = {}
end

function SceneMain:init(screen, ...)
    if not self.initialized then
        self.header = Text({ body = screen:getData().location })
        self.playerTeam = Text({ body = game.profile.title })

        self.enemyTeam = Text({ body = screen:getData().enemy.title })
        self.enemyCard = Card(screen:getData().enemy)

        self.changeBtn = Button({
            name = 'change',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Change team',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            parent = screen,
            screenName = 'campaign_before_battle',
            sceneName = 'main',
            color = {0, 0.5, 0}
        })
        self.submitBtn = Button({
            name = 'fight',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Start fight',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            parent = screen,
            screenName = 'campaign_before_battle',
            sceneName = 'main',
            color = {0, 0.5, 0}
        })
        self.cancelBtn = Button({
            name = 'exit',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'Exit fight',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            parent = screen,
            screenName = 'campaign_before_battle',
            sceneName = 'main',
            color = {0, 0.5, 0}
        })

        self.back = Image({ path = 'board_stone.png'})
        self.back.x = 0
        self.back.y = 0
        self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))

        local team = game.profile:getCurrentTeam()
        for _, char in pairs(team) do
            table.insert(
                self.playerCharacters,
                Card(char)
            )
        end

        for _, char in pairs(screen:getData().enemy.characters) do
            table.insert(
                self.enemyCharacters,
                Card(char)
            )
        end

        self:updateUI()
        self.initialized = true
    end
end

function SceneMain.changeButtonPressed()
    game:getCurrentState():changeStateTo('team')
end

function SceneMain.exitButtonPressed()
    game:changeStateTo('campaign_map')
end

function SceneMain.fullscreenChanged(this)
    this.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
end

function SceneMain:update()
    --self:updateUI()
end

function SceneMain:updateUI()
    game.graphics:put(self.header, 2,8, 10,1)

    game.graphics:put(self.playerTeam, 5,3, 6,1)
    game.graphics:put(self.playerCard, 7,3, 5,2)

    for i, playerChar in pairs(self.playerCharacters) do
        game.graphics:put(playerChar, 7+i*3,3, 5,2)
    end

    game.graphics:put(self.enemyTeam, 5,18, 6,1)
    game.graphics:put(self.enemyCard, 7,19, 5,2)

    for i, enemyChar in pairs(self.enemyCharacters) do
        game.graphics:put(enemyChar, 7+i*3,19, 5,2)
    end

    game.graphics:put(self.changeBtn, 10,11, 5,2)
    game.graphics:put(self.submitBtn, 13,11, 5,2)
    game.graphics:put(self.cancelBtn, 16,11, 5,2)
end

return SceneMain