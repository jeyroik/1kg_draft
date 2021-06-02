local SourceHasInitializer = require "components/sources/initializers/has_initializer"
local VisibleObject        = require 'components/game/visible_object'

Source = VisibleObject:extend()
Source:implement(SourceHasInitializer)

function Source:new(config)
    self.path         = ''
    self.initializer  = ''
    self.autoInit     = true
    self.selected     = false
    self.prefixedName = true

    Source.super.new(self, config)

    self.source = {}

    if self.autoInit then
        self:init()
    end
end

function Source:init(...)
    self:initByInitializer()
end

function Source:reload()
end

return Source