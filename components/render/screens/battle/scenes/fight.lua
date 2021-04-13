require "components/render/screens/battle/scenes/fight/view_board"
require "components/render/screens/battle/scenes/fight/view_players"

SceneFight = Scene:extend()

function SceneFight:new(config)
    self.fx = ''

    SceneFight.super.new(self, config)

    self.views = {
        BattleFightViewBoard(),
        BattleFightViewPlayers(),
    }
end

function SceneFight:init(screen)
    self:addSceneAfterViews(screen)

    local layerData = screen:getData()
    layerData.board = Board(layerData.board)
    layerData.board:init()

    local cardDefault = game.assets:getQuads('chars')

    local current = layerData:getCurrentPlayer()
    current:addCard(CardFireElemental({width = cardDefault.width, height = cardDefault.height}))
    current:addCard(CardTreeElemental({width = cardDefault.width, height = cardDefault.height}))
    current:addCard(CardLifeElemental({width = cardDefault.width, height = cardDefault.height}))

    local next = layerData:getNextPlayer()
    next:addCard(CardFireElemental({width = cardDefault.width, height = cardDefault.height}))
end

function SceneFight:addSceneAfterViews(screen)
    screen:addViewLayers(
        {
            LayerViewSingleSelection(),
            LayerViewTip()
        },
        'scene_after'
    )
end

function SceneFight:mouseMoved(screen, x, y, dx, dy, isTouch)
    local layerData = screen:getData()

    for i=1,2 do
        pl = layerData.players[i]
        for _, card in pairs(pl.cards) do
            if card:isMouseOn(x, y) then
                local icons = {}
                local cost = card.skill.active:getCost(layerData)
                local top = card:getEdgesFrame(3)
                local iconCounter = 0
                for magicType, amount in pairs(cost) do
                    table.insert(
                            icons,
                            {
                                image=game.assets.images.gems[magicType],
                                text=amount,
                                xd=100 + iconCounter*60,
                                yd=200
                            }
                    )
                    iconCounter = iconCounter+1
                end

                local canUse = ''
                local selectionColor = {0.5, 0.5, 0.5}

                if layerData:isCurrentPlayer(pl) then
                    if not pl:isEnoughMagic(layerData, card) then
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
                    text = canUse .. '\n'..'Title: '..card.name .. '\n\nDescription:\n'..card.skill.active.description..'\n\nCost: ',
                    icons = icons
                }
                layerData.selection = {
                    x = top.left.x,
                    y = top.left.y,
                    width = top.width,
                    height = top.height,
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

function SceneFight:mousePressed(screen, x, y, button, isTouch, presses)
    local layerData = screen:getData()
    local currentPlayer = layerData:getCurrentPlayer()

    for _, card in pairs(currentPlayer.cards) do
        if card:isMouseOn(x,y) then
            if currentPlayer:isEnoughMagic(layerData, card) then
                self:addDbg('Magic is enough')
                currentPlayer:useCard(layerData, card)
            else
                game.assets:getFx('skill_not'):play()
            end
        end
    end
end

function SceneFight:keyPressed(screen, key)
    local gr = {down = true, up=true, left=true, right=true}

    if gr[key] then
        game.assets:getFx('move'):play()
        screen:getData().board.gravity = key
    end
end

function SceneFight:update(screen)
    local layerData = screen:getData()
    self.fx = layerData.board:move(layerData)

    local current = layerData:getCurrentPlayer()
    local nextPlayer = layerData:getNextPlayer()

    if nextPlayer:isDead() or current:isDead() then
        self.fx = 'the_end'
        screen:setViewLayers({}, 'scene_after')
        screen:changeSceneTo('fight_the_end')
    end

    game.assets:getFx(self.fx):play()

    self:addStone(layerData)

    game.assets:getFx(self.fx):play()
end

function SceneFight:addStone(layerData)
    self.fx = layerData.board:addStone(layerData) or 'none'
end