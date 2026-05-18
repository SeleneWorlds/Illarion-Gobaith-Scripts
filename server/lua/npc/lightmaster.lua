local M = {}

local functions = require("npc.base.functions")
Waypoint:new(position(122,604,0),1);
Waypoint:new(position(130,604,0),1);
Waypoint:new(position(129,596,0),1);
Waypoint:new(position(123,597,0),1);
Waypoint:new(position(122,590,0),1);
Waypoint:new(position(114,590,0),1);
Waypoint:new(position(130,591,0),1);
Waypoint:new(position(130,584,0),1);
Waypoint:new(position(123,584,0),1,nil,{bridge={toArea=2,toWaypoint=position(121,582,0),warp=false}});
Waypoint:new(position(121,582,0),2,nil,{bridge={toArea=1,toWaypoint=position(123,584,0),warp=false}});
Waypoint:new(position(121,575,0),2);
Waypoint:new(position(121,569,0),2);
Waypoint:new(position(128,569,0),2);
Waypoint:new(position(128,564,0),2);
Waypoint:new(position(121,564,0),2);
Waypoint:new(position(113,569,0),2);
Waypoint:new(position(104,569,0),2);
Waypoint:new(position(96,569,0),2);
Waypoint:new(position(96,576,0),2);
Waypoint:new(position(99,576,0),2,nil,{bridge={toArea=3,toWaypoint=position(101,576,0),warp=false},
                                            door={pos=position(100,576,0),toPos=position(101,576,0)}});
Waypoint:new(position(101,576,0),3,nil,{bridge={toArea=2,toWaypoint=position(99,576,0),warp=false},
                                            door={pos=position(100,576,0),toPos=position(99,576,0)}});
Waypoint:new(position(107,577,0),3);
Waypoint:new(position(114,577,0),3);
Waypoint:new(position(113,585,0),3,nil,{bridge={toArea=1,toWaypoint=position(113,587,0),warp=false},
                                            door={pos=position(113,586,0),toPos=position(113,587,0)}});
Waypoint:new(position(113,587,0),1,nil,{bridge={toArea=3,toWaypoint=position(113,585,0),warp=false},
                                            door={pos=position(113,586,0),toPos=position(113,585,0)}});

PatrolList[1] = { base = {false,5},
position(130,604,0),
position(128,564,0),
position(96,576,0),
position(114,577,0),
position(130,591,0)
}
--[[
PatrolList[1] = { base = {true,5},
position(122,604,0),
position(130,604,0),
position(129,596,0),
position(123,597,0),
position(122,590,0),
position(114,590,0),
position(130,591,0),
position(130,584,0),
position(123,584,0),
position(121,582,0),
position(121,575,0),
position(121,569,0),
position(128,569,0),
position(128,564,0),
position(121,564,0),
position(113,569,0),
position(104,569,0),
position(96,569,0),
position(96,576,0),
position(99,576,0),
position(101,576,0),
position(107,577,0),
position(114,577,0),
position(113,585,0),
position(113,587,0)
}
]]

function M.useNPC(user,counter,param)
    local lang=user:getPlayerLanguage();
    thisNPC:increaseSkill(1,"common language",100);
    if (lang==0) then thisNPC:talk(CCharacter.say, "Finger weg!") end
    if (lang==1) then thisNPC:talk(CCharacter.say, "Don't you touch me!") end
end

function M.initializeNpc()
    functions.InitTalkLists()

    thisNPC:increaseSkill(1,"common language",100);
    --------------------------------------------- *** EDIT BELOW HERE ***--------------------------------------

    functions.AddTraderTrigger("[Hh]ello","Hello, Hello");
    functions.AddAdditionalTrigger("[Gg]reetings");
    functions.AddAdditionalTrigger("[Hh]i");
    functions.AddTraderTrigger("[Hh]allo","Gr��e euch!");
    functions.AddAdditionalTrigger("[Gg]r[u�][s�]+");
    functions.AddTraderTrigger("[Ww]ho ","I am "..thisNPC.name.."");
    functions.AddTraderTrigger("[Ww]er ","Ich bin "..thisNPC.name..".");
    functions.AddTraderTrigger("[Bb]ye ","Be well");
    functions.AddTraderTrigger("[Ww]as.+verkauf","Ich verkaufe Lasttiere!");
    functions.AddTraderTrigger("[Ww]hat.+sell","I sell pack animals!");
    functions.AddAdditionalTrigger("[Ff]arewell");
    functions.AddAdditionalText("Farewell");
    functions.AddTraderTrigger("[Aa]uf.+[Bb]ald","Bis Bald");
    functions.AddAdditionalTrigger("[Bb]is.+[Bb]ald");
    functions.AddAdditionalText("Auf bald");
    functions.AddAdditionalText("Auf balde");
    functions.AddTraderTrigger("[Kk]uh","Ich habe keine K�he, ich habe nur Esel hier.");
    functions.AddTraderTrigger("cow","I have no cows, I have just mules.")

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
    
    if (TraderInit == nil) then
        TraderInit = 1;
		M.initializeNpc();
		action = false;
        functions.increaseLangSkill(TradSpeakLang);
        thisNPC.activeLanguage=TradStdLang;
		thisNPC:setAttrib("agility",15);
		thisNPC:createAtPos(5,392,1);
		local torch = thisNPC:getItemAt(5);
		torch.wear = 255;
		world:changeItem(torch);
    end
end

function M.receiveText(texttype, message, originator)
    if functions.BasicNPCChecks(originator,2) and originator:get_type()==0 then
        if (functions.LangOK(originator,TradSpeakLang)==true) then
            thisNPC.activeLanguage=originator.activeLanguage;
			if string.find(message,"delete") then
				world:deleteNPC(thisNPC.id);
			elseif string.find(message,"list") then
				npcdebug("CurWp: " .. getPos(CurWp.pos) .. "; NextWp: " .. getPos(NextWp.pos));
			elseif string.find(message,"setroute") then
				thisNPC:setOnRoute(true);
			else functions.TellSmallTalk(message) end;
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
end

return M
