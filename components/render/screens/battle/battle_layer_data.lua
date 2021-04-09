BattleLayerData = LayerData:extend()

function BattleLayerData:new(config)
    self.board = {}
    self.players = {}
    self.current = 1
    self.next = 2
    self.magic = {}
    self.magicTypes = {}
    self.magicTypesDict = {}
    self.theEndFlag = false
    self.fx = 'none'

    BattleLayerData.super.new(self, config)
end

function BattleLayerData:init()
    self:initMagic()
    self:initBoard()
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

function BattleLayerData:initBoard()
    self:loadMagicTypes()
    self.board = Board(self.board)
    self.board:init()
end

-- @return Player
function BattleLayerData:getCurrentPlayer()
    return self.players[self.current]
end

-- @return Player
function BattleLayerData:getNextPlayer()
    return self.players[self.next]
end

-- Changes current and next player with each other
-- @return void
function BattleLayerData:nextTurn()
    local c = self.current
    self.current = self.next
    self.next = c
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
            if card.isMouseOn(x, y) then
                icons = {}
                for magicName, amount in pairs(card.skill.cost) do
                    table.insert(icons, {image=game.assets.images.gems[magicName], text=amount, xd=30, yd=180})
                end
                self.tip = {x=x, y=y, text='Player: ' ..i..'\n'..'Title: '..card.name .. '\n\nDescription: '..card.description..'\n\nCost: ', icons=icons}
                return
            else
                self.tip = {x=x, y=y, text=x .. ' < ' ..card.x ..' or '..x..' > ' .. (card.x+card.width) .. ' or '..y..' < '..card.y ..' or '..y..' > '..(card.y+card.height)}
                --game.tip = nil
                return
            end
        end
    end
end

function BattleLayerData:mousePressed(game, x, y, button, isTouch, presses)
    if not self.theEndFlag then
        local currentPlayer = self:getCurrentPlayer()

        for _, card in pairs(currentPlayer.cards) do
            if card:isMouseOn(x,y) then
                if currentPlayer:isEnoughMagic(game, card) then
                    currentPlayer:useCard(game, card)
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
        c1	 = MagicType('Deck', 0, false, false),
        c2   = MagicType('Air', 2, true, true),
        c4   = MagicType('Water', 4, true, true),
        c8   = MagicType('Tree', 8, true, true),
        c16  = MagicType('Fire', 16, true, true),
        c32  = MagicType('Life', 32, true, true),
        c64  = MagicType('Ultra air', 64, true, true),
        c128 = MagicType('Ultra water', 128, true, true),
        c256 = MagicType('Ultra tree', 256, true, true),
        c512 = MagicType('Ultra fire', 512, true, true),
        c1024 = MagicType('Ultra life', 1024, false, true),
        c2048 = MagicType('Death', 2048, false, true),
        c4096 = MagicType('Ultra Death', 2048, false, true)
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
end

function BattleLayerData:getMagicType(name)
    return self.magicTypes[name]
end

function BattleLayerData:translateMagicType(name)
    return self.magicTypesDict[name]
end

function BattleLayerData:getMagicAmount(player, magicName)
    return self.magic[player.id][magicName]
end

function BattleLayerData:incMagicAmount(player, magicName, amount)
    self.magic[player.id][magicName] = self.magic[player.id][magicName] + amount
end