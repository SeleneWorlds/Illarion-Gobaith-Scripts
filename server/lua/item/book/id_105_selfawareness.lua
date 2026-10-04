local M = {}

-- UPDATE common SET com_script='item.book.id_105_selfawareness' WHERE com_itemid = 105;

function M.InitRanks()
    M.AddRank("untaught","unwissend");
    M.AddRank("unskilled","ungeübt");
    M.AddRank("a beginner","ein Anfänger");
    M.AddRank("skilled","geübt");
    M.AddRank("a assistant","ein Geselle");
    M.AddRank("a master","ein Meister");
    M.AddRank("a senior master","ein Altmeister");
    M.AddRank("a grand master","ein Großmeister");
end

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if M.InitBook() then
            M.AddGermanBookText("\n \n Das Buch der \n Selbsterkenntniss",105,0);
            M.AddGermanBookText("\n   Geschrieben \n      von \n       Nitram",0,0);
            M.AddGermanBookText("\n \n        Wissen \n           der \n       Sprachen",0,0);
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der gemeinsammen Sprache aller Völker",0,"common language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Menschen",0,"human language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Zwerge",0,"dwarf language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Elfen",0,"elf language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Halblinge",0,"halfling language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Echsenmenschen",0,"lizard language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Orks",0,"orc language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Gnome",0,"gnome language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Goblins",0,"goblin language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Feen",0,"fairy language");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Sprache der Alten",0,"ancient language");

            M.AddGermanBookText("\n \n       Wissen \n           der \n       Handwerke",0,0);
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Schmiedens",23,"smithing");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Goldschmiedens",236,"goldsmithing");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Schneiderns",6,"tailoring");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Schreinerns",9,"carpentry");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Bergbaus",2763,"mining");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Kochens",227,"baking");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Anbauens",271,"peasantry");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Holzfällens",74,"lumberjacking");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Edelstein schleifens",270,"gemcutting");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Glasblasens",313,"glass blowing");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Angelns",72,"fishing");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Kräutersammelns",126,"herb lore");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst der Alchemie",58,"alchemy");

            M.AddGermanBookText("\n \n       Wissen \n           der \n       Magie",0,0);
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst der Rechersche",266,"library research");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der alten Kunst des Transformo",0,"transformo");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der alten Kunst des Transfreto",0,"transfreto");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der alten Kunst des Pervestigatio",0,"pervestigatio");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der alten Kunst des Desicio",0,"desicio");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der alten Kunst des Commotio",0,"commotio");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der alten Kunst des magischen Widerstandes",0,"magic resistance");

            M.AddGermanBookText("\n \n       Wissen \n           des \n       Kampfes",0,0);
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Benutzung von Hiebwaffen",2731,"slashing weapons");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Benutzung von Schlagwaffen",226,"concussion weapons");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Benutzung von Stichwaffen",192,"puncture weapons");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Benutzung von Fernwaffen",2708,"distance weapons");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Anwendung des Ringens",0,"wrestling");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Vergiftens",2668,"poisoning");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Anwendung von Taktik",0,"tactics");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Ausweichens",0,"dodge");
            M.AddGermanBookText("\n Es scheint als seid ihr ~level~ in der Kunst des Parierens",0,"parry");

            M.AddEnglishBookText("\n \n The book of \n Selfawareness",105,0);
            M.AddEnglishBookText("\n   written \n      by \n       Nitram",0,0);
            M.AddEnglishBookText("\n \n        Knowledge \n         of the \n      Languages",0,0);
            M.AddEnglishBookText("\n It seems you are ~level~ in the common language of all races",0,"common language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the humans",0,"human language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the dwarfs",0,"dwarf language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the elves",0,"elf language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the halflings",0,"halfling language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the lizards",0,"lizard language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the orcs",0,"orc language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the gnomes",0,"gnome language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the goblins",0,"goblin language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the fairies",0,"fairy language");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Language of the ancients",0,"ancient language");

            M.AddEnglishBookText("\n \n       Knowledge \n         of \n       Crafting",0,0);
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of smithing",23,"smithing");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of gold smithing",236,"goldsmithing");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of tailoring",6,"tailoring");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of carpentry",9,"carpentry");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of mining",2763,"mining");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of baking",227,"baking");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of peasantry",271,"peasantry");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of lumberjacking",74,"lumberjacking");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of gemcutting",270,"gemcutting");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of glass blowing",313,"glass blowing");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of fishing",72,"fishing");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of herb loreing",126,"herb lore");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of alchemy",58,"alchemy");

            M.AddEnglishBookText("\n \n       Wissen \n           der \n       Magie",0,0);
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of library research",266,"library research");
            M.AddEnglishBookText("\n It seems you are ~level~ in the ancient Art of transformo",0,"transformo");
            M.AddEnglishBookText("\n It seems you are ~level~ in the ancient Art of transfreto",0,"transfreto");
            M.AddEnglishBookText("\n It seems you are ~level~ in the ancient Art of pervestigatio",0,"pervestigatio");
            M.AddEnglishBookText("\n It seems you are ~level~ in the ancient Art of desicio",0,"desicio");
            M.AddEnglishBookText("\n It seems you are ~level~ in the ancient Art of commotio",0,"commotio");
            M.AddEnglishBookText("\n It seems you are ~level~ in the ancient Art of magic resistance",0,"magic resistance");

            M.AddEnglishBookText("\n \n       Wissen \n           des \n       Kampfes",0,0);
            M.AddEnglishBookText("\n It seems you are ~level~ in the using of slashing weapons",2731,"slashing weapons");
            M.AddEnglishBookText("\n It seems you are ~level~ in the using of concussion weapons",226,"concussion weapons");
            M.AddEnglishBookText("\n It seems you are ~level~ in the using of puncture weapons",192,"puncture weapons");
            M.AddEnglishBookText("\n It seems you are ~level~ in the using of distance weapons",2708,"distance weapons");
            M.AddEnglishBookText("\n It seems you are ~level~ in the using of wrestling",0,"wrestling");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of poisoning",2668,"poisoning");
            M.AddEnglishBookText("\n It seems you are ~level~ in the using of tactics",0,"tactics");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of dodge",0,"dodge");
            M.AddEnglishBookText("\n It seems you are ~level~ in the Art of parry",0,"parry");
        end
        M.SendBookPage(User,Counter)
        User:learn(4,"library research",2,100)
    end
