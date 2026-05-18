local M = {}

--37 cow id, faceto= 6 (west)
--775,793,0
--Mjilka
local autonpcfunctions = require("npc.base.autonpcfunctions")
local quest_aquest28 = require("quest_aquest28") -- the quest file

function M.InitNPC()
    if not InitDone then
        InitDone = true;
        CowID = 2; --id of this cow NEEDS TO BE CHANGED AT EACH COW
        
		ActiveTask = 0;
		thisNPC:increaseSkill(1,"common language",100);
		TradSpeakLang={0,1};
		autonpcfunctions.increaseLangSkill(TradSpeakLang);
    	thisNPC.activeLanguage=0;
    	
                  --comb, water bucket, lute ,   nothing,bundle of grain, big empty bottle         
        itemlist = quest_aquest28.getTaskItems();
       -- npc_names = { "Betsy", "Mjilka", "Cheeseball"};
    end
end 

function M.useNPC(originator,Counter,Param)
  	User = getCharForId(originator.id);  --create a save copy of the char struct
	quest_aquest28.Cow_useNPC(User, Counter, Param);
end

function M.receiveText(texttype, message, originator)
	quest_aquest28.Cow_receiveText(texttype,message,originator);
end

function M.nextCycle()
-- see cow1
--    InitNPC();

--    quest_aquest28.Cow_NextCycle(User);
end

return M
