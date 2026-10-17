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

-- Fairy's Tears oder Trolls Blood erhalten (Quellwasser)
-- vilarion
function M.UseItemWithField(User,SourceItem,TargetPos,Counter,Param)
    --User:inform("using bottle on field");
    if ((User:getItemAt(6).id == 164)or(User:getItemAt(5).id == 164)) then
        --User:inform("bottle in hand");
        if (User:getItemAt(6).id == 164) then
            itempos = 6;
        else
            itempos = 5;
        end
        bottles = User:getItemAt(itempos);
        number = bottles.number;
        -- if at trolls vein spring
        if ((TargetPos.x == 49) and (TargetPos.y==-54) and (TargetPos.z==0)) then
            --User:inform("at vein");
           world:erase(SourceItem,number);
           User:createAtPos(itempos, 2496, number);
           bottles = User:getItemAt(itempos);
           bottles.data = 1;
           bottles.number = number;
           world:changeItem(bottles);
        end
        if ((TargetPos.x == 118) and (TargetPos.y==-122) and (TargetPos.z==0)) then
            --User:inform("at tears");
           world:erase(SourceItem,number);
           User:createAtPos(itempos, 2496, number);
           bottles = User:getItemAt(itempos);
           bottles.data = 2;
           bottles.number = number;
           world:changeItem(bottles);
        end
    end
end

return M
