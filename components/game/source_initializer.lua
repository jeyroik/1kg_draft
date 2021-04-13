SourceInitializer = Object:extend()

function SourceInitializer:initializeSource()
    local initializers = {
        image = function ()
                    self.source = love.graphics.newImage(self.path)
                end,
        image_pack = function ()
                        for elAlias, cfg in pairs(self.path) do
                            self.source[elAlias] = Image({
                                path = cfg.path,
                                radian = cfg.radian,
                                sx = cfg.sx,
                                sy = cfg.sy
                            })
                        end
                    end,
        quads = function ()
                    self.image = Image({ path = self.path })
                    local imageWidth = self.image:getWidth()
                    local imageHeight = self.image:getHeight()

                    local qWidth = (imageWidth / self.columns) - 2
                    local qHeight = (imageHeight / self.rows) - 2

                    for i=0,rows do
                        for j=0,columns do
                            table.insert(
                                self.source,
                                love.graphics.newQuad(
                                    1 + j * (qWidth + 4),
                                    1 + i * (qHeight + 2),
                                    qWidth,
                                    qHeight,
                                    imageWidth,
                                    imageHeight
                                )
                            )
                        end
                    end

                    self.width = qWidth
                    self.height = qHeight
                end,
        fx = function()
                self.source = love.audio.newSource(self.path, self.mode)

                if self.volume > 0 then
                    self.source:setVolume(self.volume)
                end
            end,
        cursor = function ()
                    self.source = love.mouse.getSystemCursor(self.path)
                end,
        icon = function ()
                    self.image = Image(self.image)
                end,
        text = function () end
    }

    if initializers[self.source_type] then
        initializers[self.source_type]()
    end
end