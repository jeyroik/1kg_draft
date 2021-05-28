SourceInitializer   = require 'components/sources/initializers/initializer'
PositionedContainer = require 'components/sources/positioned_container'

WindowBodyInitializer = SourceInitializer:extend()

function WindowBodyInitializer:initSource(body)
    for i,item in body.content do
        local itemClass = require(item.path)
        body.content[i] = PositionedContainer(itemClass(item))
    end
end

return WindowBodyInitializer