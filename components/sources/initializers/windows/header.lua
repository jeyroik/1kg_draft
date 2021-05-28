SourceInitializer   = require 'components/sources/initializers/initializer'
PositionedContainer = require 'components/sources/positioned_container'

WindowHeaderInitializer = SourceInitializer:extend()

function WindowHeaderInitializer:initSource(header)
    header.text =  PositionedContainer(Text(header.text))
    
    
    for i,item in header.buttons do
        header.buttons[i] = PositionedContainer(Button(item))
    end
end

return WindowHeaderInitializer