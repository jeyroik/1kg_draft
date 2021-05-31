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
        screen:registerTip({
            screenName = screenName,
            sceneName  = sceneName,
            with = {
                header = false,
                body = true
            },
            body = {
                grid = {
                    row     = 0,
                    column  = 0,
                    width   = 2,
                    height  = 1
                },
                content = {
                    {
                        path = 'components/sources/text',
                        body = args.card.description
                    }
                }
            }
        })
    elseif event == 'cardPressed' and stage == 'self' then
        --
    end
end

return CardHook