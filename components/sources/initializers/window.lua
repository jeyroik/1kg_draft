local SourceInitializer = require 'components/sources/initializers/initializer'
local WindowHeader      = require 'components/sources/windows/header'
local WindowBody        = require 'components/sources/windows/body'

InitializerWindow = SourceInitializer:extend()

function InitializerWindow:initSource(window)
    if window.with.header then
        window.header = WindowHeader(window.header)
    end

    if window.with.body then
        window.body   = WindowBody(window.body)
    end

    self:registerHooks(window)
end

function InitializerWindow:registerHooks(window)
    local screen = game:getCurrentState()

    if not screen:hasHook('windows') then
        local hook          = require 'components/hooks/event'
        local hookInstance  = hook({alias = 'windows', objectName = 'window'})

        screen:catchEvent('mousePressed', 'after', hookInstance)
        screen:catchEvent('mouseMoved'  , 'after', hookInstance)
    end
    
    local hook = screen:getHook('windows')
    
    hook:add(window.screenName, window.sceneName, window)
end

return InitializerWindow