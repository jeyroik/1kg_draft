Hook = Object:extend()
Hook:implement(Config)
Hook:implement(Printer)

function Hook:new(config)
    self.alias = ''
    self:applyConfig(self, config)
end

function Hook:getAlias()
    return self.alias
end

function Hook:catch(screen, args, event, stage)

end