require "components/sources/initializers/has_initializer"
require "components/sources/initializers/initializer"

Source = VisibleObject:extend()
Source:implement(SourceHasInitializer)

function Source:new(config)
    self.path = ''
    self.initializer = ''
    self.autoInit = true

    Source.super.new(self, config)

    self.source = {}

    if self.autoInit then
        self:init()
    end
end

function Source:export()
    local this = self
    this.source = {}

    return Source.super.export(self, this)
end