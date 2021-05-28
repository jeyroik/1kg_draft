local SourceInitializer = require 'components/sources/initializers/initializer'
local WindowHeader      = require 'components/sources/windows/header'
local WindowBody        = require 'components/sources/windows/body'

InitializerWindow = SourceInitializer:extend()

function InitializerWindow:initSource(window)
    window.header = WindowHeader(window.header)
    window.body   = WindowBody(window.body)

    self:registerHooks(window)
end

function InitializerWindow:registerHooks(window)
    local screen = game:getCurrentState()

    if not screen:hasHook('windows') then
        local hook = require 'components/sources/windows/hooks/default'
        screen:catchEvent('mousePressed', 'after', hook({alias = 'cards'}))
        screen:catchEvent('mouseMoved', 'after', hook({alias = 'cards'}))
    end
    
    local hook = screen:getHook('windows')
    hook:add(window.screenName, window.sceneName, window)
end

return InitializerWindow