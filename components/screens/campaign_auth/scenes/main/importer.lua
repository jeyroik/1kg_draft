CampaignAuthMainImporter = AssetImporter:extend()

function CampaignAuthMainImporter:new()
    CampaignAuthMainImporter.super.new(self)

    self.images = {
        inputField = { path = "notice.png" },
        submitBtn = { path = "menu_btn.png"}
    }

    self.buttons = {
        submit = {
            path = {
                default = 'menu_btn.png',
                clicked = 'menu_btn_pressed.png'
            },
            text = 'submit',
            text_scale = 0.4,
            border = 15,
            effect = 'frame',
            color = {0, 0.5, 0}
        },
    }
end

return CampaignAuthMainImporter