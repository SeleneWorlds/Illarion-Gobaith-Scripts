local M = {}

function M.LookAtItem(User, Item)
    local product = assert(tonumber(Item:getData("CraftProduct")), "Missing CraftProduct")
    local step = assert(tonumber(Item:getData("CraftStep")), "Missing CraftStep")
    local steps = assert(tonumber(Item:getData("CraftSteps")), "Missing CraftSteps")
    local percentage = math.floor(step * 100 / steps)
    local name = world:getItemName(product, User:getPlayerLanguage())
    local text = string.format("%s (%d%%)", name, percentage)
    world:itemInform(User, Item, text)
    return { name = text }
end

return M
