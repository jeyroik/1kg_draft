require "components/screens/player/scenes/main/view"

PlayerSceneMain = Scene:extend()

function PlayerSceneMain:new(config)
    PlayerSceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        PlayerSceneMainView()
    }
    self.label = {}
    self.selected = ''

    self.back = {}
    self.playerName = {}
    self.inputCursor = {}
    self.inputField = {}
    
    self.textCursor = false
    self.textCursorTimer = 0
end

function PlayerSceneMain:init()
    self.inputField = Image({path = 'notice.png'})
    self.playerName = Text({body = ''})

    self.back = Image({ path = 'board_stone.png'})
    self.back.x = 0
    self.back.y = 0
    self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
    self:updateUI()
end

function PlayerSceneMain:textInput(screen, text)
    if #self.playerName.body < 11 then
        self.playerName:append(text)
    end
end

function PlayerSceneMain:keyPressed(screen, key)
    if key == 'backspace' then
        self.playerName:pop(1)
    end
end

function PlayerSceneMain:update(screen, dt)
    if self.textCursorTimer >= 0.3 then
        self.textCursorTimer = 0
        self.textCursor = not self.textCursor
    else
        self.textCursorTimer = self.textCursorTimer + dt
    end

    self:updateUI()
end

function PlayerSceneMain.fullscreenChanged(this, screen, mode)
    
    this.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
end

function PlayerSceneMain:updateUI()
    local pos = game.graphics:getItem(6, 10)

    self.inputField.x = pos.x
    self.inputField.y = pos.y
    self.inputField.sx = (pos.width*7) / self.inputField.width
    self.inputField.sy = (pos.height*2) / self.inputField.height

    self.playerName.sx = ((pos.width/2) * #self.playerName.body) / self.playerName.width
    self.playerName.sy = (pos.height/2) / self.playerName.height
    self.playerName:setToCenterOfObject(self.inputField, true, true)
    self.playerName.x = math.floor(self.playerName.x)
    self.playerName.y = math.floor(self.playerName.y)

    self.inputCursor = Text({ 
        body = '|', 
        x    = self.playerName.x + self.playerName.width*self.playerName.sx, 
        y    = self.playerName.y, 
        sx   = self.playerName.sx, 
        sy   = self.playerName.sy 
    })
end

return PlayerSceneMain