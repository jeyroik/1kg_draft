TextOverlay = Text:extend()

function TextOverlay:new(config)
    self.overlay = {}
    self.overlay_mode = 'line'
    self.overlay_color = {0,0,0,1}
    self.overlay_offset = 5

    config.initializer = 'components/sources/initializers/text_overlay'

    TextOverlay.super.new(self, config)
end

function TextOverlay:render(dx, dy, radian, sx, sy)
    self.overlay:render(dx, dy)
    TextOverlay.super.render(self, dx, dy, radian, sx, sy)
end

function TextOverlay:resetOverlay()
    self.overlay = Rectangle({
        mode = self.overlay_mode,
        x = self.x - self.overlay_offset,
        y = self.y - self.overlay_offset,
        width = self:getWidth() * self.sx + self.overlay_offset*2,
        height = self:getHeight() * self.sy + self.overlay_offset*2,
        color = self.overlay_color
    })
end