local M = {}

--Name:        Eltareon
--Race:        Human
--Town:        Trolls Bane
--Function:    Libarian
--Position:    x=-92 y=-127 z=0
--Facing:      South
--Last Update: 04/16/2006
--Update by:   Nitram

local functions = require("npc.base.functions")
function M.useNPC(user,counter,param)
    local lang=user:getPlayerLanguage();
    thisNPC:increaseSkill(1,"common language",100);
    if (lang==0) then thisNPC:talk(CCharacter.say, "Finger weg!") end
    if (lang==1) then thisNPC:talk(CCharacter.say, "Don't you touch me!") end
end

function M.initializeNpc()
    functions.InitTalkLists()
    --    HistTextD={};
    --    HistTextE={};

    thisNPC:increaseSkill(1,"common language",100);
    --------------------------------------------- *** EDIT BELOW HERE ***--------------------------------------

    functions.AddTraderTrigger("[Hh]ello","Greetings. Nice to meet you.");
    functions.AddAdditionalTrigger("[Gg]reetings");
    functions.AddAdditionalTrigger("[Hh]i");
    functions.AddTraderTrigger("[Hh]allo","Grüße. Freut mich euch zu treffen.");
    functions.AddAdditionalTrigger("[Gg]r[uü][sß]+");
    functions.AddTraderTrigger("[Ww]ho","I am "..thisNPC.name.."");
    functions.AddTraderTrigger("[Ww]er","Ich bin "..thisNPC.name..".");
    functions.AddTraderTrigger("[Bb]ye.","Be well");
    functions.AddAdditionalTrigger("[Ff]arewell");
    functions.AddAdditionalText("Farewell");
    functions.AddTraderTrigger("[Aa]uf.+[Bb]ald","Bis Bald");
    functions.AddAdditionalTrigger("[Bb]is.+[Bb]ald");
    functions.AddAdditionalText("Auf bald");
    functions.AddAdditionalText("Auf balde");

    functions.AddCycleText("#me blättert in einem Buch herum","#me browses through a book");
    functions.AddCycleText("#me gähnt verhalten","#me yawns restrained");

    TradSpeakLang={0,1};
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

end

function M.nextCycle()  -- ~10 times per second
    if (TraderFirst == nil) then
        M.initializeNpc();
        functions.increaseLangSkill(TradSpeakLang)
        thisNPC.activeLanguage=TradStdLang;
    end
    functions.SpeakerCycle();
end

function M.receiveText(texttype, message, originator)
    if functions.BasicNPCChecks(originator,2) then
        if (functions.LangOK(originator,TradSpeakLang)==true) then
            thisNPC.activeLanguage=originator.activeLanguage;

            functions.TellSmallTalk(message);
        else
            if (verwirrt==false) then
                gText="#me sieht dich leicht verwirrt an";
                eText="#me looks at you a little confused";
                outText=functions.GetNLS(originator,gText,eText);
                functions.NPCTalking(thisNPC,outText);
                verwirrt=true;
            end
        end
    end
end--function

--function AddHistTextD(Text)
--    table.insert(HistTextD,Text);
--end
--
--function AddHistTextE(Text)
--    table.insert(HistTextE,Text);
--end
--
--function TellHistText(originator,message)
--    if (string.find(message,"[Cc]hronic") ~= nil) or (string.find(message,"[Hh]istory") ~= nil) or
--    (string.find(message,"[Gg]eschicht") ~= nil) then
--        if (originator:getPlayerLanguage()==0) then
--            TextNumb=math.random(#HistTextD);
--            return 1,HistTextD[TextNumb]
--        else
--            TextNumb=math.random(#HistTextE);
--            return 1,HistTextE[TextNumb]
--        end
--    else
--        return 0
--    end
--end

return M
