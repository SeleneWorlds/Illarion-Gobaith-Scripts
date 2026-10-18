local common = require("base.common")
local M = {}

-- Callbacks for consumers of moonlight-rolls. Roll execution stays with the consumer.
function M.nothing() end

function M.item(entry, context)
    local data, user = entry.data, context.user
    local quality = data.qualityMin and math.random(data.qualityMin, data.qualityMax) or data.quality
    if data.message then common.InformNLS(user, data.message.de, data.message.en) end
    local remaining = user:createItem(data.id, data.quantity, quality, data.data)
    context.produced = true
    context.quality = quality
    if remaining > 0 then
        world:createItemFromId(data.id, remaining, user.pos, true, quality, data.data)
        common.InformNLS(user, "Du kannst nichts mehr halten!", "You can't carry anymore!")
        context.overflow = true
    end
end

return M
