local CampaignAuthSceneMainView = require "components/screens/campaign_auth/scenes/main/view"

CampaignAuthSceneMain = Scene:extend()

function CampaignAuthSceneMain:new(config)
    CampaignAuthSceneMain.super.new(self, config)

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

function CampaignAuthSceneMain:init()
    self.inputField = game.assets:getImage('inputField')
    self.submit     = game.assets:getButton('submit')
    self.playerName = Text({ body = '' })
    self.header     = Text({ body = 'Enter your name' })

    self.back = Image({ path = 'board_stone.png'})
    self.back.x = 0
    self.back.y = 0
    self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
    self:updateUI()
end

function CampaignAuthSceneMain:textInput(screen, text)
    if #self.playerName.body < 11 then
        self.playerName:append(text)
    end
end

function CampaignAuthSceneMain:mouseMoved(screen, x, y)
    if self.submit:isMouseOn(x, y) then
        self.submit:hover()
    elseif self.submit.state ~= 'default' then
        self.submit:released()
    end
end

function CampaignAuthSceneMain:mousePressed(screen, x, y)
    if self.submit:isMouseOn(x, y) then
        local playerName = self.playerName.body
        local player = {}

        if game.profiles[playerName] then
            player = ModelPlayer(game.profiles[playerName])
        else
            player = ModelPlayer({
                name = playerName,
                title = playerName,
                description = playerName
            })
        end

        game.profile = player

        game:changeStateTo('campaign_map')
    end
end

function CampaignAuthSceneMain:keyPressed(screen, key)
    if key == 'backspace' then
        self.playerName:pop(1)
    end
end

function CampaignAuthSceneMain:update(screen, dt)
    if self.textCursorTimer >= 0.3 then
        self.textCursorTimer = 0
        self.textCursor = (#self.playerName.body < 11) and not self.textCursor or false
    else
        self.textCursorTimer = self.textCursorTimer + dt
    end

    self:updateUI()
end

function CampaignAuthSceneMain.fullscreenChanged(this, screen, mode)
    
    this.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
end

function CampaignAuthSceneMain:updateUI()
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

return CampaignAuthSceneMain