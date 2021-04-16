InitializerPlayer = SourceInitializer:extend()

function InitializerPlayer:initSource(player)
    local magics = game.assets:getMisc('magic')

    for _, magic in pairs(magics.items) do
        player.battle_magic[magic:getName()] = 0
    end
end

return InitializerPlayer