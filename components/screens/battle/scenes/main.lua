local ViewBoard   = require "components/screens/battle/scenes/main/view_board"
local ViewPlayers = require "components/screens/battle/scenes/main/view_players"
local Scene       = require "components/screens/scenes/scene"
local Board       = require "components/sources/board"

local LayerViewSingleSelection = require "components/screens/layers/layer_view_single_selection"
local LayerViewTip             = require "components/screens/layers/layer_view_tip"

SceneMain = Scene:extend()

function SceneMain:new(config)
    config.name = 'main'
    self.fx = ''
    self.ready = false

    SceneMain.super.new(self, config)

    self.views = {
        ViewBoard(),
        ViewPlayers(),
    }
end

function SceneMain:initState(screen)
    self:addSceneAfterViews(screen)

    screen.board = Board(screen.board)

    self:updateUI(screen)
end

function SceneMain:updateUI(screen)
    self:put(screen.board, 5,9, 10,10)
    self:put(screen.playersCards[1], 5,2, 4,2)
    self:put(screen.playersCards[2], 5,21, 4,2)

    local row = 8
    for i, card in pairs(screen.playersTeamsCards[1]) do
        self:put(card, row,2, 4,2)
        row = row + 3
    end

    local row = 8
    for i, card in pairs(screen.playersTeamsCards[2]) do
        self:put(card, row,21, 4,2)
        row = row + 3
    end
end

function SceneMain:addSceneAfterViews(screen)
    screen:addViewLayers(
        {
            LayerViewSingleSelection(),
            LayerViewTip()
        },
        'scene_after'
    )
end

function SceneMain:mouseMoved(screen, x, y, dx, dy, isTouch)
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

                screen.tip = {
                    x = x,
                    y = y,
                    sx = card.sx,
                    sy = card.sy,
                    text = canUse .. '\n'..'Title: '..card.name .. '\n\nDescription:\n'..card.skill.active.description..'\n\nCost: ',
                    icons = icons
                }
                screen.selection = {
                    x = top.left.x,
                    y = top.left.y,
                    width = size.width*card.sx,
                    height = size.height*card.sy,
                    color = selectionColor,
                    line_width = 5
                }
                game.assets:getCursor('hand'):setOn()
                return
            else
                screen.tip = {}
                screen.selection = {}
                game.assets:getCursor('hand'):reset()
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
    for _, player in pairs(screen.playersCards) do
        --player:update() @deprecated
    end
    self.fx = screen.board:move(screen)

    local current    = screen:getCurrentPlayer()
    local nextPlayer = screen:getNextPlayer()

    if nextPlayer:isDead() or current:isDead() then
        self.fx = 'the_end'
        screen.statistics[current.number].win = not current:isDead()
        screen.statistics[nextPlayer.number].win = not nextPlayer:isDead()
        screen:setViewLayers({}, 'scene_after')
        screen:changeSceneTo('fight_the_end', {})
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