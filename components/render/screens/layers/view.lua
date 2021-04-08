View = ScreenLayer:extend()

function View:new(config)
    View.super.new(self, config)

    self.mode = 'view'
end

