local ViewBoard   = require "components/screens/battle/scenes/main/view_board"
local ViewPlayers = require "components/screens/battle/scenes/main/view_players"
local Scene       = require "components/screens/scenes/scene"
local Board       = require "components/sources/board"
local Background  = require 'components/screens/mode/scenes/main/view_background'

local LayerViewSingleSelection = require "components/screens/layers/layer_view_single_selection"
local LayerViewTip             = require "components/screens/layers/layer_view_tip"

SceneMain = Scene:extend()

function SceneMain:new(config)
    config.name = 'main'
    self.fx     = ''
    self.ready  = false
    self.turn   = game.assets:getImage('turn')
    self.p1health = {}
    self.p2health = {}

    SceneMain.super.new(self, config)

    self.views = {
        ViewBoard(),
        ViewPlayers(),
    }
end

function SceneMain:initState(screen)
    self:addSceneViews(screen)
    game.cursor:reset()
    screen.board = Board(screen.board)

    
   -- self:updateUI(screen)
end

function SceneMain:updateUI(screen)
    self:put(screen.board, 5,8, 10,10)
    self:put(screen.playersCards[1], 5,3, 4,2)
    self:put(screen.playersCards[2], 5,20, 4,2)

    local row = 8
    for i, card in pairs(screen.playersTeamsCards[1]) do
        self:put(card, row,3, 4,2)
        row = row + 3
    end

    local row = 8
    for i, card in pairs(screen.playersTeamsCards[2]) do
        self:put(card, row,20, 4,2)
        row = row + 3
    end

    screen.players[1] = self:updateUIMagic(screen.players[1], 3, 3)
    screen.players[2] = self:updateUIMagic(screen.players[2], 17, 14)

    if screen.current == 1 then
        self:put(self.turn, 17,6, 1,1)
    else
        self:put(self.turn, 3,20, 1,1)
    end
end

function SceneMain:updateUIMagic(player, startRow, startColumn)
    local magic = game.assets:getMisc('magic')
    local order = magic.namesOrder
    for _,name in pairs(order) do
        local pm = player.magic[name]
        self:put(pm.image, startRow,startColumn, 1,1)
        startColumn = startColumn+1
        player.magic[name] = pm
    end

    return player
end

function SceneMain:addSceneViews(screen)
    screen:addViewLayers(
        { Background( {image = 'board_background'} ) },
        'scene_before'
    )
    screen:addViewLayers(
        {
            LayerViewSingleSelection(),
            LayerViewTip()
        },
        'scene_after'
    )
end

function SceneMain:mouseMoved2(screen, x, y, dx, dy, isTouch)
    for i=1,2 do
        pl = screen.playersCards[i]
        for _,magicGem in pairs(pl.gems) do
            if magicGem:isMouseOn(x,y) then
                magicGem.isHovered = true
            else
                magicGem.isHovered = false
            end
        end
        for _, card in pairs(screen.playersTeamsCards[i]) do
            if card:isMouseOn(x, y) and card.skill.active.cost then
                local icons = {}
                local top, _, size = card:getEdgesFrame(3)
                local iconCounter = 0
                for magicName, amount in pairs(card.skill.active.cost) do
                    local magic = game.assets:getMisc('magic'):getByName(magicName)
                    table.insert(
                            icons,
                            {
                                image=game.assets:getImagePack('gems'):get(magic:getType()),
                                text=amount,
                                xd=120*card.sx + iconCounter*60*card.sx,
                                yd=220*card.sy
                            }
                    )
                    iconCounter = iconCounter+1
                end

                local canUse = ''
                local selectionColor = {0.5, 0.5, 0.5}

                if screen:isCurrentPlayer(pl) then
                    if not pl:isEnoughMagic(card) then
                        canUse = 'Not enough magic'
                        selectionColor = {1, 0, 0}
                    else
                        selectionColor = {0, 0.5, 0}
                    end
                else
                    canUse = 'Restricted to use now'
                    selectionColor = {0.5, 0.5, 0.5}
                end

  
                return
            else
                
            end
        end
    end
end

function SceneMain:mousePressed(screen, x, y, button, isTouch, presses)
    local currentPlayer = screen:getCurrentPlayer()

    for _, card in pairs(currentPlayer.cards) do
        if card:isMouseOn(x,y) and card.skill.active.cost then
            if currentPlayer:isEnoughMagic(card) then
                screen.statistics[screen.current].spells = screen.statistics[screen.current].spells + 1
                currentPlayer:useCard(screen, card)
            else
                game.assets:getFx('skill_not'):play()
            end
        end
    end
end

function SceneMain:keyPressed(screen, key)
    local gr = {down = true, up=true, left=true, right=true}

    if gr[key] then
        game.assets:getFx('move'):play()
        screen.board.gravity = key
    end
end

function SceneMain:update(screen)
    local current    = screen:getCurrentPlayer()
    local nextPlayer = screen:getNextPlayer()

    local left = screen.players[1].health - screen.playersCards[1].health
    local perc = left/screen.players[1].health

    self.p1health = game.resources:create('rectangle', {
        height = screen.playersCards[1].height * perc,
        width = screen.playersCards[1].width,
        color = {1, 0, 0, 0.6},
        x = screen.playersCards[1].x,
        y = screen.playersCards[1].y,
        sx = screen.playersCards[1].sx,
        sy = screen.playersCards[1].sy,
        mode = 'fill'
    })

    left = screen.players[2].health - screen.playersCards[2].health
    perc = left/screen.players[2].health

    self.p2health = game.resources:create('rectangle', {
        height = screen.playersCards[2].height * perc,
        width = screen.playersCards[2].width,
        color = {1, 0, 0, 0.6},
        x = screen.playersCards[2].x,
        y = screen.playersCards[2].y,
        sx = screen.playersCards[2].sx,
        sy = screen.playersCards[2].sy,
        mode = 'fill'
    })

    self:updateUI(screen)

    self.fx = screen.board:move(screen)

    

    if nextPlayer:isDead() or current:isDead() then
        self.fx = 'the_end'
        screen.statistics[current.number].win = not current:isDead()
        screen.statistics[nextPlayer.number].win = not nextPlayer:isDead()
        screen:setViewLayers({}, 'scene_after')
        screen:changeStateTo('fight_after', {})
    end

    if self.fx ~= '' then
        game.assets:getFx(self.fx):play()
    end

    self:addStone(screen)

    if self.fx ~= '' then
        game.assets:getFx(self.fx):play()
    end
end

function SceneMain:addStone(screen)
    self.fx = screen.board:addStone(screen) or ''
end

return SceneMain