local M = {}
local init, generateKey, UseItem, AddToLevers

local common = require("base.common")
local base_lever = require("base.lever")
local deleteitem = require("handler.deleteitem")
local lockdoor = require("handler.lockdoor")
local unlockdoor = require("handler.unlockdoor")
local opendoor = require("handler.opendoor")
local closedoor = require("handler.closedoor")
local createitem = require("handler.createitem")
local createbridge = require("handler.createbridge")
local deletebridge = require("handler.deletebridge")
local settile = require("handler.settile")
local createeffect = require("handler.createeffect")
local createsound = require("handler.createsound")
local sendmessage = require("handler.sendmessage")
local movelever = require("handler.movelever")

-- UPDATE common SET com_script='item.lever' WHERE com_itemid IN (434, 435, 436, 437, 438, 439);

function M.init()
    leverList={};
    myLev1 = base_lever.Lever(position(124,637,0),true);
    myLev2 = base_lever.Lever(position(125,637,0),false);
    myLev1:bind(0,movelever.moveLever(myLev2));
    testlever = base_lever.Lever(position(119,637,0),true);
    testlever2 = base_lever.Lever(position(120,637,0),true);
    --[[for x=117,119 do
        for y=632,636 do
            testlever2:bind(0,deleteItem(position(x,y,0),0));
        end
    end
    for x=117,118 do
        for y=637,639 do
            testlever2:bind(0,deleteItem(position(x,y,0),0));
        end
    end--]]
    --testlever:setMinStrength(200);
    --testlever:bind(2,deleteItem(position(119,635,0),2));
    testlever:bind(1,closedoor.closeDoor(position(119,639,0)));
    testlever:bind(1,lockdoor.lockDoor(position(119,639,0)));
    testlever:bind(1,deleteitem.deleteItem(position(118,639,0),2));
    --testlever:bind(1,deleteBridge(position(117,635,0)));
    --testlever:bind(1,deleteBridge(position(113,636,0))); -- geht
    --testlever:bind(1,deleteBridge(position(118,635,0))); --geht nicht
    --testlever:bind(1,deleteBridge(position(117,640,0))); -- geht
    
    testlever:bind(0,unlockdoor.unlockDoor(position(119,639,0)));
    testlever:bind(0,opendoor.openDoor(position(119,639,0)));
    --testlever:bind(0,handler.createbridge.createBridge(position(117,635,0),0,4));
    --testlever:bind(0,createBridge(position(113,636,0),1,4)); -- geht
    --testlever:bind(0,createBridge(position(118,635,0),2,4)); -- geht
    --testlever:bind(0,createBridge(position(117,640,0),3,4)); -- geht
    testlever:bind(0,createitem.createItem(position(118,639,0),2,333,0,1));
    AddToLevers(testlever);
    AddToLevers(testlever2);
    AddToLevers(myLev1);
    AddToLevers(myLev2);
end

function M.generateKey(posX,posY,posZ)
    return posX*1024*1024+posY*1024+posZ;
end

function M.UseItem (User,SourceItem,TargetItem,counter,param,ltstate)
    if (initi==nil) then
        myLevers=init();
        User:inform("initialize");
        initi=1;
    end
    key=SourceItem.pos.x*1024*1024+SourceItem.pos.y*1024+SourceItem.pos.z;
    if leverList[key]~=nil then
        leverList[key]:switchLever(User);
    else
        User:inform("Does not work!");
    end
end

function M.AddToLevers(myLever)
    if (world:isItemOnField(myLever.pos)==true) then    -- item on field?
        itemID=world:getItemOnField(myLever.pos).id;
        if (itemID>=434 and itemID<=439) then           -- is item a lever?
            key=myLever.pos.x*1024*1024+myLever.pos.y*1024+myLever.pos.z;
            leverList[key]=myLever;                     -- calculate unique key
            return 1;                                   -- put into list and return 1
        else
            return -2;                                  -- item is no lever
        end
    else
        return -1;                                      -- no item there
    end
end

return M
