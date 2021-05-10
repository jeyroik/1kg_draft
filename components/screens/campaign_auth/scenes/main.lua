local CampaignAuthSceneMainView = require "components/screens/campaign_auth/scenes/main/view"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        CampaignAuthSceneMainView()
    }
    self.label = {}
    self.selected = ''

    self.back = {}
    self.header = {}
    self.playerName = {}
    self.inputCursor = {}
    self.inputField = {}
    self.submit = {}
    
    self.textCursor = true
    self.textCursorTimer = 0
end

function SceneMain:init(screen)
    if not self.initialized then
        self.inputField = game.assets:getImage('inputField')
        self.submit     = Button({
            name = 'submit',
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'submit',
            text_scale = 0.4,
            border = 15,
            effect = {
                path = 'components/sources/buttons/effects/frame'
            },
            color = {0, 0.5, 0},
            parent = screen,
            screenName = 'campaign_auth',
            sceneName = 'main'
        })
        self.playerName = Text({ body = 'Unknown' })
        self.header     = Text({ body = 'Enter your name' })

        self.back = Image({ path = 'board_stone.png'})
        self.back.x = 0
        self.back.y = 0
        self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
        self:updateUI()
        self.initialized = true
    end
end

function SceneMain:textInput(screen, text)
    if #self.playerName.body < 11 then
        self.playerName:append(text)
    end
end

function SceneMain.submitButtonPressed(this)
    local playerName = this.playerName.body

    if game.profiles[playerName] then
        game.profile = ModelPlayer(game.profiles[playerName])
    else
        game.profile = ModelPlayer({
            name = playerName,
            title = playerName,
            description = playerName
        })
        for i=1,15 do
            table.insert(game.profile.characters, game.assets:getCharacter('fire_elemental'))
        end
    end

    game:changeStateTo('campaign_map')
end

function SceneMain:keyPressed(screen, key)
    if key == 'backspace' then
        self.playerName:pop(1)
    elseif key == 'return' then
        self.submitButtonPressed(self)
    end
end

function SceneMain:update(screen, dt)
    if self.textCursorTimer >= 0.3 then
        self.textCursorTimer = 0
        self.textCursor = (#self.playerName.body < 11) and not self.textCursor or false
    else
        self.textCursorTimer = self.textCursorTimer + dt
    end

    self:updateUI()
end

function SceneMain.fullscreenChanged(this, screen, mode)
    this.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
end

function SceneMain:updateUI()
    local pos = game.graphics:getItem(6, 10)

    self.inputField.x = pos.x
    self.inputField.y = pos.y
    game.graphics:setScale(self.inputField, 7, 2)

    self.playerName.sx = ((pos.width/2) * #self.playerName.body) / self.playerName.width
    self.playerName.sy = (pos.height/2) / self.playerName.height
    self.playerName:setToCenterOfObject(self.inputField, true, true)
    self.playerName.x = math.floor(self.playerName.x)
    self.playerName.y = math.floor(self.playerName.y)

    pos = game.graphics:getItem(4,10)
    self.header.x = pos.x
    self.header.y = pos.y
    game.graphics:setScale(self.header, 7, 1)


    pos = game.graphics:getItem(10,11)
    self.submit.x = pos.x
    self.submit.y = pos.y
    game.graphics:setScale(self.submit, 5, 2)
    self.submit:reload()

    self.inputCursor = Text({ 
        body = '|', 
        x    = self.playerName.x + self.playerName.width*self.playerName.sx, 
        y    = self.playerName.y, 
        sx   = self.playerName.sx, 
        sy   = self.playerName.sy 
    })
    
end

return SceneMain