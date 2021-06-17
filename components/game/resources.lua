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
    local resourceName = config.name or self:getId()
    local screen = game:getCurrentState()
    local scene = screen:getCurrentState()

    config.screenName = screen.name
    config.sceneName  = scene.name


    local resource = resourceClass(config)

    if resource.prefixedName then
        resource.name = config.screenName .. '.' .. config.sceneName .. '.' .. resourceName
    end

    return resource
end

return GameResources