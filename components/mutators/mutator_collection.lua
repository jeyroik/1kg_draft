MutatorCollection = Object:extend()
MutatorCollection.mutators = {}

function MutatorCollection:new()
end

function MutatorCollection:registerMutator(name, mutator)
    MutatorCollection.mutators[name] = mutator
end

function MutatorCollection:hasMutator(name)
    return MutatorCollection.mutators[name] and true or false
end

function MutatorCollection:getMutator(name)
    if MutatorCollection.hasMutator(name) then
        return MutatorCollection.mutators[name], nil
    end

    return nil, 'Unknown mutator "' .. name .. '"'
end