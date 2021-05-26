local Hook = require 'components/hooks/hook'

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
    local data = screen:getData()
    local board = data.board
    board:forEachStone(function(stone)
        if stone:isMouseOn(args.x, args.y) and (stone.volume > 1) and (stone.volume < 2048) then
            self.stoneTip = {}
            data.magic_select_skill:magicSelected(data, stone:getMagic())
            return false
        else
            return true
        end
    end)
end

function HookMagicSelect:render()
    local text = TextOverlay({
        body = 'Please, choose gem',
        sx = 2,
        sy = 2,
        overlay_mode = 'fill',
        overlay_color = {0,0,0,0.5},
        overlay_offset = 15
    })
    --text:setToCenter(true)
    text:setToPart(5, 2, 8)
    text:resetOverlay()
    text:render()

    if self.stoneTip.x then
        self.stoneTip:render()
    end
end

function HookMagicSelect:mouseMoved(screen, args)
    local board = screen:getData().board

    board:forEachStone(function(stone)
        if stone:isMouseOn(args.x, args.y) and (stone.volume > 1) and (stone.volume < 2048) then
            game.assets:getCursor('hand'):setOn()
            self.stoneTip = TextOverlay({
                body = game.assets:getMisc('magic'):getByType(stone:getMask()):getTitle(),
                x = args.x,
                y = args.y,
                overlay_mode = 'fill',
                overlay_color = {1,1,1,0.5},
                overlay_offset = 5
            })
            self.stoneTip.x = self.stoneTip.x-self.stoneTip:getWidth()-10
            self.stoneTip:resetOverlay()

            return false
        else
            game.assets:getCursor('hand'):reset()
            self.stoneTip = {}
            return true
        end
    end)
end

return HookMagicSelect