local Source = require 'components/sources/source'

Empty = Source:extend()

function Empty:new(config)
    config = config or {}
    config.autoInit = false
    
    Empty.super.new(self, config)
end

function Empty:render()

end

return Empty