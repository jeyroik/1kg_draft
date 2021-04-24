require "components/render/screens/battle/scenes/fight_cards/view_deck"

SceneFightCards = Scene:extend()

function SceneFightCards:new(config)
    SceneFightCards.super.new(self, config)

    self.name = 'fight_cards'
    self.views = {
        BattleFightCardsViewDeck()
    }

    self.player = 1
    self.grid = Deck({
        name = 'cards',
        count = 4,
        blank = Rectangle,
        width   = love.graphics.getWidth(),
        height  = love.graphics.getHeight(),
        columns = 3,
        rows    = 3,
        itemScale = 'fixed',
		margin = {
			top = 100,
			left = love.graphics.getWidth()/4,
			right = love.graphics.getWidth()/5,
			bottom = 100
		},
        padding = {
            top    = 50  * VisibleObject.globalScale,
            bottom = 50  * VisibleObject.globalScale,
            left   = 100 * VisibleObject.globalScale,
            right  = 100 * VisibleObject.globalScale
        }
    })
    self.grid:fill(game.assets.cards)
    self.grid.blankConfig = {width = self.grid.collection[1]:getWidth(), height = self.grid.collection[1]:getHeight()}

    self.addedCards = Deck({
        name = 'added cards',
        count = 3,
        blank = Rectangle,
        blankConfig = {width = self.grid.collection[1]:getWidth(), height = self.grid.collection[1]:getHeight()},
        width   = love.graphics.getWidth()/5,
        height  = love.graphics.getHeight(),
        columns = 1,
        rows    = 4,
        itemScale = 'fixed',
		margin = {
			top = 70,
			left = love.graphics.getWidth()/8,
			right = love.graphics.getWidth()*0.75,
			bottom = 10
		},
        padding = {
            top    = 50  * VisibleObject.globalScale,
            bottom = 50  * VisibleObject.globalScale,
            left   = 0,
            right  = 0
        }
    })

    self.buttonsGrid = Grid({
        width   = 800*VisibleObject.globalScale,
        height  = 100,
        columns = 2,
        rows    = 1,
        itemScale = 'fixed',
		margin = {
			top = 0,
			left = 0,
			right = 0,
			bottom = 0
		},
        padding = {
            top    = 10,
            bottom = 10,
            left   = 10,
            right  = 10
        }
    })
    self.buttonsGrid:addCollection({
        game.assets:getButton('submitCards'),
        game.assets:getButton('exitFight'),
    })
end

function SceneFightCards:init(screen)
    screen:addViewLayers(
        {
            LayerViewSingleSelection(),
            LayerViewTip()
        },
        'scene_after'
    )
end

function SceneFightCards:mouseMoved(screen, x, y, dx, dy, isTouch)
    local layerData = screen:getData()
    local cursor = game.assets:getCursor('hand')

    for _,card in pairs(game.assets.cards) do
        if card:isMouseOn(x, y) then
            cursor:setOn('card')

            local icons = {}
            local top = card:getEdgesFrame(3)
            local iconCounter = 0
            for magicName, amount in pairs(card.skill.active.cost) do
                local magic = game.assets:getMisc('magic'):getByName(magicName)
                table.insert(
                        icons,
                        {
                            image=game.assets:getImagePack('gems'):get(magic:getType()),
                            text=amount,
                            xd=120*VisibleObject.globalScale + iconCounter*60*VisibleObject.globalScale,
                            yd=220*VisibleObject.globalScale
                        }
                )
                iconCounter = iconCounter+1
            end

            local selectionColor = {0.5, 0.5, 0.5}

            layerData.tip = {
                x = x,
                y = y,
                sx = VisibleObject.globalScale,
                sy = VisibleObject.globalScale,
                text = 'Title: '..card.name .. '\n\nDescription:\n'..card.skill.active.description..'\n\nCost: ',
                icons = icons
            }
            layerData.selection = {
                x = top.left.x,
                y = top.left.y,
                width = top.width*card.sx,
                height = top.height*card.sy,
                color = selectionColor,
                line_width = 5
            }
            return 
        else
            layerData.tip = {}
            layerData.selection = {}
            if cursor:isSetOn() and cursor:isSetter('card') then
                cursor:reset()
            end
        end
    end

    self.buttonsGrid:forEach(function(btn, index)
        if btn:isMouseOn(x, y) then
            if btn.state == 'default' then
                btn:hover()
                return false
            end
        else
            if btn.state ~= 'default' then
                btn:released()
            end
        end
        return true
    end)
end

function SceneFightCards:mousePressed(screen, x, y, button, isTouch, presses)
    local decIsfull = self.addedCards:isFilled()
    local layerData = screen:getData()

    for index,card in pairs(self.grid.collection) do
        if card:isMouseOn(x, y) and not decIsfull then
            self.addedCards:put(card)
            self.grid:take(card)
   
            layerData.tip = {}
            layerData.selection = {}
            return
        end
    end

    for index, added in pairs(self.addedCards.collection) do
        if added:is(Card) and added:isMouseOn(x,y) then
            self.addedCards:take(added)
            self.grid:put(added)

            layerData.tip = {}
            layerData.selection = {}
            return
        end
    end

    self.buttonsGrid:forEach(function(btn) 
        if btn:isMouseOn(x, y) then
            self:addDbg('Click on "'..btn.name..'"')
            game.assets:getCursor('hand'):reset()

            if btn.name == 'exit' then
                self.grid:fillFrom(self.addedCards)
                screen:changeSceneTo('fight_before')
                game:changeStateTo('landscape')
                
            elseif btn.name == 'submit' then
                if layerData.mode == 'vs PC' then
                    layerData.players[1]:addCards(self.addedCards.collection)
                    screen:changeSceneTo('fight')
                else
                    layerData.players[self.player]:addCards(self.addedCards.collection)

                    if self.player == 1 then
                        self.player = 2
                        self.grid:fillFrom(self.addedCards)
                    else
                        self.player = 1
                        screen:changeSceneTo('fight')
                    end
                end

            end

            return false
        end

        return true
    end)
end

function SceneFightCards:mouseReleased(screen, x, y, button, isTouch, presses)

end

function SceneFightCards:update(screen)

end