local LayerData = require "components/screens/layers/layer_data"

Data = LayerData:extend()

-- @param table config
-- @return void
function Data:new(config)
    self.board = {
        size = 5,
        deathPerc = 10,
        ultraDeathPerc = 20,
        stonesPerRound = 3,
        width = love.graphics.getHeight()*0.6,
        height = love.graphics.getHeight()*0.6
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

    Data.super.new(self, config)
end

-- @return void
function Data:init(args)
    --self.players = args.players
    Data.super.init(self)
end

-- @return Player
function Data:getCurrentPlayer()
    return self.players[self.current]
end

-- @return Player
function Data:getNextPlayer()
    return self.players[self.next]
end

-- @param Player player
-- @return boolean
function Data:isCurrentPlayer(player)
    return player.id == self:getCurrentPlayer().id
end

-- Changes current and next player with each other
-- @return void
function Data:nextTurn()
    local c = self.current
    self.current = self.next
    self.next = c

    if not self:getCurrentPlayer().isHuman then
        local gr = {'down', 'up', 'left', 'right'}
        love.event.push('keypressed', gr[love.math.random(1, 4)])
    end
end

return Data