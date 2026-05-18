local M = {}

--Name:        	Gloria
--Race:       	Human
--Town:        	Magic academy
--Function:    	Restricted trader
--Position:    	x=58 y=58 z=50
--Facing:      	South
--Create		09.06.08
--Create by		Kadiya
--Last Update:
--Update by:

local trader_functions = require("npc.base.trader_functions")
local functions = require("npc.base.functions")
function M.useNPC(user,counter,param)
    local lang=user:getPlayerLanguage();
    thisNPC:increaseSkill(1,"common language",100);
    if (lang==0) then thisNPC:talk(CCharacter.say, "Finger weg!") end
    if (lang==1) then thisNPC:talk(CCharacter.say, "Don't you touch me!") end
end

function M.initializeNpc()
    functions.InitTalkLists()
    trader_functions.InitItemLists()

    thisNPC:increaseSkill(1,"common language",100);
    --------------------------------------------- *** EDIT BELOW HERE ***--------------------------------------
    -- Epr	= Verkaufpreis
    -- ID
    -- Am 	= Amount (Idealmenge, die der Char haben sollte. Ist die Echte Menge darüber, so sinkt der Einkaufspreis.)
    -- SPr 	= Ankaufpreis
    -- SA 	= Anzahl auf Lager
    -- Qual	= Qualität
    -- Dura	= Haltbarkeit
    -- Data	= Datawert
    -- Catagory

    -- NPC verkauft Essen und trinken in der Mensa
    --
    --            EPr ,ID  ,Am,SPr,SA,Qual ,Dura   ,Data,Catagory
    trader_functions.AddTraderItem(15  ,2057,100,0 ,10,{4,6},{33,66},0   ,0       ); --glass with red wine
    trader_functions.AddItemTrigger( "[Ww]ein" );
    trader_functions.AddItemTrigger( "wine" );
    trader_functions.AddTraderItem(11  ,2058,100,0 ,10,{4,6},{33,66},0   ,0       ); --glass with water
    trader_functions.AddItemTrigger( "[Ww]asser" );
    trader_functions.AddItemTrigger( "water" );
    trader_functions.AddTraderItem(15  ,2059,100,0 ,10,{4,6},{33,66},0   ,0       ); --glass with cider
    trader_functions.AddItemTrigger( "[Cc]ider" );
    trader_functions.AddTraderItem(15  ,2056,50 ,0 ,20,{4,6},{33,66},0   ,0       ); --glass with mead
    trader_functions.AddItemTrigger( "[Mm]et" );
    trader_functions.AddItemTrigger( "mead" );
    trader_functions.AddTraderItem(15  ,1909,100,0 ,10,{4,6},{33,66},0   ,0       ); --beer mug
    trader_functions.AddItemTrigger( "[Bb]ier" );
    trader_functions.AddItemTrigger( "beer" );

    trader_functions.AddTraderItem(30  , 49 ,15,0  ,15,{3}  ,{33}   ,0   ,0       ); -- Brot
    trader_functions.AddTraderItem(20  ,191 ,8 ,0  ,8 ,{5,7},{55,77},0   ,0       ); -- Brötchen
    trader_functions.AddTraderItem(20  ,306 ,5 ,0  ,5 ,{5,7},{55,77},0   ,0       ); -- Schinken
    trader_functions.AddTraderItem(120 ,2276,15,0  ,15,{3}  ,{33}   ,0   ,0       ); -- Eintopf
    trader_functions.AddTraderItem(150 ,555 ,8 ,0  ,8 ,{5,7},{55,77},0   ,0       ); -- Hasenbraten

    trader_functions.AddTraderItem(100 ,2744 ,10,0 ,10,{3}  ,{33}   ,0   ,0    	 ); -- Pfeife
    trader_functions.AddTraderItem(5   ,155  ,8 ,0 ,8 ,{5,7},{55,77},0   ,0       ); -- Sibanac Blatt
    trader_functions.AddItemTrigger( "[Ss]ibanac" );

