require 'components/hooks/magic_select'

SkillMagicChange = Skill:extend()

function SkillMagicChange:new(config)
    self.toEnemy = false
    self.amount = 0
    self.magicParameter = ''
    self.magicName = ''

    SkillMagicChange.super.new(self, config)

    self.name = 'skill_magic_change'
    self.description = 'Change selected stone magic '..self.magicParameter..' by '..self.amount
    self.mutators = {
        magic_change = {
            toEnemy = self.toEnemy,
            amount = self.amount,
            magicParameter = self.magicParameter,
            magicName = self.magicName
        }
    }
end

function SkillMagicChange:use(layerData)
    local screen = game:getCurrentScreen()
    local hook = HookMagicSelect()
    layerData.magic_select_skill = self
    screen:freezeEvent('keyPressed')
    screen:catchEvent('mousePressed', 'before', hook)
    screen:catchEvent('mouseMoved', 'before', hook)
    screen:catchEvent('render', 'before', hook)
end

function SkillMagicChange:magicSelected(layerData, magic)
    self.magicName = magic:getName()
    self.mutators.magic_change.magicName = self.magicName

    local hook = HookMagicSelect()

    screen:releaseEvent('mousePressed', 'before', hook:getAlias())
    screen:releaseEvent('mouseMoved', 'before', hook:getAlias())
    screen:releaseEvent('render', 'before', hook:getAlias())
    screen:unfreezeEvent('keyPressed')

    SkillMagicChange.super.use(layerData)
    layerData.magic_select_skill = nil
end