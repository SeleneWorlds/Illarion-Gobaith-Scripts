require('npc.runtime').start()

local Events = require("illarion-script-loader.server.lua.lib.events")
local areas = require("base.areas")
Events.onUseItem:connect(function(context)
    areas.emit("use_item", context)
end)

Events.onLookAtItem:connect(function(context)
    areas.emit("look_at_item", context)
end)
