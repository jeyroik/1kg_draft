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

function SceneMain:initState(screen, ...)
    self.header = Text({ body = screen.location })
    self.playerTeam = Text({ body = game.profile.title })

    self.enemyTeam = Text({ body = screen.enemy.title })
    self.enemyCard = Card(screen.enemy)

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
        name = 'battle',
        path = {
            default = 'menu_btn.png',
            clicked = 'menu_btn_pressed.png'
        },
        text = 'Start battle',
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

    for _, char in pairs(screen.enemy.characters) do
        table.insert(
            self.enemyCharacters,
            Card(char)
        )
    end

    self:updateUI()
end

function SceneMain:buttonPressed(screen, name)
    if name == 'battle' then
        self:battleButtonPressed(screen)
    elseif name == 'change' then
        self:changeButtonPressed(screen)
    elseif name == 'exit' then
        self:exitButtonPressed()
    elseif name == 'fullscreen' then
        self:fullscreenButtonPressed()
    end
end

function SceneMain:battleButtonPressed(screen)
    -- Start battle
    game:changeStateTo('battle', {
        players = {
            game.profile,
            screen.enemy,
        },
        nextScreen = 'campaign_map'
    })
end

function SceneMain:changeButtonPressed(screen)
    screen:changeStateTo('team')
end

function SceneMain:exitButtonPressed()
    game:changeStateTo('campaign_map')
end

function SceneMain:fullscreenButtonPressed()
    self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
    self:updateUI()
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