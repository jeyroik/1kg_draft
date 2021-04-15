BattleFightViewBoard = LayerView:extend()

function BattleFightViewBoard:render(data)
    -- dara.board:render()
    for _, columns in pairs(data.board.cells) do
        for _,stone in pairs(columns) do
            if stone.volume > -1 then
                stone:render()
            end
        end
    end
end