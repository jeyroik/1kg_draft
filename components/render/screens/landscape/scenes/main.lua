require "components/render/screens/landscape/scenes/main/view_map"
--require "components/render/screens/landscape/scenes/main/view_cities"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        LandscapeMainViewMap()
    }
end

function SceneMain:init(screen)

end

function SceneMain:mouseMoved(screen, x, y, dx, dy, isTouch)
    local map = game.assets:getMap('main')

    map:forEach('characters', function (char)
        if (char.number > 0) and char:isMouseOn(x, y) then
            game.assets:getCursor('hand'):setOn()
            return false
        else
            game.assets:getCursor('hand'):reset()
            return true
        end
    end)

end

function SceneMain:mousePressed(screen, x, y, button, isTouch, presses)


end

function SceneMain:mouseReleased(screen, x, y, button, isTouch, presses)


end

function SceneMain:update(screen)

end