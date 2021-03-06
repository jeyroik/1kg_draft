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
    self.playerName = {}
    self.playerCard = Card(game.profile)
    self.playerTeam = {}
    self.playerCharacters = {}
    self.scrollUp = {}
    self.scrollDown = {}

    self.submitBtn = {}
    self.cancelBtn = {}

    self.scrollPage = 1
    self.scroolPageMax = 1
end

function SceneTeam:initState(screen)
    self.back = Image({ path = 'board_stone.png'})
    self.back.x = 0
    self.back.y = 0
    self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))

    self.scrollUp   = Button({
        name = 'scrollUp',
        path = {
            default = 'scroll_up.png',
            clicked = 'scroll_up.png'
        },
        text = ' ',
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
    self.scrollDown = Button({
        name = 'scrollDown',
        path = {
            default = 'scroll_down.png',
            clicked = 'scroll_down.png'
        },
        text = ' ',
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

    self.playerName = Text({ body = game.profile.title })
    local team = game.profile:getCurrentTeam()
    for name, char in pairs(team) do
        self.playerTeam[name] = Card(char)
    end

    self.scrollPageMax = math.floor(#game.profile.characters/6)
    if math.fmod(#game.profile.characters,6) > 0 then
        self.scrollPageMax = self.scrollPageMax + 1
    end

    for name, char in pairs(game.profile.characters) do
        self.playerCharacters[name] = Card(char)
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
    self:updateUI()
end

function SceneTeam:buttonPressed(screen, name)
    if name == 'scrollUp' then
        self:scrollUpButtonPressed()
    elseif name == 'scrollDown' then
        self:scrollDownButtonPressed()
    elseif name == 'ready' then
        self:readyButtonPressed(screen)
    elseif name == 'cancel' then
        self:cancelButtonPressed(screen)
    elseif name == 'fullscreen' then
        self:fullscreenButtonPressed()
    end
end

function SceneTeam:scrollUpButtonPressed()
    self.scrollPage = self.scrollPage > 1 and self.scrollPage - 1 or 1
    self:updateUI()
end

function SceneTeam:scrollDownButtonPressed()
    self.scrollPage = self.scrollPage < self.scrollPageMax and self.scrollPage + 1 or self.scrollPageMax
    self:updateUI()
end

function SceneTeam:readyButtonPressed(screen)
    screen:changeStateTo('main', {
        playerTeam = self.playerTeam
    })
end

function SceneTeam:cancelButtonPressed(screen)
    screen:changeStateTo('main')
end

function SceneTeam:fullscreenButtonPressed()
    self.back:scaleTo(VisibleObject({width = love.graphics.getWidth(), height = love.graphics.getHeight()}))
end

function SceneTeam:mouseMoved(screen, x, y)
    for i, card in pairs(self.playerTeam) do
        if card:isMouseOn(x,y) then
            game.assets:getCursor('hand'):setOn()
            return
        end
    end

    for i, card in pairs(self.playerCharacters) do
        if card:isMouseOn(x,y) then
            game.assets:getCursor('hand'):setOn()
            return
        end
    end

    game.assets:getCursor('hand'):reset()
end

function SceneTeam:mousePressed(screen, x,y)
    for i, card in pairs(self.playerTeam) do
        if card:isMouseOn(x,y) then
            self.playerTeam[i] = nil
            return
        end
    end

    for i, card in pairs(self.playerCharacters) do
        if card:isMouseOn(x,y) then
            for i=1,3 do
                if not self.playerTeam[i] then
                    self.playerTeam[i] = Card(card)
                    self:updateUI()
                    return
                end
            end
            return
        end
    end
end

function SceneTeam:updateUI()
    game.graphics:put(self.header, 2,8, 10,1)

    game.graphics:put(self.playerName, 5,3, 6,1)
    game.graphics:put(self.playerCard, 7,3, 5,2)

    for i, playerChar in pairs(self.playerTeam) do
        game.graphics:put(playerChar, 7+i*3,3, 5,2)
    end

    local row = 0
    local column = 0
    local currentPage = 1

    for i, playerChar in pairs(self.playerCharacters) do
        if column == 3 then
            row = row + 1
            column = 0
        end

        if row > 1 then
            row = 0
            currentPage = currentPage + 1
        end

        if currentPage == self.scrollPage then
            game.graphics:put(playerChar, 5+row*5,11+column*4, 3,4)
        else
            game.graphics:put(playerChar, 50,50, 1,1)
        end

        column = column + 1
    end

    if self.scrollPageMax > 1 then
        game.graphics:put(self.scrollUp, 4,23, 1,1)
        game.graphics:put(self.scrollDown, 15,23, 1,1)
    else
        game.graphics:put(self.scrollUp, 50,50, 1,1)
        game.graphics:put(self.scrollDown, 50,50, 1,1)
    end

    game.graphics:put(self.submitBtn, 16,11, 5,2)
    game.graphics:put(self.cancelBtn, 16,17, 5,2)
end

return SceneTeam