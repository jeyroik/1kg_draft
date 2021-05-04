Graphics = Object:extend()
Graphics:implement(Config)

function Graphics:new(config)
    self.width = love.graphics.getWidth()
    self.height = love.graphics.getHeight()
    self.onResize = 'change amount'

    self.item = {
        width  = 16,
        height = 16
    }
    
    self:applyConfig(config)

    self.current = {
        width  = 16,
        height = 16
    }
    self:update()
end

function Graphics:getItem(row, column)
    return {
        width  = self.current.width,
        height = self.current.height,
        x      = self.current.width  * (column-1),
        y      = self.current.height * (row-1)
    }
end

function Graphics:forEach(dispatcher)
    local screenWidth  = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local loop = function ()
        for i=1,screenHeight/self.current.height do
            for j=1,screenWidth/self.current.width do
                local continue = dispatcher(self:getItem(i, j), i, j)
                if not continue then
                    return
                end
            end
        end
    end

    loop()
end

function Graphics:update()
    if self.onResize == 'change size' then
        self.current.width  = self.item.width * (love.graphics.getWidth()/self.width) 
        self.current.height = self.item.height * (love.graphics.getHeight()/self.height)
    else
        self.current.width  = self.item.width
        self.current.height = self.item.height
    end
end