local M = {}
local sites = {
    {50,-328,-23,37}, {48,-330,-23,5}, {48,-326,-23,36},
    {46,-328,-23,46}, {48,-328,-23,7}
}

local function effects()
    for _, site in ipairs(sites) do world:gfx(site[4], position(site[1], site[2], site[3])) end
end

function M.LookAtItem(user, item)
    if user:isAdmin() then world:itemInform(user, item, "Ritual") end
end

function M.UseItem(user)
    if not user:isAdmin() then return end
    local text = user.lastSpokenText or ""
    if text:find("Stufe1", 1, true) then effects() end
    if text:find("Stufe2", 1, true) then
        effects()
        for _, site in ipairs(sites) do
            local coordinate = position(site[1], site[2], site[3])
            world:gfx(53, coordinate)
            local mage = world:getCharacterOnField(coordinate)
            if mage then
                mage:createItem(3110, 2, 333, 666)
                mage:eraseItem(3109, 1)
                mage:eraseItem(285, 1)
            end
        end
    end
end

return M
