local SourceInitializer = require 'components/sources/initializers/initializer'
local MagicStone        = require 'components/sources/stone'

InitializerBoard = SourceInitializer:extend()

function InitializerBoard:initSource(board)
    if #board.cells == 0 then
        self:generate(board)
    end

    for i=1,board.rows do
        for j=1,board.columns do
            local stone = MagicStone({
                row = i,
                column = j,
                volume = board.cells[i][j]
            })
            board.cells[i][j] = stone
        end
    end
end

function InitializerBoard:generate(board)
    for i=1,board.rows do
        board.cells[i] = {}

        for j=1,board.columns do
            local volume = 1

            if love.math.random(1,8) == 3 then
                volume = love.math.random(1,9) == 3 and 4 or 2
                volume = self:applyDeathMagic(volume, board.deathPerc, board.ultraDeathPerc)
                board:incExisted()
            end

            board.cells[i][j] = volume
        end
    end
end

function InitializerBoard:applyDeathMagic(volume, deathPerc, ultraDeathPerc)
    deathPerc = deathPerc or 10
    ultraDeathPerc = ultraDeathPerc or 20

    if love.math.random(1,deathPerc) == 1 then
        volume = 2048
    end

    if love.math.random(1,ultraDeathPerc) == 1 then
        volume = 4096
    end

    return volume
end

return InitializerBoard