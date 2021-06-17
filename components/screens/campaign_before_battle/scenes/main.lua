local MainView = require "components/screens/campaign_before_battle/scenes/main/view"

SceneMain = Scene:extend()

function SceneMain:new(config)
    config.name = 'main'
    SceneMain.super.new(self, config)

    self.views = {
        MainView()
    }
    
    self.back = {}
    self.header = {}

    self.playerTeam = {}
    self.playerCharacters = {}

    self.enemyTeam = {}
    self.enemyCard = {}
    self.enemyCharacters = {}

    self.changeBtn = {}
    self.submitBtn = {}
    self.cancelBtn = {}
end

function SceneMain:initState(screen, ...)
    local cardHook = require 'components/screens/campaign_before_battle/hooks/main/card'

    game.events:on(
        screen.name..'.'..self.name..'.cardMouseOn', 
        cardHook({alias = 'cbb_main'})
    )
    game.events:on(
        screen.name..'.'..self.name..'.cardPressed', 
        cardHook({alias = 'cbb_main'})
    )

    self.playerCard = game.resources:create('card', game.profile)
    self.header     = game.resources:create('text', { body = screen.location })
    self.playerTeam = game.resources:create('text', { body = game.profile.title })

    self.enemyTeam = game.resources:create('text', { body = screen.enemy.title })
    local enemy = screen.enemy
    enemy.screenName = screen.alias
    enemy.sceneName  = 'main'
    self.enemyCard = game.resources:create('card', enemy)

    self.changeBtn = game.resources:create('button_default', {text = 'Change team'})
    self.submitBtn = game.resources:create('button_default', {text = 'Start battle',})
    self.cancelBtn = game.resources:create('button_default', {text = 'Exit fight'})

    self.back = game.resources:create('image', { path = 'board_stone.png'})
    self.back.x = 0
    self.back.y = 0
    self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))

    local team = game.profile:getCurrentTeam()
    for _, char in pairs(team) do
        char.screenName = screen.alias
        char.sceneName  = 'main'
        table.insert(
            self.playerCharacters,
            Card(char)
        )
    end

    for _, char in pairs(screen.enemy.characters) do
        char.screenName = screen.alias
        char.sceneName  = 'main'
        table.insert(
            self.enemyCharacters,
            Card(char)
        )
    end

    game.events:on(
        self.changeBtn:getEventName('buttonPressed'), 
        function () 
            screen:changeStateTo('team')
        end, 
        1
    )

    game.events:on(
        self.submitBtn:getEventName('buttonPressed'), 
        function () 
            game:changeStateTo('battle', {
                players = {
                    game.profile,
                    screen.enemy,
                },
                nextScreen = 'campaign_map'
            })
        end, 
        1
    )

    game.events:on(
        self.cancelBtn:getEventName('buttonPressed'), 
        function () 
            game:changeStateTo('campaign_map')
        end, 
        1
    )
end

function SceneMain:onActive(...)
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