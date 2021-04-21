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

function Source:validateParams(dx, dy, radian, sx, sy)
    dx = dx or 0
    dy = dy or 0
    radian = radian or 0
    sx = sx or 1
    sy = sy  or 1

    return dx, dy, radian, sx, sy
end

function Source:export()
    local this = self
    this.source = {}

    return Source.super.export(self, this)
end