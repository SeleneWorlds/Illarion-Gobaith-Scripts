local common = require("base.common")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local yields = Rolls:new()
yields:registerType("item", items.item)
yields:registerType("nothing", items.nothing)

local function findHarvest(target, ground)
    for _, harvest in pairs(Registries.findAll("illarion:fruit_harvests")) do
        if harvest:getField("item") == target.id
            and (harvest:getField("ground") == 0 or harvest:getField("ground") == ground) then
            return harvest
        end
    end
end

local M = {}

function M.UseItem(User, SourceItem, TargetItem, Counter, Param, ltstate)
    if ltstate == Action.abort then return end
    SourceItem = world:getItemOnField(SourceItem.pos)
    if not common.IsLookingAt(User, SourceItem.pos) then
        common.TurnTo(User, SourceItem.pos)
    end
    local ground = common.GetGroundType(world:getField(SourceItem.pos):tile())
    local harvest = findHarvest(SourceItem, ground)
    if not harvest then return end
    if ltstate == Action.none then
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me fängt an Früchte zu sammeln", { showInChat = false })
        User:talkLanguage(CCharacter.say, CPlayer.english, "#me starts to collect fruits", { showInChat = false })
        User:startAction(7, 0, 0, 0, 0)
        return
    end
    if not work.check(User, "fruitgathering") then return end

    local month = world:getTime("month")
    if month == 0 then month = 16 end
    local season = math.max(1, math.min(4, math.ceil(month / 4)))
    local output = { user = User }
    yields:roll(harvest:getField("yield"), output)
    if output.produced then
        local onNoobia = User.pos.z == 100 or User.pos.z == 101
        local depleted = harvest:getField("depletedItem")
        local stock = harvest:getField("stock")
        local seasons = harvest:getField("seasons")
        -- The registry defines the depleted source, stock and seasonal regrowth.
        if depleted and depleted > 0 then
            if stock then
                if SourceItem.data == 1 or (seasons[season] == 0 and not onNoobia) then
                    SourceItem.id = depleted
                    SourceItem.quality = output.quality
                    SourceItem.durability = output.durability
                    SourceItem.data = 0
                    SourceItem.wear = onNoobia and 1 or math.floor(-3.6 * seasons[season] + 42)
                elseif SourceItem.data == 0 then
                    SourceItem.data = stock - 2
                else
                    SourceItem.data = SourceItem.data - 1
                end
            else
                SourceItem.id = depleted
                SourceItem.quality = output.quality
                    SourceItem.durability = output.durability
                SourceItem.wear = math.floor(2 * seasons[season] + 22)
            end
            world:changeItem(SourceItem)
        elseif depleted and depleted < 0 then
            world:erase(SourceItem, 1)
        end
    else
        common.InformNLS(User, "Du findest nichts.", "You do not find anything.")
    end
    if SourceItem.data > 0 and not output.overflow then User:startAction(7, 0, 0, 0, 0) end
    User.movepoints = User.movepoints - 4
end

return M
