local M = {}

--Name:	       Norbert        
--Race:        Mensch
--Town:        Magische Akademie - Denkgarten
--Function:    Zahlenrätsel
--Position:    x=63 y=65 z=51
--Facing:      West
--Last Update: 16/06/2008
--Update by:   Kadiya

local functions = require("npc.base.functions")
local autonpcfunctions = require("npc.base.autonpcfunctions")
local basics = require("magic.base.basics");
function M.useNPC(user,counter,param)
    local lang=user:getPlayerLanguage();
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "#me kuschelt sich an "..user.name.." an.");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "#me cuddles up to "..user.name..".");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.functions.InitTalkLists()

    thisNPC:increaseSkill(1,"common language",100);
    
    -- ********* START DYNAMIC PART ********

    autonpcfunctions.functions.AddCycleText("","");
    autonpcfunctions.functions.AddCycleText("","");
    autonpcfunctions.functions.AddCycleText("","");

    autonpcfunctions.functions.AddTraderTrigger("[Gg]rü[sß]","Ich grüße euch.");
    autonpcfunctions.functions.AddAdditionalTrigger("[Hh]allo");
    autonpcfunctions.functions.AddAdditionalTrigger("[Gg]rue[sß]");
    autonpcfunctions.functions.AddAdditionalTrigger("[Tt]a[gc].*");
    autonpcfunctions.functions.AddAdditionalText("Seid gegrüßt!");
    autonpcfunctions.functions.AddTraderTrigger("[Aa]uf [Bb]ald","Auf bald und sichere Wege.");
    autonpcfunctions.functions.AddAdditionalTrigger("[Gg]ötter.+euch");
    autonpcfunctions.functions.AddAdditionalTrigger("[Bb]is.+[Bb]ald");
    autonpcfunctions.functions.AddAdditionalTrigger("[Uu]ff.+[Bb]ald");
    autonpcfunctions.functions.AddAdditionalTrigger("[Ff]ünf.+euch");
    autonpcfunctions.functions.AddTraderTrigger("[Ww]er [bs][ie][si][td] [di][uh].*","Ich bin "..thisNPC.name..": Ich lebe in der magischen Akademie und forsche hier im Fachgebiet der Beschwörungsmagie.");
    autonpcfunctions.functions.AddAdditionalTrigger("[Ww]ie.+[Nn]ame");
    autonpcfunctions.functions.AddTraderTrigger("[Hh]ilfe","Willst du trainieren? Wenn möchtest beschwöre ich dir auf dem Arenafeld eine Kreatur zum üben.");
    autonpcfunctions.functions.AddTraderTrigger("[Kk]reatur","Du möchtest eine Kreatur zum trainieren? Sag mir, ob du eine harmlose oder eine aggressive möchtest.");
    autonpcfunctions.functions.AddTraderTrigger("[Ss]tudent","Oh...Es tut mir leid, aber ich nehme keine Studenten an.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.functions.AddTraderTrigger("[Ss]chüler","Ich unterrichte nicht.");
    autonpcfunctions.AddCondition("lang","german");

    autonpcfunctions.functions.AddTraderTrigger("[Gg]reeting","Greetings to you!");
    autonpcfunctions.functions.AddAdditionalTrigger("[Hh]ello");
    autonpcfunctions.functions.AddAdditionalText("Greetings");
    autonpcfunctions.functions.AddTraderTrigger("[Gg]oodbye","Farewell.");
    autonpcfunctions.functions.AddAdditionalTrigger("[Bb]ye");
    autonpcfunctions.functions.AddAdditionalTrigger("[Ff]arewell");
    autonpcfunctions.functions.AddAdditionalTrigger("[Ff]ive.+you");
    autonpcfunctions.functions.AddAdditionalText("Goodbye");
    autonpcfunctions.functions.AddTraderTrigger("[Ww]ho.+you","I am "..thisNPC.name..". I live in the magic academy and research in department of summoning here.");
    autonpcfunctions.functions.AddAdditionalTrigger("[Ww]hat.+[Nn]ame");
    autonpcfunctions.functions.AddTraderTrigger("[Hh]elp","Have a training? If you want I summon a creature for you on the arena field.");
    autonpcfunctions.functions.AddTraderTrigger("[Cc]reature","Do you want a creature for training? Tell me, if you want a harmless or a aggressive creature.");
    autonpcfunctions.functions.AddTraderTrigger("[Ss]tudent","Oh...I'm sorry, but I take no students.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.functions.AddTraderTrigger("[Pp]upil","I'm not a teacher.");
    
    autonpcfunctions.functions.AddTraderTrigger("[Ww]hat.+buy","Thanks, but I already have everything I need.");
    autonpcfunctions.functions.AddTraderTrigger("[Ww]hat.+sell","I don't sell anything. Do I look like a merchant?");
    autonpcfunctions.functions.AddTraderTrigger("buy","I don't sell anything. Do I look like a merchant?");
    autonpcfunctions.functions.AddTraderTrigger("sell","Thanks, but I already have everything I need.");
    autonpcfunctions.functions.AddTraderTrigger("[Ww]as.+kaufst","Ich habe bereits alles, was ich brauche.");
    autonpcfunctions.functions.AddTraderTrigger("[Ww]as.+verkaufst","Ich verkaufe nichts. Sehe ich etwa aus wie ein Händler?");
    autonpcfunctions.functions.AddTraderTrigger("[Kk]aufen","Ich verkaufe nichts. Sehe ich etwa aus wie ein Händler?");
    autonpcfunctions.functions.AddTraderTrigger("[Vv]erkaufen","Danke nein, ich habe bereits alles, was ich brauche.");
    autonpcfunctions.functions.AddTraderTrigger("[Gg]obaith","This whole island group is called Gobiath. Nice place, the weather usually does not get too rough or too hot, I like it.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.functions.AddTraderTrigger("[Gg]reenbriar","Greenbriar is a settlement of the Halflings.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.functions.AddTraderTrigger("[Hh]arbo[u]+r","Troll's Bane and Vanima both have Harbors. The one southwest from Troll's Bane is bigger though but he is quite far away from the town.");
    autonpcfunctions.functions.AddTraderTrigger("[Hh]ellbriar","That was an evil dungeon near Greenbriar ! The evil cultists there sacrificed most of the halflings of Greenbriar.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.functions.AddTraderTrigger("[Mm]agic [Aa]cademy","This is the magic academy of gobaith. Its just allowed for mages, students and guests to be here.");
    autonpcfunctions.functions.AddTraderTrigger("[Mm]age [Aa]cademy","This is the magic academy of gobaith. Its just allowed for mages, students and guests to be here.");
    autonpcfunctions.functions.AddTraderTrigger("[Nn]orthmark","Some Norodaj-Barbarians have settled in the north of Gobaith...they are a bit simple and have some fear of magic, because they can't understand it...better don't go there.");
    autonpcfunctions.functions.AddTraderTrigger("[Ss]ilverbrand","Silverbrand is the town of the dwarfes. They don't like elven, mages, fairys, and any other race except there own...in this order.");
    autonpcfunctions.functions.AddTraderTrigger("[Vv]anima","Tol Vanima is the \"Isle of the elven\"...a small island in the east of gobaith. You can reach it over the harbour or with one of the teleporters.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.functions.AddTraderTrigger("[Tt]roll['s].+[Bb]ane","Well, that's the biggest town on Gobiath.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.functions.AddTraderTrigger("[Vv]arshikar","You find it past the small sand desert in the far northwest. I would use the Teleporter, the desert is full of dangerous scorpions.");
    autonpcfunctions.AddCondition("lang","english");
--  
    autonpcfunctions.functions.AddTraderTrigger("[Gg]obiath","Diese ganze Inselgruppe wird Gobiath genannt. Nette Gegend, das Wetter wird nicht zu kalt oder zu heiß, ich bin gerne hier.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.functions.AddTraderTrigger("[Gg]reenbriar","Greenbriar is eine Halblingssiedlung im Süden Gobaiths.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.functions.AddTraderTrigger("[Hh]afen","Troll's Bane und Vanima haben Häfen. Der Hafen südwestlich von Troll's Bane ist zwar größer aber auch sehr weit von der Stadt entfernt.");
    autonpcfunctions.functions.AddTraderTrigger("[Hh]ellbriar","Das war ein von einem barbarischen Kult besetzter Dungeon nahe bei Greenbriar. Die bösartigen Kultisten dort haben die meisten der Halblinge geopfert.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.functions.AddTraderTrigger("[Mm]agierakademie","Dies hier ist die magische Akademie. Es ist nur Magiern, Studenten und ihren Gästen gestattet hier zu sein.");
    autonpcfunctions.functions.AddTraderTrigger("[Mm]agische [Aa]kademie","Dies hier ist die magische Akademie. Es ist nur Magierin, Studenten und ihren Gästen gestattet hier zu sein.");
    autonpcfunctions.functions.AddTraderTrigger("[Nn]ordmark","Einige Norodaj-Barbaren haben sich im Norden Gobaiths angesiedelt. Sie sind etwas einfältig und haben große Angst vor Magie...geh besser nicht dorthin.");
    autonpcfunctions.functions.AddTraderTrigger("[Ss]ilberbrand","Silberbrand ist die unterirdische Stadt der Zwerge. Sie mögen keine Elfen, keine Magier, keine Feen und auch sonst keine Rasse außer ihrer eigenen...");
    autonpcfunctions.functions.AddTraderTrigger("[Vv]anima","Tol Vanima ist die \"Insel der Elfen\"...eine kleine Insel im Osten von Gobaith. Du kannst sie über den Hafen oder mit einem Teleporter erreichen");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.functions.AddTraderTrigger("[Tt]roll['s].+[Bb]ane","Tja, das ist die grösste Stadt auf Gobiath.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.functions.AddTraderTrigger("[Vv]arshikar","Das findet man weit im Nordwesten hinter der kleinen Sandwüste. Ich würde den Teleporter benutzen, die Wüste ist voller gefährlicher Skorpione.");

-- ********* END DYNAMIC PART ********

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
    if ( TraderInit == nil) then
        TraderInit = {};
    end

    if (TraderInit[thisNPC.id] == nil) then
        M.initializeNpc();
        autonpcfunctions.functions.increaseLangSkill(TradSpeakLang);
        thisNPC.activeLanguage=TradStdLang;
        TraderInit[thisNPC.id] = true;
    end

    autonpcfunctions.functions.SpeakerCycle();
end

function M.receiveText(texttype, message, originator)
    if autonpcfunctions.functions.BasicNPCChecks(originator,2) then
        if (autonpcfunctions.functions.LangOK(originator,TradSpeakLang)==true) then
            thisNPC.activeLanguage=originator.activeLanguage;
            result = M.SayRow(message, originator);
            -- if not result then result = getCreature(message, originator) end;
            if not result then autonpcfunctions.functions.TellSmallTalk(message,originator) end;
        else
    	    if (verwirrt==false) then
        	gText="#me sieht dich leicht verwirrt an";
        	eText="#me looks at you a little confused";
        	outText=functions.GetNLS(originator,gText,eText);
        	autonpcfunctions.functions.NPCTalking(thisNPC,outText);
        	verwirrt=true;
    	    end
	end
    end
end

function M.SayRow(message, originator)
	if (string.find(message,"rätsel")~=nil) or (string.find(message,"riddle")~=nil) then
	one=math.random(1,30);
	two=math.random(1,10);
	type=math.random(1,2);

	
	M.getRow(one,two,type);
	
	thisNPC:talkLanguage( CCharacter.say, CPlayer.german, "One=>"..one..", two=>"..two.." und typ ist : "..type..". Das ergibt eine Reihe von: 1=> "..first..", 2=> "..second..", 3=> "..third..", 4=> "..fourth..", 5=> "..fifth..".");
        thisNPC:talkLanguage( CCharacter.say, CPlayer.english, "If I should summon a harmles creature for you, I get coppercoins. For a aggressive creature one I tak coppercoins.");
        return true
    end
    return false;
end

function M.getRow(one,two,type)
    if (type==1) then
        first=one*two;
        second=first*one;
	third=second*one;
        fourth=third*one;
        fifth=fourth*one;
    elseif (type==2) then
        first=one+two;
        second=first+one;
        third=second+one;
        fourth=third+one;
        fifth=fourth+one;
    end
    return first, second, third, fourth, fifth;
end

return M
