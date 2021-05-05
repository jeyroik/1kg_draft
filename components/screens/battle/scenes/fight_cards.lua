require "components/screens/battle/scenes/fight_cards/view_deck"

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
            top    = 50,
            bottom = 50,
            left   = 100,
            right  = 100
        }
    })

    self.addedCards = Deck({
        name = 'added cards',
        count = 3,
        blank = Rectangle,
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
            top    = 50,
            bottom = 50,
            left   = 0,
            right  = 0
        }
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

    for _, model in pairs(game.assets.characters) do
        self.grid:add(Card(model))
    end
end

function SceneFightCards:mouseMoved(screen, x, y, dx, dy, isTouch)
    local layerData = screen:getData()
    local cursor = game.assets:getCursor('hand')

    for _,card in pairs(game.assets.cards) do
        if card:isMouseOn(x, y) then
            cursor:setOn('card')

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
                            xd=150 + iconCounter*60,
                            yd=200
                        }
                )
                iconCounter = iconCounter+1
            end

            local selectionColor = {0.5, 0.5, 0.5}

            layerData.tip = {
                x = x,
                y = y,
                sx = 1,
                sy = 1,
                text = 'Title: '..card.name .. '\n\nDescription:\n'..card.skill.active.description..'\n\nCost: ',
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
            return 
        else
            layerData.tip = {}
            layerData.selection = {}
            if cursor:isSetOn() and cursor:isSetter('card') then
                cursor:reset()
            end
        end
    end

    game.assets:getGroup('fight_cards_buttons'):forEach(function(alias, btn) 
        if btn:isMouseOn(x, y) then
            if btn.state == 'default' then
                btn:hover()
                self:addDbg(btn.x..','..btn.y..'; '..btn:getWidth()..','..btn:getHeight())
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

    game.assets:getGroup('fight_cards_buttons'):forEach(function(alias, btn) 
        if btn:isMouseOn(x, y) then
            self:addDbg('Click on "'..btn.name..'"')
            game.assets:getCursor('hand'):reset()

            if btn.name == 'exit' then
                self.grid:fillFrom(self.addedCards)
                screen:changeStateTo('fight_before')
                game:changeStateTo('landscape')
                
            elseif btn.name == 'submit' then
                if layerData.mode == 'vs PC' then
                    layerData.players[1]:addCards(self.addedCards.collection)
                    screen:changeStateTo('fight')
                else
                    layerData.players[self.player]:addCards(self.addedCards.collection)

                    if self.player == 1 then
                        self.player = 2
                        self.grid:fillFrom(self.addedCards)
                    else
                        self.player = 1
                        screen:changeStateTo('fight')
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

return SceneFightCards