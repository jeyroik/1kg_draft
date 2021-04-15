require "components/sources/initializers/has_initializer"
require "components/sources/initializers/initializer"

Source = Render:extend()
Source:implement(SourceHasInitializer)

function Source:new(config)
    self.path = ''
    self.initializer = ''

    Source.super.new(self, config)

    self.source = {}

    self:sourceInit()
end

function Source:export()
    local this = self
    this.source = {}

    return Source.super.export(self, this)
end