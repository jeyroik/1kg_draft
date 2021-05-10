local GameObject = require 'components/game/object'

Hook = GameObject:extend()

function Hook:new(config)
    Hook.super.new(self, config)
end

function Hook:getAlias()
    return self.alias
end

function Hook:catch(screen, args, event, stage)

end

return Hook