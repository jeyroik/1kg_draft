InitializerFx = SourceInitializer:extend()

function InitializerFx:initSource(fx)
    fx.source = love.audio.newSource(self:buildPath(fx.path), fx.mode)

    if fx.volume > 0 then
        fx.source:setVolume(fx.volume)
    end
end

function InitializerFx:getPath()
    return 'fxs/'
end

return InitializerFx