InitializerButton = InitializerImage:extend()

function InitializerButton:initSource(button)
    button.source.images = {}

    button.source.images.default = Image({
        path = button.path.default,
        x = button.x, y = button.y, radian = button.radian, sx = button.sx, sy = button.sy
    })
    button.source.images.hovered = Image({
        path = button.path.hovered or button.path.default,
        x = button.x, y = button.y, radian = button.radian, sx = button.sx, sy = button.sy
    })
    button.source.images.clicked = Image({
        path = button.path.clicked or button.path.default,
        x = button.x, y = button.y, radian = button.radian, sx = button.sx, sy = button.sy
    })
    button.source.images.disabled = Image({
        path = button.path.disabled or button.path.default,
        x = button.x, y = button.y, radian = button.radian, sx = button.sx, sy = button.sy
    })
    button.source.text = Text({ body = button.text })
    button.source.text:scaleTo(button.source.images.default, button.text_scale)
    button.source.text:setToCenterOfObject(button.source.images.default)
end

return InitializerButton