require "components/render/screens/battle/scenes/fight_before/view_background"
require "components/render/screens/battle/scenes/fight_before/view_settings_mode"

SceneFightBefore = Scene:extend()

function SceneFightBefore:new(config)
    SceneFightBefore.super.new(self, config)

    self.name = 'fight_before'
    self.views = {
        BattleFightBeforeViewSettingsMode()
    }
    
    self.grid = Grid({
        width   = love.graphics.getWidth(),
        height  = love.graphics.getHeight(),
        columns = 1,
        rows    = 4,
        itemScale = 'fixed',
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

    
    self.grid:addCollection({
        Empty({height = 100}),
        game.assets:getButton('pl1'),
        game.assets:getButton('pl2'),
        Empty({height = 100})
    })
end

function SceneFightBefore:init(screen)
    screen:addViewLayers(
        { BattleFightBeforeViewBackground( {image = 'board_background'} ) },
        'scene_before'
    )
end

function SceneFightBefore:mouseMoved(screen, x, y, dx, dy, isTouch)

    self.grid:forEach(function(btn, index)
        if btn:isMouseOn(x, y) then
            if btn.state == 'default' then
                btn:hover()
                return false
            end
        else
            if btn.state ~= 'default' then
                btn:released()
            end
        end
        return true
    end, Button)
end

function SceneFightBefore:mousePressed(screen, x, y, button, isTouch, presses)

    local pl1 = game.assets:getButton('pl1')
    local pl2 = game.assets:getButton('pl2')
    local data = screen:getData()
    local modeIsChosen = false

    if pl1:isMouseOn(x, y) then
        pl1:click()
        data.mode = 1
        modeIsChosen = true
        self:prepare1Player(data)
        data.mode = 'vs PC'
    elseif pl2:isMouseOn(x, y) then
        pl2:click()
        data.mode = 2
        modeIsChosen = true
        self:prepare2Players(data)
        data.mode = 'vs Player'
    end

    if modeIsChosen then
        game.assets:getCursor('hand'):reset()
        screen:changeSceneTo('fight_cards')
    end
end

function  SceneFightBefore:prepare1Player(layerData)
    layerData.players[1] = Player({
        name = game.profile.name,
        isHuman = true,
        magic = game.profile.magic,
        number = 1,
        health = game.profile.health,
        attack = game.profile.attack,
        defense = game.profile.defense
    })

    layerData.players[2] = Player({
        name = 'Computer',
        isHuman = false,
        magic = game.profile.magic,
        number = 2,
        health = game.profile.health,
        attack = game.profile.attack,
        defense = game.profile.defense
    })
end

function  SceneFightBefore:prepare2Players(layerData)
    layerData.players[1] = Player({
        name = game.profile.name,
        isHuman = true,
        magic = game.profile.magic,
        number = 1,
        health = game.profile.health,
        attack = game.profile.attack,
        defense = game.profile.defense
    })

    layerData.players[2] = Player({
        name = game.profile.name .. ' (2)',
        isHuman = true,
        magic = game.profile.magic,
        number = 2,
        health = game.profile.health,
        attack = game.profile.attack,
        defense = game.profile.defense
    })
end

function SceneFightBefore:mouseReleased(screen, x, y, button, isTouch, presses)

    local pl1 = game.assets:getButton('pl1')
    local pl2 = game.assets:getButton('pl2')

    if pl1:isMouseOn(x, y) and pl1.pressed == true then
        pl1:released()
    elseif pl2:isMouseOn(x, y) and pl2.pressed == true then
        pl2:released()
    end
end

function SceneFightBefore:update(screen)

end