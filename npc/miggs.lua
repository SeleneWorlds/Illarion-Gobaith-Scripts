local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),1,10,1,0,4,false,'Miggs','npc_miggs.lua',0);

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

    -- ********* START DYNAMIC PART ********

    QuestID = 77;
    -- NPC by Estralis Seborian
    -- Queststatus Overview
    -- 0: No Quest taken
    -- 1: Quest 1 taken - kill 10 mummies
    -- 11: Quest 1 solved
    -- 12: Game over
    -- Debugging
    autonpcfunctions.AddTraderTrigger("set 0","Quest status set to 0");
    autonpcfunctions.AddConsequence("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("set 11","Quest status set to 11");
    autonpcfunctions.AddConsequence("qpg","=",11);
    -- Help
    autonpcfunctions.AddTraderTrigger("Help","");
    autonpcfunctions.AddConsequence("inform","[Game Help] Just say 'quest'. set 0 or set 11 sets your queststatus accordingly.");
    autonpcfunctions.AddTraderTrigger("Hilfe","");
    autonpcfunctions.AddConsequence("talk","end");
    -- 1st quest: Kill 10 mummies.
    autonpcfunctions.AddTraderTrigger("quest","Kill ten mummies (101-107), plz. Then say 'quest' again.");
    autonpcfunctions.AddAdditionalTrigger("mission");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddConsequence("inform","[New quest] Smash' em, dude");
    autonpcfunctions.AddTraderTrigger("quest","THX 4 killing mummies.");
    autonpcfunctions.AddAdditionalTrigger("mission");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddConsequence("inform","[Quest solved] U rule.");
    autonpcfunctions.AddConsequence("qpg","=",12);
    autonpcfunctions.AddTraderTrigger("quest","U already solved quest, noob. Say set 0 to start over.");
    autonpcfunctions.AddAdditionalTrigger("mission");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddTraderTrigger("quest","U have 2 kill moar mummies, noob.");
    autonpcfunctions.AddAdditionalTrigger("mission");
    autonpcfunctions.AddCondition("qpg",">",0);
    autonpcfunctions.AddCondition("qpg","<",11);
    autonpcfunctions.AddCycleText("Frag mich nach einer Queste.","Ask me 4 quest, pl0x.");
    autonpcfunctions.AddCycleText("GTFO noob","GTFO noob");
    -- ********* END DYNAMIC PART ********
    TradSpeakLang={0,1};
    TradStdLang=0;

    autonpcfunctions.increaseLangSkill(TradSpeakLang);
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
