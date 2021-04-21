require "components/render/screens/landscape/scenes/main/view_map"
--require "components/render/screens/landscape/scenes/main/view_cities"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        LandscapeMainViewMap()
    }
    self.label = {}
end

function SceneMain:init(screen)

end

function SceneMain:mouseMoved(screen, x, y, dx, dy, isTouch)
    local map = game.assets:getMap('main')

    map:forEach('characters', function (char)
        if (char.number > 0) and char:isMouseOn(x, y) then
            if char.number ~= 46 then
                char:changeNumberTo(46)
            end
            game.assets:getCursor('hand'):setOn()
            return false
        else
            char:restoreNumber()
            game.assets:getCursor('hand'):reset()
            return true
        end
    end)

    if map:isMouseOnObject(x, y, 'farm') then
        self.label = TextOverlay({
            body = 'This is a farm',
            x = x+5,
            y = y+5,
            overlay_mode = 'fill',
            overlay_color = {0,0,0,0.3},
            overlay_offset = 5,
            sx = 2,
            sy = 2
        })
    else
        self.label = {}
    end
end

function SceneMain:mousePressed(screen, x, y, button, isTouch, presses)


end

function SceneMain:mouseReleased(screen, x, y, button, isTouch, presses)


end

function SceneMain:update(screen)

end