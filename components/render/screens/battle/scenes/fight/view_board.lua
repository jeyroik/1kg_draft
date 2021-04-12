BattleFightViewBoard = LayerView:extend()

function BattleFightViewBoard:render(data)
    for _, columns in pairs(data.board.cells) do
        for _,stone in pairs(columns) do
            if stone.volume > -1 then
                if game.assets.images.gems[stone:getMask()] then
                    stone:render()
                end
            end
        end
    end
end