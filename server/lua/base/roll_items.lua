local common = require("base.common")
local M = {}

-- Callbacks for consumers of moonlight-rolls. Roll execution stays with the consumer.
function M.nothing() end

function M.item(entry, context)
    local data, user = entry.data, context.user
    local quality = data.qualityMin and math.random(data.qualityMin, data.qualityMax) or data.quality
    local durability = data.durabilityMin and math.random(data.durabilityMin, data.durabilityMax) or data.durability or 99
    if data.message then common.InformNLS(user, data.message.de, data.message.en) end
    local remaining = user:createItem(data.id, data.quantity, quality, data.data, durability)
    context.produced = true
    context.quality = quality
    context.durability = durability
    if remaining > 0 then
        world:createItemFromId(data.id, remaining, user.pos, true, quality, data.data, durability)
        common.InformNLS(user, "Du kannst nichts mehr halten!", "You can't carry anymore!")
        context.overflow = true
    end
end

return M
