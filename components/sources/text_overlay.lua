TextOverlay = Text:extend()

function TextOverlay:new(config)
    self.overlay = {}
    self.overlay_mode = 'line'
    self.overlay_color = {0,0,0,1}
    self.overlay_offset = 5

    config.initializer = 'components/sources/initializers/text_overlay'

    TextOverlay.super.new(self, config)
end

function TextOverlay:draw(dx, dy, radian, sx, sy)
    local top = self.overlay:getEdges()

    if top.right.x+dx > self.love.width then
        dx = self.love.width - (top.right.x+dx)
    end

    if top.left.x+dx < 0 then
        dx = 0 - (top.left.x+dx)
    end

    if top.left.y+dy > self.love.height then
        dy = self.love.height - (top.left.y+dy)
    end

    if top.left.y+dy < 0 then
        dy = 0 - (top.left.y+dy)
    end

    self.overlay:draw(dx, dy, radian, sx, sy)
    TextOverlay.super.draw(self, dx, dy, radian, sx, sy)
end

function TextOverlay:resetOverlay()
    self.overlay = Rectangle({
        mode   = self.overlay_mode,
        x      = self.x - self.overlay_offset,
        y      = self.y - self.overlay_offset,
        width  = self:getWidth() + self.overlay_offset*2,
        height = self:getHeight() + self.overlay_offset*2,
        color  = self.overlay_color
    })
end