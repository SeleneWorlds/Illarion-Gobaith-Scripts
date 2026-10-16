local M = {}

-- UPDATE common SET com_script='item.id_272_statue' WHERE com_itemid=272;

function M.UseItem( User, Item, TargetItem, counter, param )
    if equapos(Item.pos,position(-60,-229,0)) then
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
