local M = {}

-- Kohlbewegungsscript

-- UPDATE common SET com_script='item.id_290_cabbage' WHERE com_itemid IN (290);

function M.MoveItemBeforeMove(User, SourceItem, TargetItem)
    if (SourceItem.data > 0) then
        if (User:getPlayerLanguage() == 0) then
            User:inform("Du würdest den Kohl beschädigen, ziehst du ihn einfach so heraus. Du benötigst eine Sichel um ihn abzuschneiden.");
        else
            User:inform("You would damage the cabbage, if you pull it out. You need a sickle to cut it");
        end
        return false
    else
        return true
    end
end

return M
