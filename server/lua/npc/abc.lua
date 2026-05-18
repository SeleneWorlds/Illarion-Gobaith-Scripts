local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),halfing,10,10,0,2,false,'ABC','npc/abc.lua',0);

local autonpcfunctions = require("npc.base.autonpcfunctions")
-- dofile("/usr/share/servers/illarionserver/scripts/npc_autonpcfunctions.lua");

function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "ABC!");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "ABC!");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();

    -- ********* START DYNAMIC PART ********

    QuestID = 0815;
    autonpcfunctions.AddTraderTrigger("gimme %NUMBER","Sure dude, here you have %NUMBER coins.");
    autonpcfunctions.AddConsequence("money","+","%NUMBER");
    autonpcfunctions.AddTraderTrigger("%NUMBER","You have less than %NUMBER coins.");
    autonpcfunctions.AddCondition("money","<","%NUMBER");
    autonpcfunctions.AddTraderTrigger("%NUMBER","You have more than %NUMBER coins.");
    autonpcfunctions.AddCondition("money",">","%NUMBER");
    autonpcfunctions.AddTraderTrigger("%NUMBER","You have exactly %NUMBER coins.");
    autonpcfunctions.AddCondition("money","=","%NUMBER");
    autonpcfunctions.AddTraderTrigger("%NUMBER","Erm, something is wrong here.");
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
