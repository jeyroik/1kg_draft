require "components/render/cards/card_fire_elemental"
require "components/render/cards/card_tree_elemental"

BattleLayerData = LayerData:extend()

function BattleLayerData:new(config)
    self.board = {}
    self.players = {}
    self.current = 1
    self.next = 2
    self.magic = {}
    self.magicTypes = {}
    self.magicTypesDict = {}
    self.magicNamesDict = {}
    self.theEndFlag = false
    self.fx = 'none'

    BattleLayerData.super.new(self, config)
end

function BattleLayerData:init(game)
    self:initMagic()
    self:initBoard(game)
end

function BattleLayerData:initMagic()
    local current = self:getCurrentPlayer()
    local enemy = self:getNextPlayer()

    if not self.magic[current.id] then

        self.magic[current.id] = {}
        self.magic[enemy.id] = {}

        for i=0, 10 do
            self.magic[current.id]['c'..math.pow(2,i)] = 0
            self.magic[enemy.id]['c'..math.pow(2,i)] = 0
        end
    end
end

function BattleLayerData:initBoard(game)
    self:loadMagicTypes()
    self.board = Board(self.board)
    self.board:init()

    local cardDefault = game.assets:getMisc('card')

    local current = self:getCurrentPlayer()
    current:addCard(CardFireElemental({width = cardDefault.width, height = cardDefault.height}))
    current:addCard(CardTreeElemental({width = cardDefault.width, height = cardDefault.height}))

    local next = self:getNextPlayer()
    next:addCard(CardFireElemental({width = cardDefault.width, height = cardDefault.height}))
end

-- @return Player
function BattleLayerData:getCurrentPlayer()
    return self.players[self.current]
end

-- @return Player
function BattleLayerData:getNextPlayer()
    return self.players[self.next]
end

function BattleLayerData:isCurrentPlayer(player)
    return player.id == self:getCurrentPlayer().id
end

-- Changes current and next player with each other
-- @return void
function BattleLayerData:nextTurn()
    local c = self.current
    self.current = self.next
    self.next = c

    if not self:getCurrentPlayer().isHuman then
        local gr = {'down', 'up', 'left', 'right'}
        love.event.push('keypressed', gr[love.math.random(1, 4)])
    end
end

function BattleLayerData:addStone()
    if  not self.theEndFlag then
        self.fx = self.board:addStone(self) or 'none'
    end
end

function BattleLayerData:mouseMoved(game, x, y, dx, dy, isTouch)
    for i=1,2 do
        pl = self.players[i]
        for _, card in pairs(pl.cards) do
            if card:isMouseOn(x, y) then
                local icons = {}
                local cost = card.skill.active:getCost(self)
                local top = card:getEdgesFrame(3)

                for magicType, amount in pairs(cost) do
                    table.insert(icons, {image=game.assets.images.gems[magicType], text=amount, xd=100, yd=200})
                end

                local canUse = ''
                local selectionColor = {0.5, 0.5, 0.5}

                if self:isCurrentPlayer(pl) then
                    if not pl:isEnoughMagic(self, card) then
                        canUse = 'Not enough magic'
                        selectionColor = {1, 0, 0}
                    else
                        selectionColor = {0, 0.5, 0}
                    end
                else
                    canUse = 'Can not use. Please, wait your turn'
                    selectionColor = {0.5, 0.5, 0.5}
                end

                self.tip = {x=x, y=y, text=canUse .. '\n'..'Title: '..card.name .. '\n\nDescription:\n'..card.skill.active.description..'\n\nCost: ', icons=icons}
                self.selection = {
                    x = top.left.x, y = top.left.y, width = top.width, height = top.height,
                    color = selectionColor,
                    line_width = 5
                }
                love.mouse.setCursor(game.assets:getCursor('hand'))
                return
            else
                self.tip = {}
                self.selection = {}
                love.mouse.setCursor()
            end
        end
    end
end

