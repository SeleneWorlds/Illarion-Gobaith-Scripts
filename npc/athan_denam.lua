local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),3,-102, -71, 0 ,0,false,'Athan Denam','npc_athan_denam.lua',0);
local autonpcfunctions = require("npc.base.autonpcfunctions")
function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Finger weg!");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Don't you touch me!");
end
function M.initializeNpc()
    if TraderFirst then
        return true;
    end
    
    autonpcfunctions.InitTalkLists();
    
    QuestID=556;
    -- ********* START DYNAMIC PART ********
    autonpcfunctions.AddCycleText("Die armen Schweinchen","Those poor piggies");
    autonpcfunctions.AddCycleText("#me seufzt","#me sighs");
    autonpcfunctions.AddTraderTrigger("Hallo","Hallo, mein Freund. Bist du dir sicher, dass du die kleinen Schweinchen töten willst?");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Grüsse","Grüsse, mein Freund. Bist du dir sicher, dass du die kleinen Schweinchen töten willst?");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Grüße","Grüße, mein Freund. Bist du dir sicher, dass du die kleinen Schweinchen töten willst?");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Guten Tag","Guten Tag, mein Freund. Bist du dir sicher, dass du die kleinen Schweinchen töten willst?");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Hello","Hello, my friend. Are you really sure that you will kill those lovely piggies?");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Greetings","Greetings, my friend. Are you really sure that you will kill those lovely piggies?");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Greets","Greets, my friend. Are you really sure that you will kill those lovely piggies?");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Be greeted","Be greeted, my friend. Are you really sure that you will kill those lovely piggies?");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Nein","Du bist ein wahrer Tierfreund. Ich gebe dir etwas gegen deinen Hunger.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state",3);
    autonpcfunctions.AddConsequence("item",49,1,333,0);
    autonpcfunctions.AddConsequence("qpg",1);
    autonpcfunctions.AddTraderTrigger("No","You are a real animals friend. I'll give you something against your hunger.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state",3);
    autonpcfunctions.AddConsequence("item",49,1,333,0);
    autonpcfunctions.AddConsequence("qpg",1);
    autonpcfunctions.AddTraderTrigger("Ja","Kann ich dich nicht umstimmen? Ich gebe dir fünf Kupfer. Dann kannst du dir ein Brot kaufen. Bist du einverstanden?");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state",2);
    autonpcfunctions.AddTraderTrigger("Yes","Can I change your mind somehow? I will give you five copper. You can buy yourself a bread with the money. Do you consider?");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state",2);
    autonpcfunctions.AddTraderTrigger("Ja","Du bist klug mein Freund. Hier ist dein Kupfer.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state",3);
    autonpcfunctions.AddConsequence("money","+",5);
    autonpcfunctions.AddConsequence("qpg",1);
    autonpcfunctions.AddTraderTrigger("Yes","You are bright my friend. Here's your copper");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state",3);
    autonpcfunctions.AddConsequence("money","+",5);
    autonpcfunctions.AddConsequence("qpg",1);
    autonpcfunctions.AddTraderTrigger("Nein","Dann kann ich dir leider nicht helfen. Mögen dich die Schweine beissen!");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state",3);
    autonpcfunctions.AddConsequence("qpg",2);
    autonpcfunctions.AddTraderTrigger("No","In that case I can't help you. May the pigs bite you!");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state",3);
    autonpcfunctions.AddConsequence("qpg",2);
    autonpcfunctions.AddTraderTrigger("Hallo","Hallo, mein Freund.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Grüsse","Grüsse, mein Freund.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Grüße","Grüße, mein Freund.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Guten Tag","Guten Tag, mein Freund.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Hello","Hello, my friend.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Greetings","Greetings, my friend.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Greets","Greets, my friend.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Be greeted","Be greeted, my friend.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Hallo","Verschwinde, elender Mörder! ");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Grüsse","Verschwinde, elender Mörder! ");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Grüße","Verschwinde, elender Mörder! ");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Guten Tag","Verschwinde, elender Mörder! ");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Hello","Get along with you, wretched murderer! ");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Greetings","Get along with you, wretched murderer! ");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Be greeted","Get along with you, wretched murderer! ");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Greets","Get along with you, wretched murderer! ");
    autonpcfunctions.AddCondition("qpg","=",2);
    -- ********* END DYNAMIC PART ********
    TradSpeakLang={0,1};
    TradStdLang=0;
    
    autonpcfunctions.increaseLangSkill(TradSpeakLang)
    thisNPC.activeLanguage=TradStdLang;
    
end
function M.nextCycle()  -- ~10 times per second
    M.initializeNpc();
    autonpcfunctions.SpeakerCycle();
end
function M.receiveText(texttype, message, originator)
    if autonpcfunctions.BasicNPCChecks(originator,2) then
        if autonpcfunctions.LangOK(originator,TradSpeakLang) then
            autonpcfunctions.TellSmallTalk(message,originator);
        else
            autonpcfunctions.Confused(
               "#me sieht dich leicht verwirrt an",
               "#me looks at you a little confused"
            );
        end
    end
end

return M
