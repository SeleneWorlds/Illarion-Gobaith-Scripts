local M = {}

-- UPDATE common SET com_script='item.id_272_statue' WHERE com_itemid=272;

function M.UseItem( User, Item, TargetItem, counter, param )
    lang=User:getPlayerLanguage();
    if equapos(Item.pos,position(-389,-218,2)) then
        if ((User:increaseAttrib("essence",0)+User:increaseAttrib("willpower",0)+User:increaseAttrib("intelligence",0))>29) then
            User:warp(position(102,56,52));
            if lang==0 then
                User:inform("Als du die Statue berührst verschwimmt die Welt um dich und dir wird schwummrig. Als du wieder klar siehst, bist du an einem völlig anderen Ort");
            else
                User:inform("You touch the statue and the world around you becomes blurred and you feel a little strange. A moment later you can see clearly again, and you are in a completely different place");
            end
        end
    elseif equapos(Item.pos,position(102,55,52)) then
        User:warp(position(-389,-217,2));
        if lang==0 then
            User:inform("Als du die Statue berührst verschwimmt die Welt um dich und dir wird schwummrig. Als du wieder klar siehst, bist du an einem völlig anderen Ort");
        else
            User:inform("You touch the statue and the world around you becomes blurred and you feel a little strange. A moment later you can see clearly again, and you are in a completely different place");
        end
    elseif equapos(Item.pos,position(-60,-229,0)) then
        for i=-69,-61 do
            posi = position(i,-227,0);
            item = world:createItemFromId(3097,1,posi,true,333,0);
            item.wear = 2;
            world:changeItem(item);
            if world:isCharacterOnField(posi) then
                item = world:createItemFromId(3101,1,posi,true,333,0);
                item.wear = 3;
                world:changeItem(item);
                Char = world:getCharacterOnField(posi);
                Char:increaseAttrib("hitpoints",-3000);
                Char:warp(i,-226,0);
            end
        end
    end            
end

return M
