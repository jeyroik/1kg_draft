require "components/game/source_initializer"

Source = Render:extend()
Source:implement(SourceInitializer)

function Source:new(config)
    self.source_type = ''
    self.path = ''

    Source.super.new(self, config)

    self.source = {}

    self:initializeSource()
end

function Source:export()
    local this = self
    this.source = {}

    return Source.super.export(self, this)
end