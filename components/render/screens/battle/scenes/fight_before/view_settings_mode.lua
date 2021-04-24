BattleFightBeforeViewSettingsMode = LayerView:extend()

function BattleFightBeforeViewSettingsMode:new(config)
    BattleFightBeforeViewSettingsMode.super.new(self, config)

    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleFightBeforeViewSettingsMode:render(data, scene)
    --local dx = 0+
    local title = Text({ body = 'Choose mode', sx = 2*VisibleObject.globalScale, sy = 2*VisibleObject.globalScale })
    local titleGrid = Grid({
        width   = love.graphics.getWidth(),
        height  = love.graphics.getHeight(),
        columns = 1,
        rows    = 5,
        itemScale = 'auto',
		margin = {
			top = 50,
			left = love.graphics.getWidth()/4,
			right = love.graphics.getWidth()/5,
			bottom = 10
		},
        padding = {
            top    = 100  * VisibleObject.globalScale,
            bottom = 50  * VisibleObject.globalScale,
            left   = 100 * VisibleObject.globalScale,
            right  = 100 * VisibleObject.globalScale
        }
    })
    titleGrid:addCollection({ title})
    titleGrid:setToCenter(true)
    titleGrid:render()

    scene.grid:setToCenter(true, true)
    scene.grid:render()
end