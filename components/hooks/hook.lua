Hook = Object:extend()
Hook:implement(Config)
Hook:implement(Printer)

function Hook:new(config)
    self.alias = ''

    Hook:applyConfig(self, config)
end

function Hook:catch(screen, args, event, stage)

end