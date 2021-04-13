Assets = Object:extend()
Assets:implement(Config)
Assets:implement(Printer)
Assets:implement(Initializer)

-- @param string basePath base path for assets
-- @return void
function Assets:new(config)
	self.basePath = 'assets/'
	self.importers = {}
	self.fxs = {}
	self.images = {}
	self.imagesPacks = {}
	self.quads = {}
	self.misc = {}
	self.cursors = {}
	self.mutators = {}

	self:applyConfig(config)
end

-- @return void
function Assets:init()
	self:initializeMany('importers')
	for _, importer in pairs(self.importers) do
		importer:importAssets(self)
	end
end

-- @param string name alias of a fx
-- @return Fx|nil
function Assets:getFx(name)
	return self.fxs[name]
end

-- @param string name alias of an image
-- @return Image|nil
function Assets:getImage(name)
	return self.images[name]
end

-- @param string name alias of an image
-- @return Image|nil
function Assets:getImagePack(name)
	return self.imagesPacks[name]
end

-- @param string name
-- @return Quads
function Assets:getQuads(name)
	return self.quads[name]
end

-- @param string name
-- @return mixed|nil
function Assets:getMisc(name)
	return self.misc[name]
end

-- @param string name
-- @return Cursor|nil
function Assets:getCursor(name)
	return self.cursors[name]
end

-- @param string name
-- @return Mutator|nil
function Assets:getMutator(name)
	return self.mutators[name]
end

-- @param string alias
-- @param table fx
function Assets:addFx(alias, fx)
	fx.path = self.basePath .. 'fxs/' .. fx.path

	self.fxs[alias] = Fx(fx)
end

function Assets:addImage(alias, image)
	image.path = self.basePath .. 'images/' .. image.path
	self.images[alias] = Image(image)
end

function Assets:addImagePack(alias, paths)
	for _, image in pairs(paths) do
		image.path = self.basePath .. 'images/' .. alias .. '/' .. image.path
	end
	self.imagesPacks[alias] = ImagePack({ path = paths })
end

function Assets:addQuads(alias, path, columnsCount, rowsCount)
	self.quads[alias] = Quads({ path = self.basePath .. 'images/' .. path, columns = columnsCount, rows = rowsCount })
end

function Assets:addCursor(alias, name)
	self.cursors[alias] = Cursor({ path = name })
end

function Assets:addMutator(alias, path)
	local mutator = require(path)
	self.mutators[alias] = mutator()
end

function Assets:addMisc(alias, misc)
	self.misc[alias] = misc
end

return Assets