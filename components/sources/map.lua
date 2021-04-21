Map = Quads:extend()

function Map:new(config)
    self.layers = {}
    self.renderPath = {}
    self.map = {}
    self.totalWidth = 0
    self.totalHeight = 0

    config.initializer = 'components/sources/initializers/map'
    Map.super.new(self, config)

    self.totalWidth = self.width * self.columns
    self.totalHeight = self.height * self.rows
end

function Map:render(dx, dy, radian, sx, sy)
    dx = dx or 0
    dy = dy or 0
    radian = radian or 0
    sx = sx or self.sx
    sy = sy or self.sy

    for i=1,#self.renderPath do
        local layerName = self.renderPath[i]
        self:forEach(layerName, function(cell)
            Map.super.render(self, cell.number, cell.x+dx, cell.y+dy, radian, sx, sy)
            return true
        end)
    end
end

function Map:forEach(layerName, dispatcher)
    local loop = function ()
        local layer = self.map[layerName]
        for _, columns in pairs(layer) do
            for _, cell in pairs(columns) do
                local continue = dispatcher(cell)
                if not continue then
                    return
                end
            end
        end
    end

    loop()
end