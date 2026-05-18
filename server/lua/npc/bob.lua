local M = {}

local autonpcfunctions = require("npc.base.autonpcfunctions")
function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Finger weg!");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Don't touch me!");
end
function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();
    

-- ********* START DYNAMIC PART ********

name="Torina Scibri"
--position=0,0,0
race=human
sex=female
--direction=west
    
	
	-- cyletext
    autonpcfunctions.AddCycleText("#me sortiert Bücher in den Regalen","#me sorts books in the shelfs.");
    
    -- Begrüßung
    autonpcfunctions.AddTraderTrigger("hallo","Sei mir gegrüßt. Brauchst du Hilfe bei der Suche nach einem bestimmten Buch?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddAdditionalTrigger("gr[üue]+[sß]");
    autonpcfunctions.AddAdditionalTrigger("guten tag");
    autonpcfunctions.AddAdditionalTrigger("aho[ij]");
    autonpcfunctions.AddAdditionalTrigger("tach");
    -- Verabschiedung 
    autonpcfunctions.AddTraderTrigger("[Gg]ute nacht","Machs gut. Ich hoff, wir sehen uns bald wieder. Und halt die Großen immer schön fern.");
    autonpcfunctions.AddCondition("lang","german");
	autonpcfunctions.AddAdditionalTrigger("wieder sehen");
    autonpcfunctions.AddAdditionalTrigger("[Tt]sch[üue]+[sß]");
    autonpcfunctions.AddAdditionalTrigger("[Tt]tschau");
    autonpcfunctions.AddAdditionalTrigger("[Gg]ehabt euch");
    autonpcfunctions.AddAdditionalTrigger("[Aa]uf bald");
    autonpcfunctions.AddAdditionalTrigger("[Bb]is bald");
    -- Name
    autonpcfunctions.AddTraderTrigger("Name","Ich bin %name, die Schreiberin hier in der Grauen Zuflucht.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddAdditionalTrigger("wie hei[sß] du");
    autonpcfunctions.AddAdditionalTrigger("Wer bist du");
    autonpcfunctions.AddAdditionalTrigger("wer seid ihr");
    -- Argwohn gegenüber Orks
    autonpcfunctions.AddTraderTrigger(" ","So einer wie Du hat hier nichts zu suchen. Hau ab oder ich ruf die Wachen!");
    autonpcfunctions.AddCondition("race", CCharacter.orc);
    autonpcfunctions.AddCondition("lang","german");
    
    autonpcfunctions.AddTraderTrigger(" ","You should not be here. Leave before i call for guards!");
    autonpcfunctions.AddCondition("race", CCharacter.orc);
    autonpcfunctions.AddCondition("lang","english");
    
    
    
    --Schlüsselabgabe wenn Char einen Siegelring der Rose hat und genügend Geld
    autonpcfunctions.AddTraderTrigger("[Bb]rauch [Ss]chl[üue]ssel","Hier hast du einen.");
    autonpcfunctions.AddAdditionalTrigger("[Mm][öoe]chte Schl[üue]ssel");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("item",68,"body",">=",1); -- Siegelring der Rose ist ein Rubinring (id 68, data 2)
    autonpcfunctions.AddCondition("money",">=",100);
    autonpcfunctions.AddConsequence("money","-",100);
    autonpcfunctions.AddConsequence("item",1,1,199,0); -- id, number, quality, data

    
    
    -- ********* END DYNAMIC PART ********
    TradSpeakLang={0,8};
    TradStdLang=0;
    --common language=0
    --human language=1
    --dwarf language=2
    --elf language=3
    --lizard language=4
    --orc language=5
    --halfling language=6
    --fairy language=7
    --gnome language=8
    --goblin language=9
    --ancient language=10

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
