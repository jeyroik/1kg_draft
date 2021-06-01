local GameObject = require 'components/game/object'

GameResources = GameObject:extend()

function GameResources:new(config)
    self.items = {}

    GameResources.super.new(self, config)
end

function GameResources:create(name, config)
    if not self.items[name] then
        return {}
    end

    local resourceClass = require(self.items[name].path)
    local name = config.name or self:getId()
    local screen = game:getCurrentState()

    config.screenName = screen.name
    config.sceneName  = screen:getCurrentState().name
    config.name       = config.screenName .. '.' .. config.sceneName .. '.' .. name

    return resourceClass(config)
end

return GameResources