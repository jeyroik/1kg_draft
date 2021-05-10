local ViewBoard   = require "components/screens/battle/scenes/main/view_board"
local ViewPlayers = require "components/screens/battle/scenes/main/view_players"

SceneMain = Scene:extend()

function SceneMain:new(config)
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

    local layerData = screen:getData()
    layerData.board = Board(layerData.board)
    layerData.board:setToCenter(true, true)
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
    local layerData = screen:getData()

    for i=1,2 do
        pl = layerData.players[i]
        for _,magicGem in pairs(pl.gems) do
            if magicGem:isMouseOn(x,y) then
                magicGem.isHovered = true
            else
                magicGem.isHovered = false
            end
        end
        for _, card in pairs(pl.cards) do
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

                if layerData:isCurrentPlayer(pl) then
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

                layerData.tip = {
                    x = x,
                    y = y,
                    sx = card.sx,
                    sy = card.sy,
                    text = canUse .. '\n'..'Title: '..card.name .. '\n\nDescription:\n'..card.skill.active.description..'\n\nCost: ',
                    icons = icons
                }
                layerData.selection = {
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
                layerData.tip = {}
                layerData.selection = {}
                game.assets:getCursor('hand'):reset()
            end
        end
    end
end

function SceneMain:mousePressed(screen, x, y, button, isTouch, presses)
    local layerData = screen:getData()
    local currentPlayer = layerData:getCurrentPlayer()

    for _, card in pairs(currentPlayer.cards) do
        if card:isMouseOn(x,y) and card.skill.active.cost then
            if currentPlayer:isEnoughMagic(card) then
                layerData.statistics[layerData.current].spells = layerData.statistics[layerData.current].spells + 1
                currentPlayer:useCard(layerData, card)
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
        screen:getData().board.gravity = key
    end
end

function SceneMain:update(screen)
    local layerData = screen:getData()
    --layerData.board:update()

    for _, player in pairs(layerData.players) do
        player:update()
    end
    self.fx = layerData.board:move(layerData)

    local current = layerData:getCurrentPlayer()
    local nextPlayer = layerData:getNextPlayer()

    if nextPlayer:isDead() or current:isDead() then
        self.fx = 'the_end'
        layerData.statistics[current.number].win = not current:isDead()
        layerData.statistics[nextPlayer.number].win = not nextPlayer:isDead()
        screen:setViewLayers({}, 'scene_after')
        screen:changeSceneTo('fight_the_end')
    end

    if self.fx ~= '' then
        game.assets:getFx(self.fx):play()
    end

    self:addStone(layerData)

    if self.fx ~= '' then
        game.assets:getFx(self.fx):play()
    end
end

function SceneMain:addStone(layerData)
    self.fx = layerData.board:addStone(layerData) or ''
end

return SceneMain