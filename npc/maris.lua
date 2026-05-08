local M = {}

--Name:        Maris Maroqu
--Race:        Human
--Town:        Trolls Bane
--Function:    Public trader
--Position:    x=-107 y=-117 z=0
--Facing:      West
--Last Update: 03/11/2008
--Update by:   Lennier

local trader_functions = require("npc.base.trader_functions")
local functions = require("npc.base.functions")
function M.useNPC(user,counter,param)
    -- logToFile("start useNPC (maris)");
    local value = M.useNPC_debug(user,counter,param)
    -- logToFile("end useNPC (maris)");
    return value;
end

function M.useNPC_debug(user,counter,param)
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
    --            EPr ,ID  ,Am,SPr,SA,Qual ,Dura   ,Data,Catagory
    trader_functions.AddTraderItem(5   ,176 ,100,0  ,100,{3}  ,{33}   ,0   ,0     ); -- grey cloth
    trader_functions.AddTraderItem(9   ,174 , 70,1  ,100,{3}  ,{33}   ,0   ,0     ); -- red cloth
    trader_functions.AddTraderItem(9   ,175 , 70,1  ,100,{3}  ,{33}   ,0   ,0     ); -- black cloth
    trader_functions.AddTraderItem(9   ,179 , 70,1  ,100,{3}  ,{33}   ,0   ,0     ); -- blue cloth
    trader_functions.AddTraderItem(9   , 54 , 70,1  ,100,{3}  ,{33}   ,0   ,0     ); -- green cloth
    trader_functions.AddTraderItem(9   ,177 , 70,1  ,100,{3}  ,{33}   ,0   ,0     ); -- yellow cloth
    trader_functions.AddTraderItem(5   ,50  ,500,0  ,500,{3}  ,{33}   ,0   ,0     ); -- thread
    trader_functions.AddTraderItem(20  ,47  , 30,0  , 30,{4,6},{77,90},0   ,0     ); -- needle
    trader_functions.AddTraderItem(20  , 6  , 30,0  , 30,{4,6},{77,90},0   ,0     ); -- scissor
    trader_functions.AddTraderItem(30  ,2295, 11,2  , 20,{4,6},{44,66},0   ,0     ); -- cloth gloves
    trader_functions.AddTraderItem(100 ,385 , 10,10 , 20,{4,6},{44,66},0   ,0     ); -- blue dress
    trader_functions.AddTraderItem(40  ,34  , 10,4  , 20,{4,6},{44,66},0   ,0     ); -- black trousers
    trader_functions.AddTraderItem(30  ,180 , 10,3  , 20,{4,6},{44,66},0   ,0     ); -- red shirt
    trader_functions.AddTraderItem(30  ,182 , 10,3  , 20,{4,6},{44,66},0   ,0     ); -- black shirt
    trader_functions.AddTraderItem(30  ,55  , 10,3  ,20,{4,6},{44,66},0   ,0      ); -- green robe
    trader_functions.AddTraderItem(70  ,2380, 10,7  ,20,{4,6},{44,66},0   ,0      ); -- blue coat

    TraderCopper=1000;

    functions.AddTraderTrigger("[Gg]reetings","Greetings");
    functions.AddAdditionalTrigger("[Hh]ello");
    functions.AddAdditionalText("Hello");
    functions.AddTraderTrigger("[Gg]r[uü][sß]+","Grüß euch");
    functions.AddAdditionalTrigger("[Hh]allo");
    functions.AddAdditionalText("Hallo");
    functions.AddTraderTrigger("[Ww]hat.+sell","I sell grey and fine dyed cloth, red and black shirts, cloth gloves, blue dresses and coats, black trousers, needles, scissors and thread.");
    functions.AddTraderTrigger("[Ww]as.+verkauf","Ich verkaufe graue und gefärbte Stoffe, rote und schwarze Hemden, Stoffhandschuhe, blaue Kleider und Mäntel, schwarze Hose, Nadeln, Scheren und Garn.");
    functions.AddTraderTrigger("[Ww]hat.+buy","I buy dyed cloth, red and black shirts, cloth gloves, blue dresses and coats and black trousers.");
    functions.AddTraderTrigger("[Ww]as.+%skauf","Ich kaufe gefärbten Stoff, rote, blaue und schwarze Hemden, Stoff Handschuhe, blaue Kleider und schwarze Hosen.");
    functions.AddTraderTrigger("[Ww]ho.+you","I'm Maris Maroqué, tailor and trader of tailor needs");
    functions.AddTraderTrigger("[Ww]er.+[DdIi][uh]r*","Ich bin Maris Maroqué, Schneider und Händler für Schneidereibedarf.");
    functions.AddTraderTrigger("[Dd]yer","No, I'm not a dyer. Can't tell you any secrets.");
    functions.AddTraderTrigger("[Ff]ärber","Nein. Ich bin kein Färber. Ich kann dir keine Geheimnisse verraten.");
    functions.AddTraderTrigger("[Tt]ailor","Yes, I'm a tailor. If you want to be too, buy needle and scissor, thread and cloth and work with the tailoring table in the workshop.");
    functions.AddTraderTrigger("[Ss]chneider","Ja, ich bin Schneider. Wenn du selbst einer werden willst, besorg die Schere und Nadel, Garn und Stoff und arbeite am Schneidertisch in der Werkstatt.");
    functions.AddTraderTrigger("[Ww]orkshop","Yes, the workshop is in the western part of the town. There you also can find tools for tailors: a tailoring table, a spinning wheel and a loom");
    functions.AddTraderTrigger("[Ww]erkstatt","Ja, die Werkstatt befindet sich im westlichen teil der Stadt. Da findest du auch als Schneider Werkzeuge: Schneidertisch, Spinnrad und Webstuhl.");
	functions.AddTraderTrigger("[Ii]'m.+","Lovely to meet you. Care to buy anything?");
    functions.AddTraderTrigger("[Ii]ch.+[Bb]in","Freut mich euch kennen zu lernen. Wollt ihr etwas kaufen?");
    functions.AddTraderTrigger("[Ff]arewell","Farewell");
    functions.AddAdditionalTrigger("[Gg]oodbye");
    functions.AddAdditionalText("Come back soon");
    functions.AddTraderTrigger("[Bb]is.+[Bb]ald","Auf bald");
    functions.AddAdditionalTrigger("[Aa]uf.+[Bb]ald");
    functions.AddAdditionalText("Auf bald");
    functions.AddTraderTrigger("[hH]elp","'List your wares', 'I want to buy <number> <wares>', 'I want to buy a <ware>', 'I want to sell <number|a> <wares>', 'Price of ...','What do you pay for ...', 'What wares do you buy?'");
    functions.AddTraderTrigger("[Hh]ilfe","'Welche Waren verkauft ihr', 'Ich möchte <Anzahl> <Ware> kaufen', 'Ich möchte <Ware> kaufen', 'Ich möchte <Anzahl> <Ware> verkaufen', 'Was ist der Preis von <Ware>','Was zahlt ihr für <Ware>', 'Was kauft ihr?'");

    TraderLang={"Gold","gold","Silber", "silver","Kupfer","copper","stücke","pieces"};
    TraderMonths={"Elos","Tanos","Zhas","Ushos","Siros","Ronas","Bras","Eldas","Irmas","Malas","Findos","Olos","Adras","Naras","Chos","Mas"};

    RefreshTime={10000,40000};

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