-- Er kauft dafür Getränkeflaschen an, sowie die leere Gläser und Teller zum Spottpreis zurück
    trader_functions.AddTraderItem(0   ,2055 ,5 ,2 ,5 ,{3}  ,{33}   ,0   ,0       ); -- Glas
    trader_functions.AddItemTrigger( "[Gg]l[aä]s." );
    trader_functions.AddTraderItem(0   ,2952 ,5 ,3 ,5 ,{3}  ,{33}   ,0   ,0       ); -- Teller
    trader_functions.AddTraderItem(0   ,2935 ,5 ,3 ,5 ,{3}  ,{33}   ,0   ,0       ); -- Schalen
    trader_functions.AddTraderItem(0   ,2497 ,50,5 ,40,{4,6},{33,66},0   ,0       ); --orange bottle
    trader_functions.AddItemTrigger( "[Ff]lasche.+[Mm]et" );
    trader_functions.AddItemTrigger( "[Mm]et.*[Ff]lasche" );
    trader_functions.AddItemTrigger( "bottle.+meat" );
    trader_functions.AddTraderItem(0  ,2499  ,50,5 ,20,{4,6},{33,66},0   ,0       ); --green bottle
    trader_functions.AddItemTrigger( "[Ff]lasche.+[Cc]ider" );
    trader_functions.AddItemTrigger( "[Cc]ider.*[Ff]lasche" );
    trader_functions.AddItemTrigger( "bottle.+cider" );
    trader_functions.AddTraderItem(0  ,2500  ,50,5 ,20,{4,6},{33,66},0   ,0       ); --red bottle
    trader_functions.AddItemTrigger( "[Ff]lasche.+[Ww]ein" );
    trader_functions.AddItemTrigger( "[Ww]ein.*[Ff]lasche" );
    trader_functions.AddItemTrigger( "bottle.+wine" );
    trader_functions.AddTraderItem(0  ,2501  ,50,5 ,20,{4,6},{33,66},0   ,0       ); --black bottle
    trader_functions.AddItemTrigger( "[Ff]lasche.+[Bb]ier" );
    trader_functions.AddItemTrigger( "[Bb]ier.*[Ff]lasche" );
    trader_functions.AddItemTrigger( "bottle.+beer" );

    TraderCopper=1000;

    functions.AddTraderTrigger("[Gg]reetings","Welcome. Can I help you?");
    functions.AddAdditionalTrigger("[Hh]ello");
    functions.AddAdditionalTrigger("[Hh]i");
    functions.AddAdditionalText("A good day to you.");
    functions.AddTraderTrigger("[Yy]ou.+[Tt]rader","I am "..thisNPC.name..", I sell some usefull things. Do you need something?");
    functions.AddTraderTrigger("[Tt]ell.+[Aa]cademy","I'm not good in history. If you want to now something of the magic academy better ask someone else.");
    functions.AddTraderTrigger("[Ww]hat.+sell","I sell everything you need for a enjoyable break. You should not learn with a empty stomach.");
    functions.AddTraderTrigger("[Gg]oodbye","You are going? Good luck for your studies.");
    functions.AddAdditionalTrigger("[Bb]ye");
    functions.AddAdditionalText("Take care of you.");
    functions.AddAdditionalTrigger("[Ff]arewell");
    functions.AddAdditionalText("Farewell. I hope you will come back soon.");
    functions.AddTraderTrigger("[Ww]hat.+buy","I buy bottles with drinks and also the empty glasses and plates back.");
    functions.AddTraderTrigger("[Ww]ho.+you?","My name is "..thisNPC.name..".");
    functions.AddTraderTrigger("I'm .+","Nice to meet you. Did you need anything?");
    functions.AddTraderTrigger("[hH]elp","'List your wares', 'I want to buy <number> <wares>', 'I want to buy a <ware>', 'I want to sell <number|a> <wares>', 'Price of ...','What do you pay for ...', 'What wares do you buy?'");

    functions.AddTraderTrigger("[Gg]r[üu][ßs]+","Seid gegrüßt. Kann ich euch behilflich sein?");
    functions.AddAdditionalTrigger("[Hh]allo");
    functions.AddAdditionalText("Guten Tag.");
    functions.AddTraderTrigger("[Dd]u.+[Hh]ändler","Ich bin "..thisNPC.name..". Ich verkaufe einige nützliche Dinge hier. Braucht ihr etwas?");
    functions.AddTraderTrigger("[Ww]as.+verkauf","Ich verkaufe alles, was ihr für eine angenehme Pause braucht. Man sollte schließlich nicht auf hungrigem Magen studieren.");
    functions.AddTraderTrigger("[Ee]rzähl.+[Aa]kademie","Ich bin nicht so gut in Geschichte. Am besten fragt ihr deswegen jemand anderes.");
    functions.AddTraderTrigger("[Aa]uf.+[Bb]ald","Willst du schon gehen? Viel Glück bei deinen Studien.");
    functions.AddAdditionalTrigger("[Bb]is.+[Bb]ald");
    functions.AddAdditionalText("Du gehst schon? Gib auf dich acht, ich hoffe wir sehen uns bald wieder");
    functions.AddTraderTrigger("[Ww]as .+%s[Kk]auf","Ich kaufe Getränke an und auch die leeren Gläser und Teller zurück.");
    functions.AddTraderTrigger("[Ww]er.+[DdIi][uh]r*?","Ich werde "..thisNPC.name.." genannt.");
    functions.AddTraderTrigger("[Hh]ilfe","'Welche Waren verkauft ihr', 'Ich möchte <Anzahl> <Ware> kaufen', 'Ich möchte <Ware> kaufen', 'Ich möchte <Anzahl> <Ware> verkaufen', 'Was ist der Preis von <Ware>','Was zahlt ihr für <Ware>', 'Was kauft ihr?'");

	functions.AddCycleText("#me notiert ein paar Zahlen auf ein Stück Pergament.","#me notes a few numbers on a piece of pergament.");
    functions.AddCycleText("#me sortiert ein paar Dinge in ihrer Truhe neu.","#me rearranges some things in her chest. ");

    TraderLang={"Gold","gold","Silber", "silver","Kupfer","copper","stücke","pieces"};
    TraderMonths={"Elos","Tanos","Zhas","Ushos","Siros","Ronas","Bras","Eldas","Irmas","Malas","Findos","Olos","Adras","Naras","Chos","Mas"};

    RefreshTime={10000,40000};

    TradSpeakLang={0,1,10};
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
        TraderStdCopper=TraderCopper;
        thisNPC.activeLanguage=TradStdLang;
    end
    trader_functions.TraderCycle();
    functions.SpeakerCycle();
