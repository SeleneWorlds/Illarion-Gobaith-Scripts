local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),2,-417,44,0,2,false,'Barney Haycrop','npc_barney_haycrop.lua',0);

local autonpcfunctions = require("npc.base.autonpcfunctions")
function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Finger weg!");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Dont you touch me!");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();

    --********* START DYNAMIC PART ********

    QuestID = 22;
    --Non Quest-Related--
    autonpcfunctions.AddTraderTrigger("Hello","Ah, good day, and welcome to Greenbriar! Fine day for a nice smoke");
    autonpcfunctions.AddTraderTrigger("Hallo","Ah, Guten Tag und Willkommen in Greenbriar! Ein guter Tag, um eine Pfeife zu rauchen.");
    autonpcfunctions.AddTraderTrigger("Greetings","Ah, good day, and welcome to Greenbriar! Fine day for a nice smoke");
    autonpcfunctions.AddTraderTrigger("Grüße","Ah, Guten Tag und Willkommen in Greenbriar! Ein guter Tag, um eine Pfeife zu rauchen.");
    autonpcfunctions.AddTraderTrigger("Who","Me name's Barney Haycrop, and its a pleasure to meet you");
    autonpcfunctions.AddTraderTrigger("Wer","Mein Name ist Barney Haycrop und es ist mir ein Vergnügen, euch zu treffen.");
    autonpcfunctions.AddTraderTrigger("What","Well, I'm not doing anything really, just lazing about");
    autonpcfunctions.AddTraderTrigger("Was","Nun, ich tue nicht wirklich etwas, bin nur ein wenig am ausruhen.");
    autonpcfunctions.AddTraderTrigger("Buy","Buying and selling sounds like too much hard work for me");
    autonpcfunctions.AddTraderTrigger("Kaufe","Das Kaufen und Verkaufen klingt nach zuviel Arbeit für mich.");
    autonpcfunctions.AddTraderTrigger("Sell","Buying and selling sounds like too much hard work for me");
    autonpcfunctions.AddTraderTrigger("Verkaufe","Das Kaufen und Verkaufen klingt nach zuviel Arbeit für mich.");
    autonpcfunctions.AddTraderTrigger("Wares"," 'ave nothign to sell, my friend");
    autonpcfunctions.AddTraderTrigger("Waren","Habe nix zu verkaufen, du.");
    autonpcfunctions.AddTraderTrigger("Bye","Ahh, goodbye");
    autonpcfunctions.AddTraderTrigger("Tschüss","Ahh, auf Wiedersehen!");
    -- Quest Related--
    autonpcfunctions.AddTraderTrigger("Locket","A locket you say... what a coincidence; I found one a few days ago... here, I trust you'll give it to the right owner");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddConsequence("item",222,1,199,0);
    autonpcfunctions.AddTraderTrigger("Medaillon","Ein Medaillon, sagt ihr? Was für ein Zufall, ich habe eines vor einigen Tagen gefunden. Hier, ich vertraue darauf, dass ihr des dem rechtmäßigen Eigentümer übergebt.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddConsequence("item",222,1,199,0);
    -- Cycles--
    autonpcfunctions.AddCycleText("#me nimmt einen tiefen Zug von der Pfeife","#me inhales deeply from his pipe");
    autonpcfunctions.AddCycleText("#me ruht sich aus","#me lazes about");
    autonpcfunctions.AddCycleText("#me gähnt faul","#me yawns lazily");
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
