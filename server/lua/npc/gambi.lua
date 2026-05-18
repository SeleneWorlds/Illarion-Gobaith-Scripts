local M = {}

--Name:        Gambi
--Race:        Dwarf
--Town:        Silverbrand
--Function:    Public trader
--Position:    x=80 y=-193 z=0
--Facing:      South
--Last Update: 11/30/2005
--Update by:   Nitram

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
    --            EPr ,ID  ,Am ,SPr,SA ,Qual ,Dura   ,Data,Catagory
    trader_functions.AddTraderItem( 30 ,2922,500 ,6  ,200 ,{4,6},{77,90},0   ,0       ); -- saussages dish
    trader_functions.AddTraderItem(120 , 554,500 ,20 ,100 ,{4,6},{77,90},0   ,0       ); -- wild mit beilage
    trader_functions.AddTraderItem( 20 ,  49,500 ,4  ,200 ,{3}  ,{33}   ,0   ,0       ); -- bread
    trader_functions.AddTraderItem( 10 ,3051,500 ,2  ,200 ,{3}  ,{33}   ,0   ,0       ); -- saussages
    trader_functions.AddTraderItem( 15 , 306,500 ,3  ,200 ,{3}  ,{33}   ,0   ,0       ); -- ham
    trader_functions.AddTraderItem(30  ,6   ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- scissors
    trader_functions.AddTraderItem(30  ,9   ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- saw
    trader_functions.AddTraderItem(20  ,24  ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- shovel
    trader_functions.AddTraderItem(25  ,47  ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- needle
    trader_functions.AddTraderItem(30  ,74  ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- axe
    trader_functions.AddTraderItem(30  ,126 ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- sickle
    trader_functions.AddTraderItem(30  ,271 ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- scythe
    trader_functions.AddTraderItem(30  ,311 ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- glass blow pipe
    trader_functions.AddTraderItem(30  ,737 ,500 ,2  ,300 ,{4,6},{77,90},0   ,0       ); -- chisel

    trader_functions.AddTraderItem( 10 ,2717,1000,2  ,500 ,{3}  ,{33}   ,0   ,0       ); -- pins & cutters
    trader_functions.AddTraderItem(  5 ,2738,1000,1  ,500 ,{3}  ,{33}   ,0   ,0       ); -- pins
    trader_functions.AddTraderItem(  0 , 391,500 ,5  ,0   ,{4,6},{77,90},0   ,0       ); -- torch
    trader_functions.AddTraderItem(  0 ,  92,500 ,20 ,0   ,{4,6},{77,90},0   ,0       ); -- oil lamp

    TraderCopper=10000;

    functions.AddTraderTrigger("[hH]elp","'List your wares', 'I want to buy <number> <wares>', 'I want to buy a <ware>', 'I want to sell <number|a> <wares>', 'Price of ...','What do you pay for ...', 'What wares do you buy?'");
    functions.AddTraderTrigger("[Gg]reet","Greetingsss. How i can help you?.");
    functions.AddAdditionalTrigger("[Hh]ello");
    functions.AddAdditionalTrigger("[Hh]i");
    functions.AddAdditionalText("Aye! You are interested in my wares?");
    functions.AddTraderTrigger("[Ww]hat.+sell","I sell different tools");
    functions.AddTraderTrigger("[Ww]hat.+[Tt]ool","Whatever you want: scrissors, saws, hammers, shovels, needles, axes, sickles, scythes and glas blow pipes.");
    functions.AddTraderTrigger("[Ww]ho.+[Ii]rmorom","Irmorom is the god of the dwarves, of the trade and the craftsmanship");
    functions.AddTraderTrigger("[Bb]ye","Aye! Irmorom may bless you.");
    functions.AddAdditionalTrigger("[Ff]arewell");
    functions.AddAdditionalText("Farewell. You are welcome to come back and to trade with me.");
    functions.AddTraderTrigger("[Gg]r[uü][sß]+","Aye! Was willst du?");
    functions.AddAdditionalTrigger("[Hh]allo");
    functions.AddAdditionalText("Hallo. Willst du was von meinen Waren kaufen?");
    functions.AddTraderTrigger("[Ww]as.+kauf","Ja, ich habe Verschiedene Werkzeuge.");
    functions.AddTraderTrigger("[Ww]as.+[Ww]erkzeug","Was auch immer dir helfen mag: Scheren, Sägen, Hammer, Schaufeln, Nadeln, Äxte, Sicheln, Sensen und Glasblas Rohre.");
    functions.AddTraderTrigger("[Aa]uf [Bb]ald","Ja, du kannst gern wieder herkommen, wenn du was brauchst. Irmorom sei mit dir!");
    functions.AddAdditionalTrigger("[Bb]is [Bb]ald");
    functions.AddAdditionalText("Aye! Kannst gern wieder herkommen, wenn du was brauchst.");
    functions.AddTraderTrigger("[Ww]er.+[Ii]rmorom","Irmorom ist der Gott der Zwerge, des Handels und der Handwerker");
    functions.AddTraderTrigger("'Welche Waren verkauft ihr', 'Ich möchte <Anzahl> <Ware> kaufen', 'Ich möchte <Ware> kaufen', 'Ich möchte <Anzahl> <Ware> verkaufen', 'Was ist der Preis von <Ware>','Was zahlt ihr für <Ware>', 'Was kauft ihr?'");

    TraderLang={"Gold","gold","Silber", "silver","Kupfer","copper","stücke","pieces"};
    TraderMonths={"Elos","Tanos","Zhas","Ushos","Siros","Ronas","Bras","Eldas","Irmas","Malas","Findos","Olos","Adras","Naras","Chos","Mas"};

    RefreshTime={10000,40000};

    TradSpeakLang={0,2};
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
    if (cycCount==nil) then
        cycCount=1;
        nextDelivery=math.random(10000,40000);
        thisNPC:increaseSkill(1,"common language",100);
        --thisNPC:talk(CCharacter.say, "Next delivery in "..nextDelivery);
    else
        cycCount=cycCount+1;
        --printerr("In Circle "..cycCount.. "With "..nextDelivery);
        if (math.floor(cycCount/600)==(cycCount/600)) then verwirrt=false end
        if (cycCount+1>nextDelivery+1) then
            --thisNPC:talk(CCharacter.say, "Next");
            nextDelivery=math.random(10000,40000);
            cycCount=1;
            --thisNPC:talk(CCharacter.say, "Next delivery in "..nextDelivery.." CycCount: "..cycCount);
            for itnCnt=1,#TraderItemNumber do
                refill(itnCnt);
            end
        end
    end
end

--------------------------------------------- *** DON'T EDIT BELOW HERE ***--------------------------------------

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
            end
            if (Status==2) then -- Item kann wegen Platzmangel nicht erstellt werden // Item can't created, cause of lag of space
                gText="Tut mir leid, aber Ihr habt nicht genug Platz in Eurem Inventar.";
                eText="Sorry, you do not have enough space in your inventory.";
            end
            if (Status==3) then -- Nicht genug Geld um das Item zu bezahlen // not enough money to buy the item
                gText="Kommt wieder wenn ihr genug Geld habt!";
                eText="Come back when you have enough money!";
            end
            if (Status==4) then -- Item ausverkauft // item out of stock
                gText="Tut mir leid. Ich habe das im Moment nicht. Kommt doch bitte später wieder.";
                eText="I am sorry, I don't have this currently. Come back later.";
            end
            if (Status==5) then -- Item wird nicht verkauft // item
                gText="Tut mir Leid. Ich verkaufe das nicht.";
                eText="Sorry, I do not sell that item.";
            end
            if (Status==6) then -- Verkauf eines einzelnen Items erfolgreich // npc.base.trader_functions.Selling of a single item succeed
                gText=functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." ist es, was ihr kaufen wollt? Bitte sehr, das macht"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want a "..world:getItemName(Values[2],1).."? Here you are, that makes"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            end
            if (Status==7) then -- Verkaufspreis Ansage für ein Item // selling price announcement for an item
                gText=functions.GenusSel(Values[1],"Ein","Eine","Ein").." "..world:getItemName(Values[1],0).." kostet"..trader_functions.MoneyText(0,Values[2],Values[3],Values[4],TraderLang)..".";
                eText="The "..world:getItemName(Values[1],1).." costs"..trader_functions.MoneyText(1,Values[2],Values[3],Values[4],TraderLang)..".";
            end
            if (Status==8) then -- Einkaufspreis Ansage für ein Item // buying price announcement for an item
                gText=functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." wäre mir"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang).." wert.";
                eText="I would pay"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang).." for "..Values[1]..world:getItemName(Values[2],1);
            end
            if (Status==9) then -- Einkauf von mehreren Items erfolgreich // npc.base.trader_functions.Buying of multible items succeed
                gText="Ihr wollt "..Values[1].." "..world:getItemName(Values[2],0).." verkaufen? Ich gebe euch"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want to sell "..Values[1].." "..world:getItemName(Values[2],1).."? I give you"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            end
            if (Status==10) then -- Item das gekauft werden soll nicht vorhanden // item that should be buyed is not aviable
                gText="Kommt wieder wenn ihr das habt!";
                eText="Come back when you have that!";
            end
            if (Status==11) then -- Händler hat nicht genug Geld // trader don't have enough money
                gText="Tut mir leid. Ich kann das nicht kaufen. Ich habe nicht genug Geld.";
                eText="Sorry, I cannot buy that. I do not have enough money.";
            end
            if (Status==12) then -- Händler kauft das Item nicht // trader didn't buy the item
                gText="So etwas kaufe ich nicht. Tut mir leid.";
                eText="Sorry, I do not buy that item.";
            end
            if (Status==13) then -- Einkauf eines einzelnen Items erfolgreich // npc.base.trader_functions.Buying of a single item succeed
                gText=functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." ist es, was ihr verkaufen möchtet? Ich gebe euch"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want to sell a "..world:getItemName(Values[2],1).."? I give you"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            end
            if (Status==14) then -- Liste der Waren die der NPC verkauft ist nicht leer // List of the wares the NPC sells, is not empty
                gText="Ich verkaufe Scheren, Sägen, Hammer, Schaufeln, Nadeln, Äxte, Sicheln und Glasblas Rohre.";
                eText="I sell scrissors, saws, hammers, shovels, needles, axes, sickles and glas blow pipes.";
            end
            if (Status==15) then -- Liste der Waren die der NPC verkauft ist leer // List of the wares the NPC sells, is empty
                gText="Ich verkaufe nichts.";
                eText="I do not sell anything.";
            end
            if (Status==16) then -- Liste der Waren die der NPC kauft ist nicht leer // List of the wares the NPC buys, is not empty
                gText="Ich kaufe Scheren, Sägen, Hammer, Schaufeln, Nadeln, Äxte, Sicheln, Sensen und Glasblas Rohre.";
                eText="I buy scrissors, saws, hammers, shovels, needles, axes, sickles, scythes and glas blow pipes.";
            end
            if (Status==17) then -- Liste der Waren die der NPC kauft ist leer // List of the wares the NPC buys, is empty
                gText="Ich kaufe nichts.";
                eText="I do not buy anything.";
            end
            if (Status==18) then
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
