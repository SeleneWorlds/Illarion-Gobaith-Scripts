local M = {}

-- Quest: The Missing Son
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,0,0,0,4,false,'Jeyne Terelorn','npc_jeyne_terelorn.lua',0);

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

    autonpcfunctions.SetRadius(5);
    QuestID = 999;
    -- Queststatus Overview
    -- 1: Quest has been taken
	-- 2: Footprints have been found
	-- 3: Son has been found
    autonpcfunctions.AddTraderTrigger("hallo","Seid gegrüßt. Sagt, könntet Ihr mir helfen?");
    autonpcfunctions.AddAdditionalTrigger("grüße");
    autonpcfunctions.AddAdditionalTrigger("tach");
    autonpcfunctions.AddAdditionalTrigger("hiho");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("hello","Greetings to you. Can you help me?");
    autonpcfunctions.AddAdditionalTrigger("greetings");
    autonpcfunctions.AddAdditionalTrigger("hiho");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("hilfe","Mein Sohn...er ist verschwunden! Könnt Ihr mir helfen, ihn zu suchen?");
    autonpcfunctions.AddAdditionalTrigger("helfen");
    autonpcfunctions.AddAdditionalTrigger("ja");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddTraderTrigger("help","My son...he dissapeared! Can you help me finding him?");
    autonpcfunctions.AddAdditionalTrigger("yes");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger("ja","Danke vielmals! Ich befürchte er ist wieder im [WALD], dabei habe ich es ihm doch verboten! Ich suche hier, geht Ihr bitte zum [WALD].");
    autonpcfunctions.AddAdditionalTrigger("sicher");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("yes","Thank you! I fear he's at the [WALD] again, though I told him it's dangerous there! I'll search here, please go to the [WALD] and see if he's there.");
    autonpcfunctions.AddAdditionalTrigger("sure");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("verkauf","Ich verkaufe nichts.");
    autonpcfunctions.AddTraderTrigger("kauft","Ich kaufe nichts.");
    autonpcfunctions.AddAdditionalTrigger("kaufst");
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
