Hook = require 'components/hooks/hook'

CardHook = Hook:extend()

function CardHook:new(config)
    CardHook.super.new(self, config)
end

function CardHook:on(eventName, event)
    local screenName = game.__state__
    local sceneName  = screen.__state__

    if eventName:find('cardMouseOn') then
        screen:registerTip({
            screenName = screenName,
            sceneName  = sceneName,
            with = {
                header = false,
                body = true
            },
            body = {
                content = {
                    {
                        path = 'components/sources/text',
                        body = event.args.card.description,
                        grid = {
                            row     = 0,
                            column  = 0,
                            width   = 2,
                            height  = 1
                        }
                    }
                }
            }
        })
    elseif eventName:find('cardPressed') then
        --
    end
end

return CardHook