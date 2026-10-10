local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),8,156,-448,0,4,false,'Meegog','npc_meegog.lua',0);

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

    -- Meegog a Goblin slave
    autonpcfunctions.AddTraderTrigger("greetings","Greetinks! How may poor "..thisNPC.name.." serve my Masters?  I can saw logs for you!");
    autonpcfunctions.AddAdditionalTrigger("hello");
    autonpcfunctions.AddAdditionalTrigger("Greeb+[a]+s");
    autonpcfunctions.AddTraderTrigger("gr[üue]+[sß]+e","Grüße! Wie kann schlechter "..thisNPC.name.." meinen Mastern dienen? Ich kann sah Klotz für Sie!");
    autonpcfunctions.AddAdditionalTrigger("Hallo");
    autonpcfunctions.AddAdditionalTrigger("Guten Tag");
    autonpcfunctions.AddTraderTrigger("Saw Logs","Which type shall I make master?  Apple, Cherry, Conifer or Naldor?");
    autonpcfunctions.AddTraderTrigger("sah Klotz","Welchen Typ werde ich Master machen? Apfel, Kirsch, Tannen oder Naldor?");
    autonpcfunctions.AddTraderTrigger("Apple","#me takes your logs and immediately saws them into boards. ");
    autonpcfunctions.AddCondition("item",2560,"belt",">=",1);
    autonpcfunctions.AddConsequence("item",2716,1,333,0);
    autonpcfunctions.AddConsequence("deleteitem",2560,1);
    autonpcfunctions.AddTraderTrigger("Apfel","#me nimmt Ihren Klotz und sägt sie sofort in Ausschüsse. ");
    autonpcfunctions.AddCondition("item",2560,"belt",">=",1);
    autonpcfunctions.AddConsequence("item",2716,1,333,0);
    autonpcfunctions.AddConsequence("deleteitem",2560,1);
    autonpcfunctions.AddTraderTrigger("Cherry","#me takes your logs and immediately saws them into boards. ");
    autonpcfunctions.AddCondition("item",543,"belt",">=",1);
    autonpcfunctions.AddConsequence("item",545,1,333,0);
    autonpcfunctions.AddConsequence("deleteitem",543,1);
    autonpcfunctions.AddTraderTrigger("Kirsch","#me nimmt Ihren Klotz und sägt sie sofort in Ausschüsse. ");
    autonpcfunctions.AddCondition("item",543,"belt",">=",1);
    autonpcfunctions.AddConsequence("item",545,1,333,0);
    autonpcfunctions.AddConsequence("deleteitem",543,1);
    autonpcfunctions.AddTraderTrigger("Conifer","#me takes your logs and immediately saws them into boards. ");
    autonpcfunctions.AddCondition("item",3,"belt",">=",1);
    autonpcfunctions.AddConsequence("item",2543,1,333,0);
    autonpcfunctions.AddConsequence("deleteitem",3,1);
    autonpcfunctions.AddTraderTrigger("Tannen","#me nimmt Ihren Klotz und sägt sie sofort in Ausschüsse. ");
    autonpcfunctions.AddCondition("item",3,"belt",">=",1);
    autonpcfunctions.AddConsequence("item",2543,1,333,0);
    autonpcfunctions.AddConsequence("deleteitem",3,1);
    autonpcfunctions.AddTraderTrigger("Naldor","#me takes your logs and immediately saws them into boards. ");
    autonpcfunctions.AddAdditionalTrigger("Oak");
    autonpcfunctions.AddCondition("item",544,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("item",546,1,333,0);
    autonpcfunctions.AddConsequence("deleteitem",544,1);
    autonpcfunctions.AddTraderTrigger("Naldor","#me nimmt Ihren Klotz und sägt sie sofort in Ausschüsse. ");
    autonpcfunctions.AddCondition("item",544,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("item",546,1,333,0);
    autonpcfunctions.AddConsequence("deleteitem",544,1);
    -- RP reactions
    autonpcfunctions.AddTraderTrigger("kick","Ooohhh!  Please dont hurt poor "..thisNPC.name..", Ill do as you asks!");
    autonpcfunctions.AddAdditionalTrigger("boot");
    autonpcfunctions.AddTraderTrigger("tritt"," Ooohhh! Du nicht bestrafen armen "..thisNPC.name..", ich alles machen was du sagst!");
    autonpcfunctions.AddAdditionalTrigger("trete");
    autonpcfunctions.AddAdditionalTrigger("stiefel");
    autonpcfunctions.AddTraderTrigger("beat","#me cringes into a corner, begging for mercy.");
    autonpcfunctions.AddAdditionalTrigger("punch");
    autonpcfunctions.AddAdditionalTrigger("hit");
    autonpcfunctions.AddAdditionalTrigger("slap");
    autonpcfunctions.AddTraderTrigger("Erfolg","#me duckt sich an einer Ecke, um die Gnade bittend.");
    autonpcfunctions.AddAdditionalTrigger("Schlag");
    autonpcfunctions.AddTraderTrigger("whip","#me cringes in a corner and screams for mercy!");
    autonpcfunctions.AddAdditionalTrigger("slash");
    autonpcfunctions.AddTraderTrigger("peitsche","#me duckt sich ängstlich und winselt um Gnade!");
    autonpcfunctions.AddAdditionalTrigger("schlag");
    autonpcfunctions.AddAdditionalTrigger("hieb");
    autonpcfunctions.AddAdditionalTrigger("prügel");
    -- Codes
    autonpcfunctions.AddTraderTrigger("make","I can saw Logs for you master.");
    autonpcfunctions.AddAdditionalTrigger("do");
    autonpcfunctions.AddTraderTrigger("machen"," Ich kann sah Klotz für Sie um zu meistern. ");
    autonpcfunctions.AddAdditionalTrigger("tun");
    autonpcfunctions.AddAdditionalTrigger("tust");
    autonpcfunctions.AddTraderTrigger("was verkaufe","Ich habe nickts, Ich verkaufe gar nix.");
    autonpcfunctions.AddTraderTrigger("what sell","I have nothing, so I sell nothing.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("was kaufe","Ich habe kein geld, Ich kaufe gar nix.");
    autonpcfunctions.AddTraderTrigger("what buy","I have no money, so I buy nothing.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("auf bald","Bis bald!");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalTrigger("tschüss");
    autonpcfunctions.AddTraderTrigger("farewell","Be well!");
    autonpcfunctions.AddAdditionalTrigger("bye");
    autonpcfunctions.AddAdditionalTrigger("good day");
    autonpcfunctions.AddCycleText("#me pickt seine Nase auf","#me picks his nose");
    autonpcfunctions.AddCycleText("#me räumt die Höhle auf","#me cleans up the cave");
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
