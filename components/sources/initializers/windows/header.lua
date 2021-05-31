SourceInitializer   = require 'components/sources/initializers/initializer'

WindowHeaderInitializer = SourceInitializer:extend()

function WindowHeaderInitializer:initSource(header)
    header.text =  Text(header.text)
    
    
    for i,item in header.buttons do
        header.buttons[i] = Button(item)
    end
end

return WindowHeaderInitializer