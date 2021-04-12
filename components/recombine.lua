Recombine = Object:extend()

function Recombine:recombineTable(target, source)
    if source then
        for k,v in pairs(target) do
            if source[k] ~= nil then
                target[k] = source[k]
            else
                target[k] = v
            end
        end
    end

    return target
end