function BattleLayerData:mousePressed(game, x, y, button, isTouch, presses)
    if not self.theEndFlag then
        local currentPlayer = self:getCurrentPlayer()

        for _, card in pairs(currentPlayer.cards) do
            if card:isMouseOn(x,y) then
                if currentPlayer:isEnoughMagic(self, card) then
                    self:addDbg('Magic is enough')
                    currentPlayer:useCard(game, self, card)
                else
                    game.assets:playFx('skill_not')
                end
            end
        end
    end
end

function BattleLayerData:keyPressed(game, key)
    if not self.theEndFlag then
        local gr = {down = true, up=true, left=true, right=true}

        if gr[key] then
            game.assets:playFx('move')
            self.board.gravity = key
        end
    end
end

function BattleLayerData:update(game)
    self.fx = self.board:move(game, self)

    local current = self:getCurrentPlayer()
    local nextPlayer = self:getNextPlayer()

    if nextPlayer:isDead() or current:isDead() then
        self.fx = 'the_end'
        self.theEndFlag = true
    end

    game.assets:playFx(self.fx)

    self:addStone()

    game.assets:playFx(self.fx)
end

function BattleLayerData:loadMagicTypes()
    self.magicTypes = {
        c1	 = MagicType({name = 'Deck', volume = 0, isCanBeMerged = false, isDestroyable = false}),
        c2   = MagicType({name = 'Air', volume = 2, isCanBeMerged = true, isDestroyable = true}),
        c4   = MagicType({name = 'Water', volume = 4, isCanBeMerged = true, isDestroyable = true}),
        c8   = MagicType({name = 'Tree', volume = 8, isCanBeMerged = true, isDestroyable = true}),
        c16  = MagicType({name = 'Fire', volume = 16, isCanBeMerged = true, isDestroyable = true}),
        c32  = MagicType({name = 'Life', volume = 32, isCanBeMerged = true, isDestroyable = true}),
        c64  = MagicType({name = 'Ultra air', volume = 64, isCanBeMerged = true, isDestroyable = true}),
        c128 = MagicType({name = 'Ultra water', volume = 128, isCanBeMerged = true, isDestroyable = true}),
        c256 = MagicType({name = 'Ultra tree', volume = 256, isCanBeMerged = true, isDestroyable = true}),
        c512 = MagicType({name = 'Ultra fire', volume = 512, isCanBeMerged = true, isDestroyable = true}),
        c1024 = MagicType({name = 'Ultra life', volume = 1024, isCanBeMerged = true, isDestroyable = true}),
        c2048 = MagicType({name = 'Death', volume = 2048, isCanBeMerged = false, isDestroyable = true}),
        c4096 = MagicType({name = 'Ultra Death', volume = 4096, isCanBeMerged = false, isDestroyable = true})
    }

    self.magicTypesDict = {
        c1 = 'deck',
        c2 = 'air',
        c4 = 'water',
        c8 = 'tree',
        c16 = 'fire',
        c32 = 'life',
        c64 = 'air_ultra',
        c128 = 'water_ultra',
        c256 = 'tree_ultra',
        c512 = 'fire_ultra',
        c1024 = 'life_ultra',
        c2048 = 'death',
        c4096 = 'death_ultra'
    }

    self.magicNamesDict = {
        deck = 'c1',
        air = 'c2',
        water = 'c4',
        tree = 'c8',
        fire = 'c16',
        life = 'c32',
        air_ultra = 'c64',
        water_ultra = 'c128',
        tree_ultra = 'c256',
        fire_ultra = 'c512',
        life_ultra = 'c1024',
        death = 'c2048',
        death_ultra = 'c4096'
    }
end

function BattleLayerData:getMagicType(name)
    return self.magicTypes[name]
end

function BattleLayerData:translateMagicType(name)
    return self.magicTypesDict[name]
end

function BattleLayerData:translateMagicName(name)
    return self.magicNamesDict[name]
end

function BattleLayerData:getMagicAmount(player, magicType)
    return self.magic[player.id][magicType]
end

function BattleLayerData:incMagicAmount(player, magicType, amount)
    self.magic[player.id][magicType] = self.magic[player.id][magicType] + amount
end

function BattleLayerData:decMagicAmount(player, magicType, amount)
    self:incMagicAmount(player, magicType, -amount)
end