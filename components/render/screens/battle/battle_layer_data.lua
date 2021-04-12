require "components/render/cards/fire_elemental"
require "components/render/cards/tree_elemental"
require "components/render/cards/life_elemental"

BattleLayerData = LayerData:extend()

-- @param table config
-- @return void
function BattleLayerData:new(config)
    self.board = {
        size = 5,
        deathPerc = 10,
        ultraDeathPerc = 20,
        stonesPerRound = 3
    }
    self.players = {}
    self.current = 1
    self.next = 2
    self.magic = {}
    self.theEndFlag = false
    self.fx = 'none'

    BattleLayerData.super.new(self, config)

    for i=1,2 do
        self.players[i] = Player(self.players[i])
    end
end

-- @param Game game
-- @return void
function BattleLayerData:init(game)
    BattleLayerData.super.init(self, game)

    self:initMagic()
end

-- @return void
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

-- @return Player
function BattleLayerData:getCurrentPlayer()
    return self.players[self.current]
end

-- @return Player
function BattleLayerData:getNextPlayer()
    return self.players[self.next]
end

-- @param Player player
-- @return boolean
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

-- @param Player player
-- @param string magicType magic type like 'c32'
-- @return number
function BattleLayerData:getMagicAmount(player, magicType)
    return self.magic[player.id][magicType]
end

-- @param Player player
-- @param string magicType magic type like 'c32'
-- @param number amount
-- @return void
function BattleLayerData:incMagicAmount(player, magicType, amount)
    self.magic[player.id][magicType] = self.magic[player.id][magicType] + amount
end

-- @param Player player
-- @param string magicType magic type like 'c32'
-- @param number amount
-- @return void
function BattleLayerData:decMagicAmount(player, magicType, amount)
    self:incMagicAmount(player, magicType, -amount)
end