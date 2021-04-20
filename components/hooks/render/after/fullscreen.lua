HookFullscreen = Hook:extend()

function HookFullscreen:new(config)
    self.tip = {}

    HookFullscreen.super.new(self, config)

    self.alias = 'fullscreen'
end

function HookFullscreen:catch(screen, args, event, stage)
    if event == 'render' and stage == 'after' then
        self:render()
    elseif event == 'mouseMoved' and stage == 'after' then
        self:mouseMoved(args)
    elseif event == 'mousePressed' and stage == 'after' then
        self:mousePressed(args)
    end
end

function HookFullscreen:mousePressed(args)
    local icon = self:getIcon()

    if icon:isMouseOn(args.x, args.y) then
        width, height, flags = love.window.getMode( )
        love.window.setFullscreen( not flags.fullscreen )
    end
end

function HookFullscreen:mouseMoved(args)
    local icon = self:getIcon()
    Printer.flushDbg(self)

    if icon:isMouseOn(args.x, args.y) then
        self.tip = TextOverlay({
            body = 'Toggle fullscreen',
            x = args.x,
            y = args.y,
            overlay_mode = 'fill',
            overlay_color = {1,1,1,0.3},
            overlay_offset = 5
        })
        self.tip.x = self.tip.x-self.tip:getWidth()-10
        self.tip:resetOverlay()
    else
        self.tip = {}
    end
end

function HookFullscreen:render()
    local icon = self:getIcon()
    icon:render()
    if self.tip.x then
        self.tip:render()
    end
end

function HookFullscreen:getIcon()
    local imgName = 'fullscreen_'

    width, height, flags = love.window.getMode( )

    if flags.fullscreen then
        imgName = imgName..'out'
    else
        imgName = imgName..'in'
    end

    local icon = game.assets:getImage(imgName)
    icon.sx = VisibleObject.globalScale
    icon.sy = VisibleObject.globalScale
    icon:stickToRight(
            {
                x = 0,
                y = 0,
                sx = 1,
                sy = 1,
                width = width,
                height = height
            },
            'inside'
    )

    return icon
end

return HookFullscreen