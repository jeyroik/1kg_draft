BattleLayerData = LayerData:extend()

function BattleLayerData:new(config)
    self.players = {}
    self.current = 1
    self.next = 2
    self.magic = {}
    self.boardSize = 5
    self.cells = {}
	self.gravity = 'none'
	self.existed = 0
	self.deathPerc = 10
	self.ultraDeathPerc = 20
    self.theEndFlag = false

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
    for i=1,self.boardSize do
        self.cells[i] = {}

        for j=1,self.boardSize do
            local stone = MagicStone({row = i, column = j})

            if love.math.random(1,8) == 3 then
                stone.volume = love.math.random(1,9) == 3 and 4 or 2
                stone:applyDeathMagic(self.deathPerc, self.ultraDeathPerc)
                self:addExisted()
            end

            self.cells[i][j] = stone
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

-- Changes current and next player with each other
-- @return void
function BattleLayerData:nextTurn()
    local c = self.current
    self.current = self.next
    self.next = c
end

function BattleLayerData:addExisted()
	self.existed = self.existed + 1
end

function BattleLayerData:removeExisted()
	self.existed = self.existed - 1
end