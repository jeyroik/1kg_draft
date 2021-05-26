local SourceInitializer = require 'components/sources/initializers/initializer'

InitializerGroup = SourceInitializer:extend()

function InitializerGroup:initSource(group)
    if group.fromAssets then
        local items = {}
        for source, aliases in pairs(group.items) do
            for _, alias in pairs(aliases) do
                items[alias] = game.assets[source][alias]
            end
        end
        group.items = items
    end

    if group.attachItems then
        group.forEach(function(alias, item) 
            item.x = group.x
            item.y = group.y
        end)
    end
end

return InitializerGroup