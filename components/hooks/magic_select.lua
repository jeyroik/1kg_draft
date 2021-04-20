HookMagicSelect = Hook:extend()

function HookMagicSelect:new(config)
    self.stoneTip = {}

    HookMagicSelect.super(self, config)

    self.alias = 'hook_magic_select'
end

function HookMagicSelect:catch(screen, args, event, stage)
    if event == 'mouseMoved' then
        self:mouseMoved(screen, args)
    elseif event == 'mousePressed' then
        self:mousePressed(screen, args)
    elseif event == 'render' then
        self:render()
    end
end

function HookMagicSelect:mousePressed(screen, args)
    local board = screen:getData().board
    board:forEachStone(function(stone)
        if stone:isMouseOn(args.x, args.y) then
            self.stoneTip = {}
            self.magicName = stone:getMagic():getName()
        end
    end)
end

function HookMagicSelect:render()
    if self.stoneTip.x then
        self.stoneTip:render()
    end
end

function HookMagicSelect:mouseMoved(screen, args)
    local board = screen:getData().board
    board:forEachStone(function(stone)
        if stone:isMouseOn(args.x, args.y) then
            self.stoneTip = TextOverlay({
                body = game.assets:getMisc('magic'):getByType(stone:getMask()):getTitle(),
                x = args.x,
                y = args.y,
                overlay_mode = 'fill',
                overlay_color = {1,1,1,0.3},
                overlay_offset = 5
            })
        end
    end)
end