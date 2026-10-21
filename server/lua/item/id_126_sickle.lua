local parent = require("item.general.metal")
local common = require("base.common")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local yields = Rolls:new()
yields:registerType("item", items.item)
yields:registerType("nothing", items.nothing)

yields:registerCondition("chance", function(condition) return math.random() < condition.data end)
yields:registerCondition("seasonal_chance", function(condition, context)
    return math.random(20) <= condition.data[context.season]
end)

local function findHarvest(target, ground)
    for _, harvest in pairs(Registries.findAll("illarion:herb_harvests")) do
        if harvest:getField("item") == target.id
            and (harvest:getField("ground") == 0 or harvest:getField("ground") == ground) then
            return harvest
        end
    end
end

local M = {}

function M.UseItem(User, SourceItem, TargetItem, Counter, Param, ltstate)
    common.ResetInterruption(User, ltstate)
    if ltstate == Action.abort then
        local germanPronoun = User:increaseAttrib("sex", 0) == 0 and "seine" or "ihre"
        local englishPronoun = User:increaseAttrib("sex", 0) == 0 and "his" or "her"
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me unterbricht " .. germanPronoun .. " Arbeit.")
        User:talkLanguage(CCharacter.say, CPlayer.english, "#me interrupts " .. englishPronoun .. " work.")
        return
    end
    if not common.CheckItem(User, SourceItem) then return end
    if not common.AutoEquipTool(User, SourceItem) then
        return
    end
    if common.Encumbrence(User) or not common.FitForWork(User) then return end

    -- Resolve the plant again on each action callback so harvested crops cannot
    -- be gathered twice from a stale target supplied by the action system.
    local target = common.GetFrontItem(User)

    local ground = target and common.GetGroundType(world:getField(target.pos):tile())
    local harvest = target and findHarvest(target, ground)
    if not harvest then
        common.InformNLS(User, "Hier kannst du nichts sammeln.", "You can't gather anything here.")
        return
    end

    local skill = User:getSkill("herb lore")
    local gem1, strength1, gem2, strength2 = common.GetBonusFromTool(SourceItem)
    if gem1 == 3 then skill = skill + strength1 end
    if gem2 == 3 then skill = skill + strength2 end
    if skill < (harvest:getField("minimumSkill") or 0) then
        common.InformNLS(User, "Deine Kräuterkunde reicht dafür nicht aus.", "Your knowledge of herbs is insufficient to gather this plant.")
        return
    end

    if ltstate == Action.none then
        User:startAction(math.max(1, work.time(User, "herbgathering", SourceItem)), 0, 0, 0, 0)
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me beginnt nach Kräutern zu suchen.")
        User:talkLanguage(CCharacter.say, CPlayer.english, "#me starts to search for herbs.")
        return
    end
    if ltstate ~= Action.success then return end
    if common.ToolBreaks(User, SourceItem) then
        common.InformNLS(User, "Deine Sichel zerbricht.", "Your sickle breaks.")
        return
    end

    local month = world:getTime("month")
    if month == 0 then month = 16 end
    local season = math.max(1, math.min(4, math.ceil(month / 4)))
    if not work.check(User, "herbgathering") then return end
    local output = { user = User, season = season }
    yields:roll(harvest:getField("yield"), output)
    User:learn(2, "herb lore", output.produced and 2 or 1, 100)
    if output.produced then
        if harvest:getField("consumePlant") then world:erase(target, 1) end
        User.movepoints = User.movepoints - 4
    else
        common.InformNLS(User, "Du findest nichts Brauchbares.", "You find nothing useful.")
    end
    if not harvest:getField("consumePlant") then
        User:startAction(math.max(1, work.time(User, "herbgathering", SourceItem)), 0, 0, 0, 0)
    end
end

if M.UseItem == nil then M.UseItem = parent.UseItem end
if M.UseItemWithField == nil then M.UseItemWithField = parent.UseItemWithField end
if M.UseItemWithCharacter == nil then M.UseItemWithCharacter = parent.UseItemWithCharacter end
if M.LookAtItem == nil then M.LookAtItem = parent.LookAtItem end
if M.LookAtPaintingItem == nil then M.LookAtPaintingItem = parent.LookAtPaintingItem end
if M.MoveItemBeforeMove == nil then M.MoveItemBeforeMove = parent.MoveItemBeforeMove end
if M.MoveItemAfterMove == nil then M.MoveItemAfterMove = parent.MoveItemAfterMove end
if M.CharacterOnField == nil then M.CharacterOnField = parent.CharacterOnField end
if M.ItemRotsOnField == nil then M.ItemRotsOnField = parent.ItemRotsOnField end

return M
