local M = {}

-- UPDATE common SET com_script='item.id_97_leatherbag' WHERE com_itemid=97;

function M.LookAtItem(User, Item)
    local txt;
    if User:getPlayerLanguage() == 0 then
        txt = "Ledertasche";
    else
        txt = "leather bag";
    end;

    local lbl = Item:getData("Label");
    if type(lbl) == "string" and lbl ~= "" then
        txt = txt.." ("..lbl..")";
    end;
    world:itemInform(User, Item, txt);
end

function M.UseItem(User, Item, TargetItem, Counter, Param)
    if (Item:getType() == 3) or (Item:getType() == 4) then
        local txt = User.lastSpokenText;
        if txt == "!bag" then
            Item:setData("Label", nil);
            world:changeItem(Item);
            if User:getPlayerLanguage() == 0 then
                User:inform("Du entfernst die Beschriftung von der Ledertasche.");
            else
                User:inform("You remove the label from the leather bag.");
            end;
        else
            local n = string.len(txt);
            if (string.sub(txt, 1, 5) == "!bag ") and (n >= 6) then
                local lbl = string.lower(string.sub(txt, 6, math.min(n, 15)));
                local isCorrect = true;
                n = string.len(lbl);
                for i = 1, n do
                    local c = string.sub(lbl, i, i);
                    isCorrect = isCorrect and (c >= "a") and (c <= "z");
                end;
                if isCorrect then
                    Item:setData("Label", lbl);
                    world:changeItem(Item);
                    if User:getPlayerLanguage() == 0 then
                        User:inform("Du beschriftest die Ledertasche mit "..lbl..".");
                    else
                        User:inform("You label the leather bag with "..lbl..".");
                    end;
                end;
            end;
        end;
    end;
end

return M
