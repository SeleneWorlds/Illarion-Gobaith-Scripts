local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,1,1,0,4,false,'Uluhad','npc_uluhad.lua',0);
local autonpcfunctions = require("npc.base.autonpcfunctions")
function M.buyIn( amount )
    User:setQuestProgress(playerBuyInID, User:getQuestProgress(playerBuyInID)+amount);
    return amount;
end

function M.cashOut()
    playerMoney = User:getQuestProgress(playerMoneyID);
    playerBuyIn = User:getQuestProgress(playerBuyInID);
    playerWonMon = playerMoney - playerBuyIn;
    if( playerWonMon > 0 ) then
        houseMoney = math.ceil(houseRake*playerWonMon);
        playerMoney = playerMoney - houseMoney;
        
        filepoint,errmsg=io.open("/home/vilarion/money/gamble"..QuestID..".dat","r+");
        if (filepoint~=nil) then
            filepoint:seek("set");
            coins = houseMoney + filepoint:read("*n");
            filepoint:seek("set");
            filepoint:write(""..coins);
            filepoint:close();
        end;
        
        thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Der Hausanteil ist "..houseRakePercent.."% aller Gewinne");
        thisNPC:talkLanguage(CCharacter.say, CPlayer.english,"The house rake is "..houseRakePercent.."% of all winnings");
    end;
    User:setQuestProgress(playerMoneyID, 0);
    User:setQuestProgress(playerBuyInID, 0);
    return playerMoney;
end

 function M.useNPC(user,counter,param)
   thisNPC:increaseSkill(1,"common language",100);
   thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Finger weg!");
   thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Don't you touch me!");
 end

 function M.initializeNpc()
   if TraderFirst then
       TraderFirst=1;
       return true;
   end
   
   --debugMode = 1;
   
   QuestID   = 17;
   houseRake = 0.10;
   
   playerMoneyID = QuestID;
   playerBuyInID = QuestID+1;
   houseRakePercent = houseRake * 100;
   
   autonpcfunctions.InitTalkLists();
   
   
   -- ********* START DYNAMIC PART ********
   autonpcfunctions.AddTraderTrigger("Hello","Be greeted.");
   autonpcfunctions.AddTraderTrigger("Hallo","Seid mir gegrüßt.");
   autonpcfunctions.AddTraderTrigger("greetings","Be greeted.");
   autonpcfunctions.AddTraderTrigger("grüße","Seid mir gegrüßt.");
   autonpcfunctions.AddTraderTrigger("help","I sell chips for gambling and give you your money afterwards. I am the cashier here.");
   autonpcfunctions.AddTraderTrigger("hilfe","Ich verkaufe Chips zum Spielen und gebe Euch später Euer Geld. Ich bin der Kassierer hier.");
   autonpcfunctions.AddTraderTrigger("what sell","I sell chips for gambling and give you your money afterwards. I am the cashier here.");
   autonpcfunctions.AddTraderTrigger("was verkauf","Ich verkaufe Chips zum Spielen und gebe Euch später Euer Geld. Ich bin der Kassierer hier.");
   
   autonpcfunctions.AddTraderTrigger("%NUMBER chips","That is not enough money for %NUMBER chips.");
   autonpcfunctions.AddCondition("money","<","%NUMBER");
   autonpcfunctions.AddCondition("lang","english");
   autonpcfunctions.AddTraderTrigger("%NUMBER chips","Das ist nicht genug Geld für %NUMBER Chips.");
   autonpcfunctions.AddCondition("money","<","%NUMBER");
   autonpcfunctions.AddCondition("lang","german");

   autonpcfunctions.AddTraderTrigger("%NUMBER chips","Here are %NUMBER chips to play with. Enjoy your stay.");
   autonpcfunctions.AddConsequence("money","-","%NUMBER");
   --npc.base.autonpcfunctions.AddCondition("money",">=","%NUMBER")
   autonpcfunctions.AddConsequence("qpg","+",buyIn);
   autonpcfunctions.AddCondition("lang","english");
   autonpcfunctions.AddTraderTrigger("%NUMBER chips","Hier sind %NUMBER Chips zum Spielen. Viel Spaß.");
   autonpcfunctions.AddConsequence("money","-","%NUMBER");
   --npc.base.autonpcfunctions.AddCondition("money",">=","%NUMBER")
   autonpcfunctions.AddConsequence("qpg","+",buyIn);
   autonpcfunctions.AddCondition("lang","german");

   autonpcfunctions.AddTraderTrigger("money","No chips, no money.");
   autonpcfunctions.AddCondition("qpg","=",0);
   autonpcfunctions.AddTraderTrigger("geld","Keine Chips, kein Geld.");
   autonpcfunctions.AddCondition("qpg","=",0);
   
   autonpcfunctions.AddTraderTrigger("money","Here is your money.");
   --npc.base.autonpcfunctions.AddCondition("qpg",">",0);
   autonpcfunctions.AddConsequence("money","+",cashOut);
   
   autonpcfunctions.AddTraderTrigger("geld","Da hast du dein Geld.");
   --npc.base.autonpcfunctions.AddCondition("qpg",">",0);
   autonpcfunctions.AddConsequence("money","+",cashOut);

   -- ********* END DYNAMIC PART ********
   TradSpeakLang={0,1};
   TradStdLang=0;
   
   autonpcfunctions.increaseLangSkill(TradSpeakLang)
   thisNPC.activeLanguage=TradStdLang;
 end

 function M.nextCycle() -- ~10 times per second
   M.initializeNpc();
   autonpcfunctions.SpeakerCycle();
 end

 function M.receiveText(texttype, message, originator)
   if autonpcfunctions.BasicNPCChecks(originator,2) then
  if autonpcfunctions.LangOK(originator,TradSpeakLang) then
 debugText="";
 if debugMode then
   if QuestID~=nil then
  QeSt=originator:getQuestProgress( QuestID );
  if QeSt~=nil then
 debugText="QS="..QeSt;
  else
 debugText="QS=0";
  end
   end
   St=NPCStatus[originator.id]
   if St~=nil then
  debugText=debugText.." St="..St;
   else
  debugText=debugText.." St=0";
   end
   thisNPC:talk(CCharacter.say,"Debug Info: "..debugText);
 end
 --thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "before npc.base.autonpcfunctions.TellSmallTalk");
 autonpcfunctions.TellSmallTalk(message,originator);
 --thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "after npc.base.autonpcfunctions.TellSmallTalk");
  else
 autonpcfunctions.Confused(
  "#me sieht dich leicht verwirrt an",
  "#me looks at you a little confused"
 );
  end
   end
 end

return M
