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
-- @return void
function Assets:playFx(name)
	if self.fx[name] then
		love.audio.stop(self.fx[name])
		love.audio.play(self.fx[name])
	end
end

-- @param string name alias of an image
-- @return Image|nil image, nil|string error
function Assets:getImage(name)
	if self.images[name] then
		return Image({source = self.images[name]}), nil
	end
	
	return nil, 'Unknown image "' .. name .. '"'
end

function Assets:getMisc(name)
	return self.misc[name]
end

function Assets:getCursor(name)
	return self.cursors[name]
end

function Assets:getMutator(name)
	return self.mutators[name]
end

function Assets:addFx(alias, fx)
	self.fxs[alias] = love.audio.newSource(self.basePath .. 'fxs/'..fx.path, fx.mode)

	if fx.volume then
		self.fxs[alias]:setVolume(fx.volume)
	end
end

function Assets:addImage(alias, path)
	self.images[alias] = love.graphics.newImage(self.basePath ..'images/'.. path)
end

function Assets:addImagePack(alias, pack)
	self.images[alias] = {}

	for elAlias, path in pairs(pack) do
		self.images[alias][elAlias] = love.graphics.newImage(self.basePath ..'images/'.. alias .. '/' .. path)

	end
end

function Assets:addQuads(alias, path, columnsCount, rowsCount)
	self:addImage(alias, path)

	self.quads[alias] = {}

	local imageWidth = self.images[alias]:getWidth()
	local imageHeight = self.images[alias]:getHeight()

	local qWidth = (imageWidth / columnsCount) - 2
	local qHeight = (imageHeight / rowsCount) - 2

	for i=0,rowsCount do
		for j=0,columnsCount do
			table.insert(self.quads[alias], love.graphics.newQuad(1 + j * (qWidth + 4), 1 + i * (qHeight + 2), qWidth, qHeight, imageWidth, imageHeight))
		end
	end

	self.misc[alias] = {
		width = qWidth,
		height = qHeight
	}
end

function Assets:addCursor(alias, name)
	self.cursors[alias] = love.mouse.getSystemCursor(name)
end

function Assets:addMutator(alias, path)
	local mutator = require(path)
	self.mutators[alias] = mutator()
end

function Assets:addMisc(alias, misc)
	self.misc[alias] = misc
end