end

function M.receiveText(texttype, message, originator)
    if functions.BasicNPCChecks(originator,2) then
        if (functions.LangOK(originator,TradSpeakLang)==true) then
            thisNPC.activeLanguage=originator.activeLanguage;
            Status,Values=trader_functions.SayPriceSell(originator, message)
            if (Status==0) then Status,Values=trader_functions.SayPriceBuy(originator, message) end
            if (Status==0) then Status,Values=trader_functions.ShowItemList(originator, message) end
            if (Status==0) then Status,Values=trader_functions.Selling(originator, message) end
            if (Status==0) then Status,Values=trader_functions.Buying(originator, message) end
            if (Status==0) then Status,Values=functions.TellDate(originator, message, TraderMonths) end
            if (Status==0) then functions.TellSmallTalk(message) end

            ----------------------------EDIT BELOW HERE-----------------------------------
            if (Status==1) then -- Verkauf von mehreren Items erfolgreich // npc.base.trader_functions.Selling of multible items succeed
                gText="Ihr möchtet "..Values[1].." "..world:getItemName(Values[2],0).." kaufen? Bitte sehr, macht dann"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want "..Values[1].." "..world:getItemName(Values[2],1).."? Here you are, that makes"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==2) then -- Item kann wegen Platzmangel nicht erstellt werden // Item can't created, cause of lag of space
                gText="Tut mir leid, aber ihr habt nicht genug Platz in eurem Inventar.";
                eText="Sorry, you do not have enough spacess in your inventory.";
            elseif (Status==3) then -- Nicht genug Geld um das Item zu bezahlen // not enougth money to buy the item
                gText="Kommt wieder wenn ihr genug Geld habt!";
                eText="Come back when you have enough money!";
            elseif (Status==4) then -- Item ausverkauft // item out of stock
                gText="Tut mir leid. Ich habe das im Moment nicht. Kommt doch bitte später wieder.";
                eText="I am sorry, I don't have this currently. Come back later.";
            elseif (Status==5) then -- Item wird nicht verkauft // item
                gText="Tut mir Leid. Ich verkaufe das nicht.";
                eText="Sorry, I do not sell that item.";
            elseif (Status==6) then -- Verkauf eines einzelnen Items erfolgreich // npc.base.trader_functions.Selling of a single item succeed
                gText=functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." ist es, was ihr kaufen wollt? Bitte sehr, das macht"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want a "..world:getItemName(Values[2],1).."? Here you are, that makes"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==7) then -- Verkaufspreis Ansage für ein Item // selling price announcement for an item
                gText=functions.GenusSel(Values[1],"Ein","Eine","Ein").." "..world:getItemName(Values[1],0).." kostet"..trader_functions.MoneyText(0,Values[2],Values[3],Values[4],TraderLang)..".";
                eText="The "..world:getItemName(Values[1],1).." costs"..trader_functions.MoneyText(1,Values[2],Values[3],Values[4],TraderLang)..".";
            elseif (Status==8) then -- Einkaufspreis Ansage für ein Item // buying price announcement for an item
                gText=functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." wäre mir"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang).." wert.";
                eText="I would pay"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang).." for "..Values[1]..world:getItemName(Values[2],1);
            elseif (Status==9) then -- Einkauf von mehreren Items erfolgreich // npc.base.trader_functions.Buying of multible items succeed
                gText="Ihr wollt "..Values[1].." "..wTraderItemNameD[Values[2]].." verkaufen? Ich gebe euch"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want to sell "..Values[1].." "..TraderItemNameE[Values[2]].."? I give you"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==10) then -- Item das gekauft werden soll nicht vorhanden // item that should be buyed is not aviable
                gText="Kommt wieder wenn ihr das habt!";
                eText="Come back when you have that!";
            elseif (Status==11) then -- Händler hat nicht genug Geld // trader don't have enougth money
                gText="Tut mir leid. Ich kann das nicht kaufen. Ich habe nicht genug Geld.";
                eText="Sorry, I cannot buy that. I do not have enough money.";
            elseif (Status==12) then -- Händler kauft das Item nicht // trader didn't buy the item
                gText="So etwas kaufe ich nicht. Tut mir leid.";
                eText="Sorry, I do not buy that item.";
            elseif (Status==13) then -- Einkauf eines einzelnen Items erfolgreich // npc.base.trader_functions.Buying of a single item succeed
                gText=functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." ist es, was ihr verkaufen möchtet? Ich gebe euch"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want to sell a "..world:getItemName(Values[2],1).."? I give you"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==14) then -- Liste der Waren die der NPC verkauft ist nicht leer // List of the wares the NPC sells, is not empty
                gText="Ich verkaufe alles, was ihr für eine angenehme Pause braucht. Man sollte schließlich nicht mit leerem Magen studieren.";
                eText="I sell potions, snacks and ink.";
            elseif (Status==15) then -- Liste der Waren die der NPC verkauft ist leer // List of the wares the NPC sells, is empty
                gText="Ich verkaufe nichts.";
                eText="I sell nothing.";
            elseif (Status==16) then -- Liste der Waren die der NPC kauft ist nicht leer // List of the wares the NPC buys, is not empty
                gText="Ich kaufe Getränke, aber auch die leeren Gläser und Teller zurück.";
                eText="I buy empty bottles and ink.";
            elseif (Status==17) then -- Liste der Waren die der NPC kauft ist leer // List of the wares the NPC buys, is empty
                gText="Ich kaufe nichts.";
                eText="I buy nothing.";
            elseif (Status==18) then
                gText="Es ist der "..Values[1]..". Tag des Monates "..Values[2].." im Jahre "..Values[3]..".";
                local seleced=math.random(1,2)
                if (seleced==1) then
                    eText="It's day "..Values[1].." of "..Values[2].." of the year "..Values[3]..".";
                elseif (seleced==2) then
                    eText="It's the "..functions.EnglDigit(Values[1]).." of "..Values[2].." of the year "..Values[3]..".";
                end
            end

            if (Status~=0) then
                outText=functions.GetNLS(originator,gText,eText);
                thisNPC:talk(CCharacter.say,outText);
            end

            ---------------------------------- DON'T EDIT BELOW HERE ------------------------------
            if (string.find(message,"[sS]tatus")~=nil and originator:isAdmin()==true) then
                thisNPC:talk(CCharacter.say,"Copper="..TraderCopper ..", next delivery: "..nextDelivery.."cycCount:"..cycCount);
                statusString="Wares: ";
                for itnCnt=1,#TraderItemId do
                    if string.len(statusString)+string.len(world:getItemName(TraderItemId[itnCnt],1))>240 then    -- line too long
                        originator:inform(statusString);                     -- say everything until here
                        statusString="";
                    end
                    statusString=statusString..world:getItemName(TraderItemId[itnCnt],1).."="..TraderItemNumber[itnCnt]..", ";
                end
                originator:inform(statusString);
            end
            if (string.find(message,"[Rr]efill")~=nil and originator:isAdmin()==true) then
                for itnCnt=1,#TraderItemId do
                    refill(itnCnt);
                    if (TraderCopper<TraderStdCopper) then TraderCopper=TraderStdCopper end
                end
            end -- string find buy/sell/list...
            thisNPC.activeLanguage=TradStdLang;
        else
            if (verwirrt==false) then
                gText="#me sieht dich leicht verwirrt an";
                eText="#me looks at you a little confused";
                outText=functions.GetNLS(originator,gText,eText);
                thisNPC:talk(CCharacter.say,outText);
                verwirrt=true;
            end
        end
    end
end--function

return M
