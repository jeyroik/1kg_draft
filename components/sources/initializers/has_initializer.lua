SourceHasInitializer = Object:extend()
SourceHasInitializer.initializers = {}

function SourceHasInitializer:initByInitializer()
    if not SourceHasInitializer.initializers[self.initializer] then
        local i = require (self.initializer)
        SourceHasInitializer.initializers[self.initializer] = i()
    end

    SourceHasInitializer.initializers[self.initializer]:initSource(self)
end

return SourceHasInitializer