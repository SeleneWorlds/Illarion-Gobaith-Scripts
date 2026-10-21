local M = {}

-- empty container with drink
local common = require("base.common")

local Registries = require("selene.registries")

local function findDrink(id)
    local item = Registries.findByMetadata("illarion:items", "id", id)
    return item and item:getField("drink")
end

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    if User.attackmode then
        common.InformNLS( User, "Du würdest alles verschütten.", "You'd spill everything.");
        return -- Abbrechen wenn Spieler im Kampf ist
    end
    local food = findDrink(SourceItem.id);
    if (food == nil ) then
        User:inform("Unknown drinking Item: ID"..SourceItem.id.." Please Report this to a developer.");
        return
    end
    foodLevel = User:increaseAttrib("foodlevel",0) + food.value; -- Foodlevel anheben
    world:makeSound(12,User.pos); -- Trink geräusch machen
    if ( math.random( 50 ) <= 1 ) then -- 1/50 das die Flasche zerbricht
        world:erase(SourceItem,1);
        common.InformNLS( User, "Das alte Geschirr ist nicht mehr brauchbar.", "The old dishes are no longer usable.");
    else
        local leftover = assert(Registries.findByName("illarion:items", food.leftover));
        world:swap( SourceItem,leftover:getMetadata("id"),333);
    end
    if ( food.alcohol == 0 ) then -- dein Alkohol
        if ( foodLevel > 40000 ) then 
            common.InformNLS( User, "Du hast genug getrunken.", "You have drunk enough.");
        elseif ( foodLevel > 40000 ) then 
            common.InformNLS( User, "Du schaffst es nicht noch mehr zu trinken.", "You don't manage it to drink more.");
            foodLevel = foodLevel - food.value;
        end
    else -- Alkohol
        -- Abhandlung Foodlevel
        if ( foodLevel > 40000 ) then 
            common.InformNLS( User, "Du hast genug getrunken.", "You have drunk enough.");
        elseif ( foodLevel > 40000 ) then 
            common.InformNLS( User, "Du schaffst es nicht noch mehr zu trinken.", "You don't manage it to drink more.");
            foodLevel = foodLevel - food.value;
        end
        -- Abhandlung Foodlevel fertig
        
        -- Alkohol Effekt
        -- Arbeitet mit LTE ID 1 - "alcohol"
        foundalc,alcEffect = User.effects:find(1); -- LTE 1 "alcohol" suchen
        if not foundalc then -- Spieler hat den Effekt nicht
            oldAlcValue = 0; -- daher auch keinen alten Alkohol wert
        else -- Spieler hat den Effekt
            found,value = alcEffect:findValue("alcohol"); -- alten Alkohol wert suchen
            oldAlcValue = ( found and value or 0 ); -- und uebertragen
            User.effects:removeEffect(1); -- alten Effekt entfernen
        end
        alcEffect = CLongTimeEffect( 1, 300 ); -- Effekt Struktur erstellen
        alcEffect:addValue("alcohol",oldAlcValue + math.floor(food.value*(food.alcohol/100))); -- neuen Alkohol Wert hinzufuegen
        User.effects:addEffect(alcEffect); -- Effekt an User senden
        -- Alkohol Abhandlung fertig
    end
    if ( User:increaseAttrib("foodlevel",0) ~= foodLevel ) then -- Prüfen ob Nahrungspunkte geändert wurden
        User:increaseAttrib("foodlevel",-(User:increaseAttrib("foodlevel",0)-foodLevel)); -- Änderung durchführen
    end
end


function M.LookAtItem(User,Item)
    local food = findDrink(Item.id);
    if food == nil then
        User:inform("unknown drink item ID"..Item.id);
        return
    end
    world:itemInform(User,Item,world:getItemName(Item.id,User:getPlayerLanguage()));
end

return M
