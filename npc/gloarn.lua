local M = {}

--Name:        Gloarn
--Race:        Human
--Town:        ???
--Function:    Schweinehirte/Dorfdepp

local functions = require("npc.base.functions")
function M.useNPC(user,counter,param)
    local lang=user:getPlayerLanguage();
    thisNPC:increaseSkill(1,"common language",100);
    if (lang==0) then thisNPC:talk(CCharacter.say, "He, nicht kitzeln!") end
    if (lang==1) then thisNPC:talk(CCharacter.say, "Hey, don't tickle me!") end
end

function M.initializeNpc()
    functions.InitTalkLists()
    
    functions.AddTraderTrigger("[Gg]rüße","Hallo du.."); -- Fügt Triggertext mit Antwort hinzu
    functions.AddAdditionalTrigger("[Hh]allo");          -- Fügt zu letztem "npc.base.functions.AddTraderTrigger" zusätzlichen Triggertext hinzu
    functions.AddAdditionalTrigger("[Gg]ruesse");
    functions.AddAdditionalText("Huhu duhu");    -- Fügt zu letztem "npc.base.functions.AddTraderTrigger" zusätzliche Antwort hinzu
    functions.AddTraderTrigger("[Gg]reetings","Hiya.."); -- Fügt Triggertext mit Antwort hinzu
    functions.AddAdditionalTrigger("[Hh]ello");          -- Fügt zu letztem "npc.base.functions.AddTraderTrigger" zusätzlichen Triggertext hinzu
    functions.AddAdditionalText("Hiho");
    functions.AddTraderTrigger("[Ww]ho","Mom says "..thisNPC.name..", everyone else says dumbhead.");
    functions.AddTraderTrigger("[Ww]er","Mama sagt "..thisNPC.name..", alle anderen nennen mich Dummkopf.");
    functions.AddTraderTrigger("[Mm]om","Mom said, Daddy is a pig, the next day, he didn't return home. Now mom is gone too. I think they both turned into pigs, so I watch over them here.");
    functions.AddTraderTrigger("[Mm]ama","Mama hat gesagt, Papa ist ein Schwein. Am nächsten Tag kam er nicht mehr Heim. Jetzt ist auch Mama weg. Ich glaub sie sind jetzt beide Schweine, also passe ich hier auf sie auf.");
    functions.AddTraderTrigger("[Nn]o.+pig","Liar.");
    functions.AddTraderTrigger("[Kk]ein.+[Ss]chwein.*","Lügner.");
    functions.AddTraderTrigger("[Pp]ig","These Pigs are my friends.");
    functions.AddAdditionalText("They all have names. This one is Blinky, there is Pinky, this is Inky, and see, here's Clyde."); -- Ich mag kleine dumme Anspielungen, bin neugierig ob wer draufkommt
    functions.AddTraderTrigger("[Ss]chwein","Die Schweine sind meine Freunde.");
    functions.AddAdditionalText("Sie haben alle Namen. Da ist Blinkie, dort ist Pinkie, das da ist Inkie, und schau, hier ist Clyde.");
    functions.AddTraderTrigger("[Cc]loud","Look, another piggie-cloud.");
    functions.AddTraderTrigger("[Ww]olke","Schau, eine Schweichenwolke.");
    functions.AddTraderTrigger("[Bb]ye.","See ya.");
    functions.AddAdditionalTrigger("[Ff]arewell");
    functions.AddAdditionalText("Piggies say I should say bye to you.");
    functions.AddTraderTrigger("[Aa]uf.+[Bb]ald","Baba");
    functions.AddAdditionalTrigger("[Bb]is.+[Bb]ald");
    functions.AddAdditionalText("Die Schweinchen sagen, ich soll Wiedersehn sagen.");
    
    
    functions.AddCycleText("#me pfeift vor sich hin","#me whistles"); -- Fügt Text der alle paar Min gesagt wird hinzu
    functions.AddCycleText("#me bohrt in der Nase","#me picks his nose");
    functions.AddCycleText("#me flüstert mit einem Schwein","#me whispers with a pig");
    functions.AddCycleText("#me riecht an seinem Finger","#me smells his finger");
    functions.AddCycleText("#me rülpst","#me burps");
    functions.AddCycleText("#me furzt","#me farts");
    functions.AddCycleText("#me kichert","#me giggles");
    functions.AddCycleText("#me starrt eine Wolke an","#me stares at a cloud");
    functions.AddCycleText("Oink, Oink, meine Freunde","Oink, Oink, my friends");
    functions.AddCycleText("#me gähnt","#me yawns");
    functions.AddCycleText("#me steckt fasziniert einen Finger durch ein Loch in seiner Hose","#me finds a hole in his trousers and puts a finger through it");
    functions.AddCycleText("#me macht Spuckeblasen","#me makes spitbubbles");
    
    
    TradSpeakLang={0,1,4};  -- Sprache die der NPC spricht
    TradStdLang=0;          -- Sprache die der NPC normalerweise spricht
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
                gText="#me grinst dich blöde an";
                eText="#me grins stupidly at you";
                outText=functions.GetNLS(originator,gText,eText);
                thisNPC:talk(CCharacter.say,outText);
                verwirrt=true;
            end
        end
    end
end--function

return M
