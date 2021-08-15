local GameObject = require 'components/game/object'

Graphics = GameObject:extend()

function Graphics:new(config)
    self.width = love.graphics.getWidth()
    self.height = love.graphics.getHeight()
    self.onResize = 'change amount'
    self.printSys = {
        grid = { isOn = true, isDraw = false },
        fps = { isOn = true, isDraw = false }
    }

    self.item = {
        width  = 16,
        height = 16
    }
    
    Graphics.super.new(self, config)

    self.current = {
        width  = 16,
        height = 16
    }
    self:update()

    game.events:on(
        'update', 
        function() 
            self:update()
        end
    )

    game.events:on(
        'keyPressed',
        function(name, event)
            if event.args.key == 'g' and self.printSys.grid.isOn then
                self.printSys.grid.isDraw = not self.printSys.grid.isDraw
            elseif event.args.key == 'f' and self.printSys.fps.isOn then
                self.printSys.fps.isDraw = not self.printSys.fps.isDraw
            end
        end
    )
end

function Graphics:getItem(row, column)
    return {
        width  = self.current.width,
        height = self.current.height,
        x      = self.current.width  * (column-1),
        y      = self.current.height * (row-1)
    }
end

function Graphics:setScale(object, widthCellAmount, heightCellAmount)
    object.sx = (self.current.width*widthCellAmount) / object.width
    object.sy = (self.current.height*heightCellAmount) / object.height
end

function Graphics:moveTo(object, row, column)
    local c = self:getItem(row, column)
    object.x = c.x
    object.y = c.y
    
    object.gridRow    = row
    object.gridColumn = column
end

function Graphics:put(object, row, column, width, height)
    self:moveTo(object, row, column)
    self:setScale(object, width, height)
    object:reload()
end

function Graphics:forEach(dispatcher)
    local columns, rows = self:getCount()

    local loop = function ()
        for i=1,rows do
            for j=1,columns do
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

function Graphics:getCount()
    local screenWidth  = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    return screenWidth/self.current.width, screenHeight/self.current.height
end

function Graphics:drawGrid()
    self:forEach(
        function(item, i, j)
            love.graphics.rectangle('line', item.x,item.y,item.width,item.height)
            love.graphics.print(i..','..j, item.x, item.y)
            return true
        end
    )
end

function Graphics:drawFps()
    love.graphics.print('[FPS: '..math.floor(60/game.fps/100)..']', 5, 5)
end

function Graphics:drawSys()
    if self.printSys.grid.isOn and self.printSys.grid.isDraw then
        self:drawGrid()
    end
    
    if self.printSys.fps.isOn and self.printSys.fps.isDraw then
        self:drawFps()
    end
end

return Graphics