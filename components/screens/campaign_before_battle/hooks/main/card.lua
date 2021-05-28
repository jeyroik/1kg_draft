Hook = require 'components/hooks/hook'

CardHook = Hook:extend()

function CardHook:new(config)
    CardHook.super.new(self, config)

    self.alias = config.alias or 'card_hook'
end

function CardHook:catch(screen, args, event, stage)
    local screenName = game.__state__
    local sceneName  = screen.__state__

    if event == 'cardMouseOn' and stage == 'self' then
        --todo: show tip
    elseif event == 'cardPressed' and stage == 'self' then
        --
    end
end

return CardHook