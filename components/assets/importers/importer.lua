AssetImporter = GameObject:extend()

-- @param table config
-- @return void
function AssetImporter:new(config)
    self.fxs = {}
    self.images = {}
    self.imagesPacks = {}
    self.quads = {}
    self.misc = {}
    self.cursors = {}
    self.mutators = {}
    self.buttons = {}

    AssetImporter.super.new(self, config)
end

-- @param Assets assetsManager
-- @return void
function AssetImporter:importAssets(assetsManager)
    for alias, fx in pairs(self.fxs) do
        assetsManager:addFx(alias, fx)
    end

    for alias, image in pairs(self.images) do
        assetsManager:addImage(alias, image)
    end

    for alias, pack in pairs(self.imagesPacks) do
        assetsManager:addImagePack(alias, pack)
    end

    for alias, config in pairs(self.quads) do
        assetsManager:addQuads(alias, config.path, config.columns, config.rows)
    end

    for alias, misc in pairs(self.misc) do
        assetsManager:addMisc(alias, misc)
    end

    for alias, cursor in pairs(self.cursors) do
        assetsManager:addCursor(alias, cursor)
    end

    for alias, button in pairs(self.buttons) do
        assetsManager:addButton(alias, button)
    end

    for alias, path in pairs(self.mutators) do
        assetsManager:addMutator(alias, path)
    end
end
