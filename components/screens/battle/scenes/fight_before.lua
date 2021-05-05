local BattleFightBeforeViewBackground   = require "components/screens/battle/scenes/fight_before/view_background"
local BattleFightBeforeViewSettingsMode = require "components/screens/battle/scenes/fight_before/view_settings_mode"

SceneFightBefore = Scene:extend()

function SceneFightBefore:new(config)
    SceneFightBefore.super.new(self, config)

    self.name = 'fight_before'
    self.views = {
        BattleFightBeforeViewSettingsMode()
    }

    self.vsPCBtn     = game.assets:getButton('pl1')
    self.vsPlayerBtn = game.assets:getButton('pl2')
    self.header      = Text({ body = 'Choose mode' })
end

function SceneFightBefore:init(screen)
    screen:addViewLayers(
        { BattleFightBeforeViewBackground( {image = 'board_background'} ) },
        'scene_before'
    )
    self:updateUI()
end

function SceneFightBefore:mouseMoved(screen, x, y, dx, dy, isTouch)

    if self.vsPCBtn:isMouseOn(x, y) then
        self.vsPCBtn:hover()
    elseif self.vsPCBtn.state ~= 'default' then
        self.vsPCBtn:released()
    end

    if self.vsPlayerBtn:isMouseOn(x, y) then
        self.vsPlayerBtn:hover()
    elseif self.vsPlayerBtn.state ~= 'default' then
        self.vsPlayerBtn:released()
    end
end

function SceneFightBefore:mousePressed(screen, x, y, button, isTouch, presses)

    local data = screen:getData()
    local modeIsChosen = false

    if self.vsPCBtn:isMouseOn(x, y) then
        self.vsPCBtn:click()
        data.mode = 1
        modeIsChosen = true
        self:prepare1Player(data)
        data.mode = 'vs PC'
    elseif self.vsPlayerBtn:isMouseOn(x, y) then
        self.vsPlayerBtn:click()
        data.mode = 2
        modeIsChosen = true
        self:prepare2Players(data)
        data.mode = 'vs Player'
    end

    if modeIsChosen then
        game.assets:getCursor('hand'):reset()

        screen:changeStateTo('fight_cards')
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

end

function SceneFightBefore:update(screen)
    self:updateUI()
end

function SceneFightBefore:updateUI()
    game.graphics:put(self.vsPCBtn, 9, 11, 6, 2)
    game.graphics:put(self.vsPlayerBtn, 12, 11, 6, 2)
    game.graphics:put(self.header, 6, 10, 8, 2)
end

return SceneFightBefore