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
    self.enemyTeam = {}
    self.submit = {}
    self.cancel = {}
    
end

function SceneMain:init(screen, ...)
    self.header = Text({ body = screen:getData().location })
    self.playerTeam = Text({ body = game.profile.title })
    self.enemyTeam = Text({ body = 'Enemy team' })
    self.back = Image({ path = 'board_stone.png'})
    self.back.x = 0
    self.back.y = 0
    self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
    self:updateUI()
end

function SceneMain:update()
    self:updateUI()
end

function SceneMain.fullscreenChanged(this)
    this.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
end

function SceneMain:updateUI()
    game.graphics:put(self.header, 2,8, 10,1)
    game.graphics:put(self.playerTeam, 5,3, 6,1)
    game.graphics:put(self.enemyTeam, 5,18, 6,1)
end

return SceneMain