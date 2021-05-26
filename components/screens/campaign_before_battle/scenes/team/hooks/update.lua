local Hook = require 'components/hooks/hook'

Update = Hook:extend()


function Update:new(config)

    Update.super.new(self, config)

    self.alias = 'campaign_before_battle.team.update'
end

function Update:catch(screen, args, event, stage)
    if event == 'changeSceneTo' and stage == 'after' and args.sceneName == 'team' then
        self:updateScene(args.scene)
    end
end

function Update:updateScene(scene)
    scene:updateUI()
end

return Update