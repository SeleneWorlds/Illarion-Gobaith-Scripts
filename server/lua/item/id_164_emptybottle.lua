local M = {}

-- Schaf melken
-- Nop

-- UPDATE common SET com_script='item.id_164_emptybottle' WHERE com_itemid IN (164);

function M.UseItemWithCharacter(User,SourceItem,Character,Counter,Param)
    --User:inform("char selected");
    -- target is a sheep
    if( Character:get_race() == 18 ) then
       -- User:inform("sheep selected");
        -- empty bottle in hand
        if ((User:getItemAt(6).id == 164)or(User:getItemAt(5).id == 164)) then
            --User:inform("milking");
            -- replace by bottle with sheep milk
            world:erase(SourceItem,1)
            User:createItem(330,1,333,0)
        end
    end
end

return M
