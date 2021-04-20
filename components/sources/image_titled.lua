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

function ImageTitled:render(mode, dx, dy)
    if mode == 'image' then
        self.image:render(dx, dy)
    elseif mode == 'title' then
        self.text:render(dx, dy)
    else
        self.image:render(dx, dy)
        self.text:render(dx, dy)
    end
end