local LayerView = require "components/screens/layers/layer_view"

BattleFightAfterViewStatistics = LayerView:extend()

function BattleFightAfterViewStatistics:new(config)
    BattleFightAfterViewStatistics.super.new(self, config)
end

function BattleFightAfterViewStatistics:draw(screen)
    local stats = screen.statistics

    for i, player in pairs(stats) do
        local name = game:create('text', { body = 'Player '..i})
        local offset = i-1
        game:put(name, 7,4+(13*offset), 6,2)
        name:draw()

        local damageTaken = game:create('text', { body = 'Damage taken: '..player.damage_taken })
        game:put(damageTaken, 10,4+(13*offset), 6,1)
        damageTaken:draw()

        local damaged = game:create('text', { body = 'Damaged: '..player.damaged })
        game:put(damaged, 12,4+(13*offset), 6,1)
        damaged:draw()

        local stones = game:create('text', { body = 'Stones destroyed: '..player.stones })
        game:put(stones, 14,4+(13*offset), 6,1)
        stones:draw()

        local spells = game:create('text', { body = 'Spells casted: '..player.spells })
        game:put(spells, 16,4+(13*offset), 6,1)
        spells:draw()
    end
end

return BattleFightAfterViewStatistics