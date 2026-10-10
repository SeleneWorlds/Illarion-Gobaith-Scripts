local class = require('base.class').class
local consequence = require('npc.base.consequence.consequence')
local Hook = require('npc.base.lua_hook')

return class(consequence, function(self, moduleName, functionName, parameters)
    consequence:init(self)
    local callback = Hook.resolve(moduleName, functionName)
    self.perform = function(instance, npc, player, texttype, text)
        Hook.invoke(callback, parameters, instance.npc, npc, player, texttype, text)
    end
end)
