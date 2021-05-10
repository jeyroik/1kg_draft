local GameObject = require 'components/game/object'

local Fx 		= require 'components/sources/fx'
local Image 	= require 'components/sources/image'
local ImagePack = require 'components/sources/image_pack'
local Quads 	= require 'components/sources/quads'
local Cursor 	= require 'components/sources/cursor'
local Button 	= require 'components/sources/button'
local Map 		= require 'components/sources/map'
local Card 		= require 'components/sources/card'
local Grid 		= require 'components/sources/grid'
local Text 		= require 'components/sources/text'
local Group 	= require 'components/sources/group'

local Character = require 'components/models/character' -- @deprecated

Assets = GameObject:extend()

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
	self.buttons = {}
	self.maps = {}
	self.cards = {}
	self.characters = {}
	self.grids = {}
	self.texts = {}
	self.groups = {}

	Assets.super.new(self, config)
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

function Assets:getMap(name)
	return self.maps[name]
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

-- @param string name
-- @return Button
function Assets:getButton(name)
	return self.buttons[name]
end

-- @param string name
-- @return Card
function Assets:getCard(name)
	return self.cards[name]
end

-- @param string name
-- @return ModelCharacter
function Assets:getCharacter(name)
	return self.characters[name]
end

function Assets:getText(name)
	return self.texts[name]
end

function Assets:getGrid(name)
	return self.grids[name]
end

function Assets:getGroup(name)
	return self.groups[name]
end

function Assets:addGroup(alias, group)
	self.groups[alias] = Group(group)
end

function Assets:addText(alias, text)
	self.texts[alias] = Text(text)
end

function Assets:addGrid(alias, grid)
	self.grids[alias] = Grid(grid)
end

-- @param string alias
-- @param table fx
function Assets:addFx(alias, fx)
	self.fxs[alias] = Fx(fx)
end

function Assets:addImage(alias, image)
	self.images[alias] = Image(image)
end

function Assets:addImagePack(alias, paths)
	self.imagesPacks[alias] = ImagePack({ path = paths , name = alias})
end

function Assets:addQuads(alias, path, columnsCount, rowsCount)
	self.quads[alias] = Quads({ path = path, columns = columnsCount, rows = rowsCount })
end

function Assets:addMap(alias, config)
	self.maps[alias] = Map(config)
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

function Assets:addButton(alias, button)
	self.buttons[alias] = Button(button)
end

function Assets:addCard(alias, path)
	local card = require(path)
	self.cards[alias] = card()
end

function Assets:addCharacter(alias, model)
	self.characters[alias] = ModelCharacter(model)
end

return Assets