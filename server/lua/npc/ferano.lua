local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),3,371,152,-10,4,false,'Ferano','npc_ferano.lua',0);

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

    autonpcfunctions.SetRadius(0);
    autonpcfunctions.AddCycleText("#me sieht sich um","#me looks around");
    QuestID = 558;
    autonpcfunctions.AddTraderTrigger("[Rr]eset","Reset done!");
    autonpcfunctions.AddConsequence("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("[aA]uf bald","Auf bald, die Fünf mit euch.");
    autonpcfunctions.AddTraderTrigger("[Vv]anima","Tol Vanima ist die Insel der Elfen und das hier ist die Mine von Vanima. Die Mine bietet Unterschlupf für einige Gnomforscher. Nehmt euch vor ihnen in Acht, sie sind sehr gefährlich!");
    autonpcfunctions.AddTraderTrigger("[Hh]allo","Seid gegrüßt Reisender");
    autonpcfunctions.AddAdditionalTrigger("[Gg]r[üs][sß]e");
    autonpcfunctions.AddAdditionalTrigger("[Ss]eid gegrüßt");
    autonpcfunctions.AddCondition("qpg","<",2);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("h[ie]lfe","Ich such jemanden der mir einen Molotov-Cocktail bringt, ich brauch ihn für meine Forschungen, wollt ihr mir helfen?");
    autonpcfunctions.AddAdditionalTrigger("mach");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("[Hh][ie]lf","Ich such jemanden der mir einen Molotov-Coktail bringt, ich brauch ihn für meine Forschungen, wollt ihr mir helfen?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("[Jj]a","Wirklich, vielen Dank ich werde euch dafür auch reichlich Entlohnen.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("[Nn]ein","Schade, dennoch Danke");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("[Mm]olotov","Oh, vielen Dank hier ist eure Belohnung");
    autonpcfunctions.AddCondition("item",2502,"all",">=",1);
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("deleteitem",2502,1);
    autonpcfunctions.AddConsequence("item",3077,3,333,0);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("[Mm]olotov","Ihr habt doch gar kein Molotov-Cocktail dabei, kommt wieder wenn ihr einen habt!");
    autonpcfunctions.AddCondition("item",2502,"all","<",1);
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("[Gg]r[üs][sß]e","Hallo, schön euch wiederzusehen %CHARNAME. Wollt ihr mir erneut helfen?");
    autonpcfunctions.AddAdditionalTrigger("[Hh]allo");
    autonpcfunctions.AddAdditionalTrigger("[Ss]eid gegrüßt");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",5);
    autonpcfunctions.AddTraderTrigger("[Jj]a","Sehr gut, ich bräuchte einen Meriniumbrocken, könnt ihr mir soetwas holen?");
    autonpcfunctions.AddAdditionalTrigger("[Hh][ei]lf");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("[Nn]ein","Schade, sprecht mich ruhig an wenn ihr mehr Zeit habt.");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("[Jj]a","Vielen dank, ich hörte die Gnomforscher in der Vanimamine haben sowas.");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",7);
    autonpcfunctions.AddTraderTrigger("[Mm]erinium","Ein Meriniumbrocken ist ein seltenes Erz. Könnt ihr mir dieses beschaffen?");
    autonpcfunctions.AddAdditionalTrigger("[Bb]rocken");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("[Nn]ein","Schade, sprecht mich ruhig an wenn ihr mehr Zeit habt.");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("[mM]erinium","Vielen Dank, ihr habt mir mal wieder sehr geholfen. Hier ist eure Belohnung");
    autonpcfunctions.AddAdditionalTrigger("[Bb]rocken");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddCondition("item",2534,"all",">=",1);
    autonpcfunctions.AddConsequence("deleteitem",2534,1);
    autonpcfunctions.AddConsequence("item",334,1,666,0);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("[Mm]erinium","Ihr seid nicht im Besitz eines Meriniumbrocken, kommt wieder wenn ihr einen habt!");
    autonpcfunctions.AddAdditionalTrigger("[Bb]rocken");
    autonpcfunctions.AddCondition("item",2534,"all","<",1);
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddTraderTrigger("[Gg]r[üs][sß]e","Hallo, schön euch wiederzusehen %CHARNAME.");
    autonpcfunctions.AddAdditionalTrigger("[Hh]allo");
    autonpcfunctions.AddAdditionalTrigger("[Ss]eid gegrüßt");
    autonpcfunctions.AddCondition("qpg","=",8);
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