end

function M.AddRank(eName,gName)
    table.insert(Rank,{eName,gName});
end

function M.InitBook()
    if (gBookText==nil) then
        gBookText={};
        eBookText={};
        return true
    else
        return false
    end
end

function M.AddGermanBookText(Text,ItemID,Diff)
    M.AddToTable(gBookText,Text,ItemID,Diff)
end

function M.AddEnglishBookText(Text,ItemID,Diff)
    M.AddToTable(eBookText,Text,ItemID,Diff)
end

function M.SendBookPage(User,Counter)
    local BookTexts=nil;
    if (User:getPlayerLanguage()==0) then
        BookTexts=gBookText;
    else
        BookTexts=eBookText;
    end
    local pages=#BookTexts;
    local SendText=BookTexts[math.min(Counter,pages)][1];
    local PicID=BookTexts[math.min(Counter,pages)][2];
    if (SendText==nil) then SendText="" end
    if (PicID==nil) then PicID=0 end
    SendText=M.ModifyText(User,SendText,BookTexts[math.min(Counter,pages)][3])
    User:inform("#b|"..math.min(Counter,pages).."|"..PicID.."|"..SendText);
end

function M.AddToTable(TargetList,Text,ItemID,Difficult)
    local done=false;
    local outputted=false;
    repeat
        Len=string.len(Text)
        if (Len>200) then
            i=201;
            outputted=false;
            repeat
                i=i-1;
                Char=string.sub(Text,i,i);
                if (Char==" ") then
                    outText=string.sub(Text,1,i-1);
                    Text=string.sub(Text,i+1,Len);
                    table.insert(TargetList,{outText,ItemID,Difficult});
                    outputted=true;
                end
            until i==0 or outputted;
            if (Len==string.len(Text)) then
                outText=string.sub(Text,1,200);
                Text=string.sub(Text,201,Len);
                table.insert(TargetList,{outText,ItemID,Difficult});
            end
        else
            done=true;
            table.insert(TargetList,{Text,ItemID,Difficult});
        end
    until done
end

function M.ModifyText(User,Text,Skillname)
    if (vocals==nil) then
        vocals={65,69,73,79,85};
    end
    local retText="";
    local Skill=0;
    if (Skillname~=0) then Skill=User:getSkill(Skillname) end;
    local Level=math.floor((Skill/100)*#Rank-1)+1;
    return string.gsub(Text,"~level~",Rank[Level][2]);
end

return M
