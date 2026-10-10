local parent = require("item.general.metal")
local common = require("base.common")
local gathering = require("content.gathering")
local harvests = require("content.herb_harvests")
local M = {}

local function findHarvest(target)
    local ground = common.GetGroundType(world:getField(target.pos):tile())
    for _, harvest in ipairs(harvests[target.id] or {}) do
        if harvest.ground == 0 or harvest.ground == ground then
            return harvest
        end
    end
end

function M.UseItem(User, SourceItem, TargetItem, Counter, Param, ltstate)
    common.ResetInterruption(User, ltstate)
    if ltstate == Action.abort then return end
    if ltstate == Action.success and common.IsInterrupted(User) then
        common.InformNLS(User, "Du unterbrichst die Suche nach Kräutern.", "You interrupt your search for herbs.")
        return
    end
    if not common.CheckItem(User, SourceItem) then return end
    if SourceItem:getType() ~= 4 then
        common.InformNLS(User, "Du musst die Sichel in der Hand halten.", "You have to hold the sickle in your hand.")
        return
    end
    if common.Encumbrence(User) or not common.FitForWork(User) then return end

    -- Resolve the plant again on each action callback so harvested crops cannot
    -- be gathered twice from a stale target supplied by the action system.
    local target = common.GetFrontItem(User)
    local harvest = target and findHarvest(target)
    if not harvest then
        common.InformNLS(User, "Hier kannst du nichts sammeln.", "You can't gather anything here.")
        return
    end

    local skill = User:getSkill("herb lore")
    local gem1, strength1, gem2, strength2 = common.GetBonusFromTool(SourceItem)
    if gem1 == 3 then skill = skill + strength1 end
    if gem2 == 3 then skill = skill + strength2 end
    if skill < harvest.skill then
        common.InformNLS(User, "Deine Kräuterkunde reicht dafür nicht aus.", "Your knowledge of herbs is insufficient to gather this plant.")
        return
    end

    gathering.InitGathering()
    if ltstate == Action.none then
        User:startAction(math.max(1, gathering.herbgathering:GenWorkTime(User, SourceItem)), 0, 0, 0, 0)
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
    local success = harvest.consume and (harvest.skill == 0 or math.random(100) < 80)
        or (not harvest.consume and math.random(20) <= harvest.seasons[season])
    if success then
        local remaining = User:createItem(harvest.product, 1, 333, harvest.data)
        if remaining > 0 then
            world:createItemFromId(harvest.product, remaining, User.pos, true, 333, harvest.data)
            common.InformNLS(User, "Du kannst nichts mehr tragen.", "You can't carry any more.")
        end
        if harvest.consume then world:erase(target, 1) end
        User.movepoints = User.movepoints - 4
        User:learn(2, "herb lore", 2, harvest.skill > 0 and 100 or 5)
        if harvest.skill > 0 then common.GetHungry(User, 200) end
    else
        common.InformNLS(User, "Du findest nichts Brauchbares.", "You find nothing useful.")
    end
    if not harvest.consume then
        User:startAction(math.max(1, gathering.herbgathering:GenWorkTime(User, SourceItem)), 0, 0, 0, 0)
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
