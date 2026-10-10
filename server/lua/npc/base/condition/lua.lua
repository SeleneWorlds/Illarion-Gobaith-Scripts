local class = require('base.class').class
local condition = require('npc.base.condition.condition')
local Hook = require('npc.base.lua_hook')

return class(condition, function(self, moduleName, functionName, parameters)
    condition:init(self)
    local callback = Hook.resolve(moduleName, functionName)
    self.check = function(instance, npc, texttype, player, text)
        local result = Hook.invoke(callback, parameters, instance.npc, npc, player, texttype, text)
        assert(type(result) == 'boolean', 'Lua NPC condition ' .. moduleName .. '.' .. functionName .. ' must return a boolean')
        return result
    end
end)
