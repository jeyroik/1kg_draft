require "components/render/cards/fire_elemental"
require "components/render/cards/tree_elemental"
require "components/render/cards/life_elemental"
require "components/render/cards/water_elemental"

BattleLayerData = LayerData:extend()

-- @param table config
-- @return void
function BattleLayerData:new(config)
    self.board = {
        size = 5,
        deathPerc = 10,
        ultraDeathPerc = 20,
        stonesPerRound = 3,
        width = love.graphics.getHeight()*0.6,
        height = love.graphics.getHeight()*0.6,
        x = 270,
        y = 20
    }
    self.statistics = {
        {
            damage_taken = 0,
            damaged = 0,
            stones = 0,
            spells = 0,
            win = false
        },
        {
            damage_taken = 0,
            damaged = 0,
            stones = 0,
            spells = 0,
            win = false
        }
    }
    self.players = {}
    self.current = 1
    self.next = 2
    self.magic = {}
    self.mode = ''
    self.theEndFlag = false
    self.fx = 'none'

    BattleLayerData.super.new(self, config)
end

-- @param Game game
-- @return void
function BattleLayerData:init()
    BattleLayerData.super.init(self)
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
