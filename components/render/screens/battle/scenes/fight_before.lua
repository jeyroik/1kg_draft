require "components/render/screens/battle/scenes/fight_before/view_background"
require "components/render/screens/battle/scenes/fight_before/view_settings_mode"

SceneFightBefore = Scene:extend()

function SceneFightBefore:new(config)
    SceneFightBefore.super.new(self, config)

    self.name = 'fight_before'
    self.views = {
        BattleFightBeforeViewSettingsMode()
    }
end

function SceneFightBefore:init(screen)
    --screen:addViewLayers(
      --  { BattleFightBeforeViewBackground( {image = 'board_background'} ) },
        --'scene_before'
    --)

    game.assets:getButton('pl1'):setToCenter(true)
    game.assets:getButton('pl1'):stepByY(50)

    game.assets:getButton('pl2'):setToCenter(true)
    game.assets:getButton('pl2'):stepByY(50)
    game.assets:getButton('pl2'):stepByY(20)
end

function SceneFightBefore:mouseMoved(screen, x, y, dx, dy, isTouch)

    local pl1 = game.assets:getButton('pl1')
    local pl2 = game.assets:getButton('pl2')

    if pl1:isMouseOn(x, y) then
        if pl1.state == 'default' then
            pl1:hover()
        end
    elseif pl2:isMouseOn(x, y) then
        if pl2.state == 'default' then
            pl2:hover()
        end
    else
        if pl1.state ~= 'default' then
            pl1:released()
        end

        if pl2.state ~= 'default' then
            pl2:released()
        end

        game.assets:getCursor('hand'):reset()
    end
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

    local current = layerData:getCurrentPlayer()

    current:addCard(CardFireElemental())
    current:addCard(CardTreeElemental())
    current:addCard(CardLifeElemental())
    current:addCard(CardWaterElemental())

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
    local current = layerData:getCurrentPlayer()
    current:addCards({ CardFireElemental(), CardTreeElemental(), CardLifeElemental() })

    layerData.players[2] = Player({
        name = game.profile.name .. ' (2)',
        isHuman = true,
        magic = game.profile.magic,
        number = 2,
        health = game.profile.health,
        attack = game.profile.attack,
        defense = game.profile.defense
    })
    local next = layerData:getNextPlayer()
    next:addCards({ CardFireElemental(), CardTreeElemental(), CardLifeElemental() })
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