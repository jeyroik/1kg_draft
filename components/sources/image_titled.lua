ImageTitled = Source:extend()

function ImageTitled:new(config)
    self.text = {}
    self.image = {}

    config.initializer = 'components/sources/initializers/image_titled'

    ImageTitled.super.new(self, config)

    self.x = self.image.x
    self.y = self.image.y
    self.width = self.image.width
    self.height = self.image.height
    self.sx = self.image.sx
    self.sy = self.image.sy
end

function ImageTitled:render(mode)
    local render = Render(self.renderConfig)
    render:draw(self, mode)
end

function ImageTitled:draw(dx, dy, radian, sx, sy, mode)

    if mode == 'image' then
        self.image:draw(dx, dy, radian, sx, sy)
    elseif mode == 'title' then
        self.text:draw(dx, dy, radian, sx, sy)
    else
        self.image:draw(dx, dy, radian, sx, sy)
        self.text:render(dx, dy, radian, sx, sy)
    end
end