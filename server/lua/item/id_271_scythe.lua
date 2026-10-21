local parent = require("item.general.metal")
local M = {}

-- Sense ( 271 )

-- reifes Getreide  --> Getreidebündel

-- UPDATE common SET com_script='item.id_271_scythe' WHERE com_itemid IN (271);

local common = require("base.common")
local general_metal = require("item.general.metal")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local yields = Rolls:new()
yields:registerType("item", items.item)
yields:registerType("nothing", items.nothing)

local function findCrop(id)
    for _, crop in pairs(Registries.findAll("illarion:crop_harvests")) do
        if crop:getField("item") == id then return crop end
    end
end


function M.UseItem( User, SourceItem, TargetItem, Counter, Param )   
    if ((TargetItem == nil) or (TargetItem.id == 0)) then -- Anvisiertes Item Vorhanden
        TargetItem = common.GetFrontItem( User ); -- Wenn nicht Item in Blickrichtung nehmen
    end
    
    local crop = TargetItem and findCrop(TargetItem.id)
    if not crop then return end
    
    if common.Encumbrence(User) then -- Durch Steife Rüstung behindert
        common.InformNLS( User,
        "Deine Rüstung behindert dabei die Feldarbeit zu verrichten.",
        "Your armor disturbes while farming." );
        return
    end
    
    if not common.AutoEquipTool(User, SourceItem) then
        return
    end
    
    if not common.IsLookingAt( User, TargetItem.pos ) then -- Blickrichtung prüfen
        common.TurnTo( User, TargetItem.pos ); -- notfalls drehen
    end
    
	if not work.check(User, "farming") then
		return
	end
	
    if common.ToolBreaks( User, SourceItem, true ) then -- Sense beschädigen
        common.InformNLS( User, 
        "Die rostige Sense zerbricht.", 
        "The rusty scythe breaks." );
        return
    end
    
    local remaining = math.max(1, TargetItem.data)
    for _ = 1, remaining do
        local output = { user = User }
        yields:roll(crop:getField("yield"), output)
    end
    world:erase(TargetItem, 1);
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
