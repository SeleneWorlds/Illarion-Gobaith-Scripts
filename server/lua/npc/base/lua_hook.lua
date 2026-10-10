-- Shared invocation for .npc Lua conditions and consequences.
local Hook = {}
local unpackValues = table.unpack or unpack

function Hook.resolve(moduleName, functionName)
    local module = require(moduleName)
    local callback = type(module) == 'table' and module[functionName]
    assert(type(callback) == 'function', 'Lua NPC hook ' .. moduleName .. '.' .. functionName .. ' is not a function')
    return callback
end

function Hook.invoke(callback, parameters, dialogue, npc, player, texttype, text)
    local root = dialogue._parent
    root._luaHookState = root._luaHookState or {}
    local context = {
        npc=npc, player=player, root=root, dialogue=dialogue,
        text=text, texttype=texttype, number=dialogue._saidNumber,
        state=root._luaHookState,
    }
    local values = {}
    for index=1,#parameters do
        local value = parameters[index]
        if type(value) == 'function' then value = value(context.number)
        elseif value == '%NUMBER' then value = context.number end
        values[index] = value
    end
    return callback(context, unpackValues(values, 1, #parameters))
end

return Hook
