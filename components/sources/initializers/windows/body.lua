SourceInitializer   = require 'components/sources/initializers/initializer'

WindowBodyInitializer = SourceInitializer:extend()

function WindowBodyInitializer:initSource(body)
    for i,item in pairs(body.content) do
        local itemClass = require(item.path)
        body.content[i] = itemClass(item)
        if body.content[i].width > body.width then
            body.width = body.content[i].width
        end

        if body.content[i].height > body.height then
            body.height = body.content[i].height
        end
    end
end

return WindowBodyInitializer