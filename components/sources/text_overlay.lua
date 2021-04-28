TextOverlay = Text:extend()

function TextOverlay:new(config)
    self.overlay = {}
    self.overlay_mode = 'line'
    self.overlay_color = {0,0,0,1}
    self.overlay_offset = 5

    config.initializer = 'components/sources/initializers/text_overlay'

    TextOverlay.super.new(self, config)
end

function TextOverlay:draw()
    self.overlay:draw()
    TextOverlay.super.draw(self)
end

function TextOverlay:reload()
    local top = self.overlay:getEdges()

    if top.right.x+dx > self.love.width then
        self.overlay.x = self.love.width - self.overlay.width*self.sx
    end

    if top.left.x+dx < 0 then
        self.overlay.x = 5
    end

    if top.left.y+dy > self.love.height then
        self.overlay.y = self.love.height - self.overlay.height*self.sy
    end

    if top.left.y+dy < 0 then
        self.overlay.y = 5
    end
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