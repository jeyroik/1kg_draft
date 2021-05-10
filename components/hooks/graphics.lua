local Hook = require 'components/hooks/hook'

HookGraphics = Hook:extend()

function HookGraphics:new(config)
    self.tip = {}

    HookFullscreen.super.new(self, config)

    self.alias = 'fullscreen'
end

function HookGraphics:catch(screen, args, event, stage)
    local scene = screen:getCurrentState()

    self:initIsOn(scene)
    self:initFps(scene)

    if args.key == 'g' then
        scene.arguments['graphics__isOn'] = not scene.arguments['graphics__isOn']
    end

    if args.key == 'f' then
        scene.arguments['graphics__fps'] = not scene.arguments['graphics__fps']
    end
end

function HookGraphics:initIsOn(scene)
    if not scene.arguments['graphics__isOn'] then
        scene.arguments['graphics__isOn'] = false
    end
end

function HookGraphics:initFps(scene)
    if not scene.arguments['graphics__fps'] then
        scene.arguments['graphics__fps'] = false
    end
end

return HookGraphics