--------------------------------------------- *** DON'T EDIT BELOW HERE ***--------------------------------------

function M.nextCycle()  -- ~10 times per second
    -- logToFile("start nextCycle (maris)");
    local value = M.nextCycle_debug()
    -- logToFile("end nextCycle (maris)");
    return value;
end

function M.nextCycle_debug()
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
    -- logToFile("start receiveText (maris)");
    local value = M.receiveText_debug(texttype, message, originator)
    -- logToFile("end receiveText (maris)");
    return value;
end

function M.receiveText_debug(texttype, message, originator)
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
                gText="Tut mir leid, aber Ihr habt nicht genug Platz in Eurem Inventar.";
                eText="Sorry, you do not have enough space in your inventory.";
            elseif (Status==3) then -- Nicht genug Geld um das Item zu bezahlen // not enough money to buy the item
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
                gText="Ihr wollt "..Values[1].." "..world:getItemName(Values[2],0).." verkaufen? Ich gebe euch"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want to sell "..Values[1].." "..world:getItemName(Values[2],1).."? I give you"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==10) then -- Item das gekauft werden soll nicht vorhanden // item that should be buyed is not aviable
                gText="Kommt wieder wenn ihr das habt!";
                eText="Come back when you have that!";
            elseif (Status==11) then -- Händler hat nicht genug Geld // trader don't have enough money
                gText="Tut mir leid. Ich kann das nicht kaufen. Ich habe nicht genug Geld.";
                eText="Sorry, I cannot buy that. I do not have enough money.";
            elseif (Status==12) then -- Händler kauft das Item nicht // trader didn't buy the item
                gText="So etwas kaufe ich nicht. Tut mir leid.";
                eText="Sorry, I do not buy that item.";
            elseif (Status==13) then -- Einkauf eines einzelnen Items erfolgreich // npc.base.trader_functions.Buying of a single item succeed
                gText=functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." ist es, was ihr verkaufen möchtet? Ich gebe euch"..trader_functions.MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want to sell a "..world:getItemName(Values[2],1).."? I give you"..trader_functions.MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==14) then -- Liste der Waren die der NPC verkauft ist nicht leer // List of the wares the NPC sells, is not empty
                gText="Ich verkaufe grauen und gefärbten Stoff, rote und schwarze Hemden, Stoffhandschuhe, blaue Kleider und Mäntel, schwarze Hosen, Nadeln, Scheren und Garn.";
                eText="I sell fine grey and dyed cloth, red and black shirts, cloth gloves, blue dress and coats, black trousers, needles, scissors and thread.";
            elseif (Status==15) then -- Liste der Waren die der NPC verkauft ist leer // List of the wares the NPC sells, is empty
                gText="Ich verkaufe nichts.";
                eText="I do not sell anything.";
            elseif (Status==16) then -- Liste der Waren die der NPC kauft ist nicht leer // List of the wares the NPC buys, is not empty
                gText="Ich kaufe gefärbten Stoff, rote und schwarze Hemden, Stoffhandschuhe, blaue Kleider und Mäntel und schwarze Hosen.";
                eText="I buy dyed cloth, red and black shirts, cloth gloves, blue dress and coats and black trousers.";
            elseif (Status==17) then -- Liste der Waren die der NPC kauft ist leer // List of the wares the NPC buys, is empty
                gText="Ich kaufe nichts.";
                eText="I do not buy anything.";
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
        else
            if (verwirrt==false) then
                gText="#me sieht dich leicht verwirrt an";
                eText="#me looks at you a little confused";
                outText=functions.GetNLS(originator,gText,eText);
                thisNPC:talk(CCharacter.say,outText);
                verwirrt=true;
            end
        end
    end --id
end--function

return M
