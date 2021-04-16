BattleFightAfterViewStatistics = LayerView:extend()

function BattleFightAfterViewStatistics:new(config)
    BattleFightAfterViewStatistics.super.new(self, config)

    self.theEnd = 'theEnd'
    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleFightAfterViewStatistics:render(data)
    local stats = data.statistics

    for i, player in pairs(stats) do
        local name = Text({ body = 'Player '..i})
        name:setToCenter(true, 200*i)
        name:render()

        local damageTaken = Text({ body = 'Damage taken: '..player.damage_taken })
        damageTaken:stickToBottom(name)
        damageTaken:render()

        local damaged = Text({ body = 'Damaged: '..player.damaged})
        damaged:stickToBottom(damageTaken)
        damaged:render()

        local stones = Text({ body = 'Stones destroyed: '..player.stones})
        stones:stickToBottom(damaged)
        stones:render()

        local spells = Text({ body = 'Spells casted: '..player.spells})
        spells:stickToBottom(stones)
        spells:render()
    end
end