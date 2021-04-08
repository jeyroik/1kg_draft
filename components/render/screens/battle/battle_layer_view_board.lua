BattleLayerViewBoard = View:extend()

function BattleLayerViewBoard:render(game, data)
    for _, columns in pairs(data.cells) do
        for _,stone in pairs(columns) do
            if stone.volume > -1 then
                if game.assets.images.gems[stone:getMask()] then
                    stone:render(game, dx, dy)
                end
            end
        end
    end
end