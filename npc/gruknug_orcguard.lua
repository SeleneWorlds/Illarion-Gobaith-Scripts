local M = {}

--[[name="Gruknug"
position=187,-445,1
sex=male
race=orc
direction=east
radius=0
Task: Townguard at the mean entrance of the orc cave
last updated: 15/10/09
by: Juniper Onyx
]]--
-- INSERT INTO npc VALUES (nextval('npc_seq'),4,187,-445,1,2,false,'Gruknug','npc_gruknug_orcguard.lua',0);
local common = require("base.common")
local autonpcfunctions = require("npc.base.autonpcfunctions")
local keys = require("base.keys")
function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
	thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Nimm Greifer deine weg, sonst du haben gleich keine mehr!");
	thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Nub touch meh, stoopid!");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();

    -- ********* START DYNAMIC PART ********

	autonpcfunctions.AddCycleText("#me stiert mit seinen gelblich schimmernden Augen in die vom Plätschern des Baches erfüllte Höhle.","#me stares with yellowish glimming eyes into the dark cave.");
	autonpcfunctions.AddCycleText("#me kratzt sich am kahlen Kopf","#me scratches his pale head.");
	autonpcfunctions.AddCycleText("#me wirft dir einen aufmerksamen Blick zu, jede deiner Bewegungen für einige Augenblicke wahrnehmend.","#me glances at you with attentive gaze, watching any single movement of you for a few moments.");

   	autonpcfunctions.AddTraderTrigger("[Gg]rü[sß]","Ullo."); 
    autonpcfunctions.AddAdditionalTrigger("[Hh]allo"); 
    autonpcfunctions.AddAdditionalTrigger("[Gg]rue[sß]"); 
    autonpcfunctions.AddAdditionalTrigger("[Tt]a[gc].*"); 
    autonpcfunctions.AddAdditionalText("Ullo!"); 
    autonpcfunctions.AddTraderTrigger("[Aa]uf [Bb]ald","Auf bald."); 
    autonpcfunctions.AddAdditionalTrigger("[Gg]ötter.+euch"); 
    autonpcfunctions.AddAdditionalTrigger("[Bb]is.+[Bb]ald"); 
    autonpcfunctions.AddAdditionalTrigger("[Aa]uf.+[Bb]ald"); 
    autonpcfunctions.AddAdditionalTrigger("[Ff]ünf.+euch"); 
    autonpcfunctions.AddTraderTrigger("[Ww]er [bs][ie][si][td] [di][uh].*","Mir Wache sein für Orktor! Keine Ratte hier rein kommen ohne dass "..thisNPC.name.." merken!"); 
    autonpcfunctions.AddAdditionalTrigger("[Ww]ie.+[Nn]ame"); 
    autonpcfunctions.AddTraderTrigger("[Hh]ilfe",""..thisNPC.name.." dir nur kann öffnen Tor! Muss bewachen Tor! Frag anderen Bruder oder Schwester für andere Sachen!"); 
    autonpcfunctions.AddTraderTrigger("[Ww]as.+[Mm]ach.*t",""..thisNPC.name.." öffnen und schließen Orktor! Du wollen rein oder raus? Dann du mir sagen Losungswort!"); 
    autonpcfunctions.AddTraderTrigger("[Ll]osung.*[Ww]ort","#me grunzt verärgert 'Du denken "..thisNPC.name.." Maden im Kopf haben? Ich dir nicht sagen Wort! Mir nur hören auf Brüder und Schwester, die wissen Wort!'"); 
    autonpcfunctions.AddTraderTrigger("[Hh]eilig.*[Bb]erg","Dies hier sein Heiliger Berg, yubba! Heiliger Berg von Vater!"); 

   	autonpcfunctions.AddTraderTrigger("[Gg]reeting","Greebas!"); 
    autonpcfunctions.AddAdditionalTrigger("[Hh]ello"); 
    autonpcfunctions.AddAdditionalTrigger("Gr.*eebs"); 
    autonpcfunctions.AddAdditionalTrigger("Gr.*eebas"); 
    autonpcfunctions.AddAdditionalText("Greebs"); 
   	autonpcfunctions.AddTraderTrigger("[Gg]oodbye","Farrebas."); 
    autonpcfunctions.AddAdditionalTrigger("[Bb]ye"); 
    autonpcfunctions.AddAdditionalTrigger("[Ff]ar.*e.*well"); 
    autonpcfunctions.AddAdditionalTrigger("[Ff]ar.*ebas"); 
    autonpcfunctions.AddAdditionalTrigger("[Ff]ive.+you"); 
    autonpcfunctions.AddAdditionalTrigger("[Ff]ive.+yoo"); 
    autonpcfunctions.AddAdditionalText("Goodbyes"); 
  	autonpcfunctions.AddTraderTrigger("[Ww]ho.+yo.+","Meh beh "..thisNPC.name..", nub single rat whub enterr orc caves witout meh sees it!"); 
  	autonpcfunctions.AddTraderTrigger("[Ww]hat.+[Nn]ame", "Meh "..thisNPC.name.."! Meh strong guard ob orc caves!"); 
  	autonpcfunctions.AddTraderTrigger("[Ww]hub.+[Nn]ame", "Meh "..thisNPC.name.."! Meh strong guard ob orc caves!"); 
  	autonpcfunctions.AddTraderTrigger("[Hh]elp",""..thisNPC.name.." nub can help yoo muchs! Ask ottur bruddah or sistah! Meh busy beh guardin...hurr, yoo hab seen rat running dere?!"); 
  	autonpcfunctions.AddTraderTrigger("[Ww]hat.+[Yy]o.*do",""..thisNPC.name.." opens and closes orc gate! Yoo wunt get in or out? Den tell meh keyword"); 
  	autonpcfunctions.AddTraderTrigger("[Kk]ey.*[Ww]ord","Yoo tink "..thisNPC.name.." stoopid beh? Meh nub tell yoo keyword! Meh just open gate fer bruddahs and sistahs whoo know word!"); 
    autonpcfunctions.AddAdditionalTrigger("[Pp]as.*word"); 
    autonpcfunctions.AddTraderTrigger("[Hh]oly.*[Mm]ountain","Yubba, dis beh holy mountain ob father! Orcs libe here since ancient times!"); 

    autonpcfunctions.AddTraderTrigger("buy","Tanks, meh hab eberytin' meh need."); 
    autonpcfunctions.AddTraderTrigger("sell","Meh nub sell anyting! Meh looks like merchant? Hurrr, nub!"); 
    autonpcfunctions.AddTraderTrigger("[Ww]hat.+buy","Tanks, meh hab all meh need."); 
    autonpcfunctions.AddTraderTrigger("[Ww]hat.+sell","Meh nub sell anyting! Meh do look like merchant? Hurrr, nub!"); 
    autonpcfunctions.AddTraderTrigger("[Vv]erkaufen","Mir verkaufen nichts. "..thisNPC.name.." aussehen wie Händler?"); 
    autonpcfunctions.AddTraderTrigger("[Kk]aufen","Danks, mir haben alles was Ork brauchen!"); 
    autonpcfunctions.AddTraderTrigger("[Ww]as.+verkaufst","Mir verkaufen nichts. "..thisNPC.name.." aussehen wie Händler?"); 
    autonpcfunctions.AddTraderTrigger("[Ww]as.+kaufst","Danks, mir haben alles was Ork brauchen!"); 

--TRIGGER FUER LOCATIONS ENGLISCH    
    autonpcfunctions.AddTraderTrigger("[Gg]obaith","Tis whole island beh called Gobaith. Nice place, yubba! Good hunting grounds here beh near holy mountain!"); 
    autonpcfunctions.AddCondition("lang","english"); 
    autonpcfunctions.AddTraderTrigger("[Gg]obiath","Tis whole island beh called Gobaith. Nice place, yubba! Good hunting grounds here beh near holy mountain!"); 
    autonpcfunctions.AddCondition("lang","english"); 
    autonpcfunctions.AddTraderTrigger("[Gg]reenbriar","Greenbriar beh small settlement ob tiny and tasty Halflings. Albays good turr go dere fer snack. *he laughs*"); 
    autonpcfunctions.AddCondition("lang","english"); 
    autonpcfunctions.AddTraderTrigger("[Hh]arbo.*r","Oomie town Troll's Bane and Vanima both hab harbors. The one southwest ob oomie town beh bigger though. Beddur nub go turr smelly elfie island!"); 
    autonpcfunctions.AddTraderTrigger("[Hh]ellbriar","Hellbriar wus place ob sum servants ob our 'father' in past. Buts dere nub any orcs beh in dis Cult anymor', so father left dem alone and dey all got smashed, dey say."); 
    autonpcfunctions.AddCondition("lang","english"); 
    autonpcfunctions.AddTraderTrigger("[Mm]agic [Aa]cademy","Yoo nub wunt go dere! Smelly mages beh dere. Dey nub honorable warriors beh but cowards! Dey whub burrrn yoo... ib yoo lucky beh!"); 
    autonpcfunctions.AddTraderTrigger("[Mm]age [Aa]cademy","Yoo nub wunt go dere! Smelly mages beh dere. Dey nub honorable warriors beh but cowards! Dey whub burn yoo only ib yoo lucky beh!"); 
    autonpcfunctions.AddTraderTrigger("[Nn]orthmark","Dey lib on ottur side ob island far in west. Dey hab strrong warriors meh hab heard! And best beh dat dey nub like magic neithurrr - jus' bit like orcs, hurrr."); 
    autonpcfunctions.AddTraderTrigger("[Ss]ilverbrand","Dis beh stumpie town. Dey hab best smithes on isle, still dey beh hairy stumpies. Meh whub tink twice befor' going into deir halls!"); 
    autonpcfunctions.AddTraderTrigger("[Vv]anima","Tol Vanima ? Dis beh island full ob flowers, trees and elfies. Beddur avoid going dere! Dey nub like visitors!"); 
    autonpcfunctions.AddCondition("lang","english"); 
    autonpcfunctions.AddTraderTrigger("[Tt]roll['s].*[Bb]ane","Oomie town Troll's Bane beh biggest town on Gobaith. Though, orcs ususally get in trouble in dere! Beh careful when passing town gates!"); 
    autonpcfunctions.AddCondition("lang","english"); 
    autonpcfunctions.AddTraderTrigger("[Vv]arshikar","Desert town Varshikar nub beh far abay from here, just short walk to southeast! Orcs hab peace wit dem! Treat dem fair and dey whub treat yoo fair toos! But beh careful ob mages in desert town!"); 
    autonpcfunctions.AddCondition("lang","english"); 
    autonpcfunctions.AddTraderTrigger("[Dd]esert.*town","Desert town Varshikar nub beh far abay from here, just short walk to southeast! Orcs hab peace wit dem! Treat dem fair and dey whub treat yoo fair toos! But beh careful ob mages in desert town!"); 
    
--Charakter-Trigger 
    autonpcfunctions.AddTraderTrigger("[Ff]ather","Yoo nub know father ob orcs? *he snorts* Yoo should talk turr Chief den! He whub make yoo rememburr 'fathurr' fer yoos whole life!"); 
    autonpcfunctions.AddCondition("lang","english"); 
    autonpcfunctions.AddTraderTrigger("[Kk]rull.","Krull beh great chief ob Orc Nation! Praise hims and praise fathurr!"); 
    autonpcfunctions.AddTraderTrigger("[Rr]ugh.*","Rugh... yoo talkin' bout Rugh'toh? he beh da former great chief ob Orcs ob Dar'krest!"); 
    autonpcfunctions.AddTraderTrigger("[Rr]ukka","Rukka beh strong sistah! She beh smart and looks nicy like roasted halfy."); 
    autonpcfunctions.AddTraderTrigger("[Oo]rgis","Orgis'Ug good brothurr beh! He beh good friend ob mine!"); 
    autonpcfunctions.AddTraderTrigger("[Rr]ok.*[Kk]re.*[Hh]o", "Rok beh strong and wise bruddah! He beh clan leader ob Skullcrushers!"); 
    autonpcfunctions.AddTraderTrigger("[Gg]re.*la", "Gre'la beh da most beautiful orcess meh hab ebbur seen - unfortunately she hab left da caves lon' time ago."); 
    autonpcfunctions.AddTraderTrigger("[Hh].+['][Gg]reu", "Da best smith ob orcs ob Dark'Krest beh Hu'greu! He makes sharrpest blades and thickest armorrs! Meh tinks is hands hab been blessed by fathurr!"); 
    autonpcfunctions.AddTraderTrigger("[Bb]rad.*ok.*", "Braddokk nub beh muchs around, buts he good bruddah beh anybay!"); 
    autonpcfunctions.AddTraderTrigger("[Rr]etlak", "Retlak once hab been da most honorable and strongest orc in isle. Den he hab gone mad and hang around wit too many oomies - nows he dead beh. Beddur dead orc, den flower orcs alive meh albays say."); 
    autonpcfunctions.AddTraderTrigger("[Gg]riv.*jak", "Grivijak once wus Chief ob orcs. He wus stong, yubba he wus! Buts den he hab left da isle - coward ib yoo askin meh!"); 
    autonpcfunctions.AddTraderTrigger("[Gg]abon", "Hurrr, meh only hab heard stories about mighty bruddah Gabon! He must hab been grrreat orc! Eben beddur den Chief we hab nows."); 
    autonpcfunctions.AddTraderTrigger("[Mm]urgo", "Harr, harrrr! Murrrgo - dis beh name ob da most flowery flower orc ob isle! Meh tinks he eben fears bees!"); 
    autonpcfunctions.AddTraderTrigger("[Gg]ruknug", "#me hits his own chest with his fist '"..thisNPC.name..", dis beh meh, yubba!'"); 
    autonpcfunctions.AddTraderTrigger("[Kk]ar.*kish", "Yoo talking 'bout mehs sistah, Kar'kish? She beh downstairs, guarding da othur gate!"); 
    autonpcfunctions.AddTraderTrigger("[Cc]hief", "Hurr, Chief ob orcs beh mighty bruddah Krull! Rememburr his name! He hab done muchs fer orcs, fer our clan!"); 
    autonpcfunctions.AddTraderTrigger("[Tt]urga", "Hurrr, Mighty bruddah Turga! He is grrreat orc! Eben beddur den Chief we hab nows."); 

--SONSTIGE TRIGGER 
    autonpcfunctions.AddTraderTrigger("[Cc]lan", "Yubba, dis beh caves ob strong orc clan! Tell meh clan name and meh whub open gate fer yoo!"); 
    autonpcfunctions.AddTraderTrigger("[Dd]eser.*t", "#me snorts 'Da desert ob Kumdah beh in south ob orc lands! Oomies and scorpies beh all yoo whub find dere. Some rich mines beh dere after all.'"); 
    autonpcfunctions.AddTraderTrigger("[Ww][üue]ste", "#me schaubt 'Wüste Kumdah in Süden sein von Orkland! Menschen und Skorpione sein alles du finden da! Die Berge immerhin haben reiche Schätze.'"); 
    autonpcfunctions.AddTraderTrigger("Or.*c.*", "#me hits his chest with his right fist and grunts 'Hurrr, Orc Nation beh strrongest! Praise father and holy mountain!'"); 
    autonpcfunctions.AddTraderTrigger("Or.*k.*", "#me schlägt mit seiner rechten Faust auf seine Brust 'Hurrr, Ork Nation die stärksten sein! Ehre für unseren Vater und heiligen Berg!'");  
    autonpcfunctions.AddTraderTrigger("Tor", "Du wollen dass mir machen Tor auf? Dann sagen Namen von Orkclan!"); 
    autonpcfunctions.AddTraderTrigger("Gate", "Yoo wunt meh open da gate? Den tell meh da name ob orc clan!"); 
    autonpcfunctions.AddTraderTrigger("Moshran", "#me growls angrily and shouts at you 'Nub tell father's name! Dis whub brring shame on us! Call him father, hurrr... and now leave meh alone!'"); 
    autonpcfunctions.AddTraderTrigger("Moshran", "#grunzt erzürnt auf und schreit dich an 'Nicht nennen Vater bei Namen! Bringt Schande über uns! Vater du ihn nennen, hurrr... und jetzt in Ruhe lassen du mich!'"); 
    autonpcfunctions.AddCondition("lang","german"); 
    
    
    
--TRIGGER FÜR LOCATIONS DEUTSCH 
    autonpcfunctions.AddTraderTrigger("[Gg]obiath","Insel genannt wird Gobaith. Gute Gegend für Orks! Gute Jagdgründe hier sind in Nähe von heiligem Berg!"); 
    autonpcfunctions.AddCondition("lang","german"); 
    autonpcfunctions.AddTraderTrigger("[Gg]obaith","Ja, diese Insel genannt wird Gobaith. Gute Gegend für Orks! Gute Jagdgründe hier sind in Nähe von heiligem Berg!"); 
    autonpcfunctions.AddCondition("lang","german"); 
    autonpcfunctions.AddTraderTrigger("[Gg]reenbriar","Greenbriar kleine Siedlung ist, bewohnt von klein und lecker Halblings. Immer gut da hin gehen für Leckerbissen. *er lacht grunzend auf*"); 
    autonpcfunctions.AddCondition("lang","german"); 
    autonpcfunctions.AddTraderTrigger("[Hh]afen","Hafen sein im Süden von Menschenstadt Troll's Bane. Auch stinkende Elfeninsel haben Hafen. Aber Wasser nix für Orkse ist, hurr!"); 
    autonpcfunctions.AddTraderTrigger("[Hh]ellbriar","Hellbriarkult war von Anhängern von unser 'Vater'! Aber alle Orks haben verlassen Kult! Nicht gut er mehr ist. Nur Unheil bringen über orks, wenn du mich fragen."); 
    autonpcfunctions.AddCondition("lang","german"); 
    autonpcfunctions.AddTraderTrigger("[Mm]agierakademie","Du besser nicht gehen besuchen Magier! Sie keine Ehre haben und keinen Spaß verstehen. Sie dich gleich verbrennen oder verwandeln in Kröte mit bloßem Blick!"); 
    autonpcfunctions.AddTraderTrigger("[Nn]ordmark","Die Nordmarkmänner gute Menschen sein! Wie Orks sie nicht mögen Magie! Auch Nordmarkfrauen mit Waffen umgeh'n könn'! Trotzdem sie stinkende Menschen bleiben!"); 
    autonpcfunctions.AddTraderTrigger("[Ss]ilberbrand","Zwergenstadt groß und heiß sein. Schmelzofen laufen ganzen Tag und Hammerschläge erfüllen Hallen immer mit Lärm. Wenn nicht Zerge wären da, schöner Ort es wäre."); 
    autonpcfunctions.AddTraderTrigger("[Vv]anima","Hurr! Fern bleiben du von dieser stinkenden Elfeninsel! Nur Unheil auf Orks dort warten!"); 
    autonpcfunctions.AddCondition("lang","german"); 
    autonpcfunctions.AddTraderTrigger("[Tt]roll['s].*[Bb]ane","Menschenstadt in Mitte der Insel du fragen nach? Groß und hässlich sie sein! Orkse nicht gern gesehen dort! Nim Waffen mit, wenn du in Stadt müssen!"); 
    autonpcfunctions.AddCondition("lang","german"); 
    autonpcfunctions.AddTraderTrigger("[Vv]arshikar","Wüstenstadt nicht fern von hier. Meisten Wesen dort dumm und stinkig - aber Clanführer, Grrrypus, Ehre haben! Sei gut zu Wüstenvolk, dann sie gut zu Orks sind!"); 
    autonpcfunctions.AddCondition("lang","german"); 
    autonpcfunctions.AddTraderTrigger("[Ww]üstenstadt","Wüstenstadt nicht fern von hier. Meisten Wesen dort dumm und stinkig - aber Clanführer, Grrrypus, Ehre haben! Sei gut zu Wüstenvolk, dann sie gut zu Orks sind!"); 
    autonpcfunctions.AddTraderTrigger("[Ww]uestenstadt","Wüstenstadt nicht fern von hier. Meisten Wesen dort dumm und stinkig - aber Clanführer, Grrrypus, Ehre haben! Sei gut zu Wüstenvolk, dann sie gut zu Orks sind!");

    -- ********* END DYNAMIC PART ********
    TradSpeakLang={0,5};
    TradStdLang=0;

    autonpcfunctions.increaseLangSkill(TradSpeakLang);
    thisNPC.activeLanguage=TradStdLang;

	doorapos=position( 188, -444, 1);
	doorbpos=position( 188, -443, 1 );

end

function M.nextCycle()  -- ~10 times per second
    M.initializeNpc();
    autonpcfunctions.SpeakerCycle();
end

function M.receiveText(texttype, message, originator)
 
    if autonpcfunctions.BasicNPCChecks(originator,2) then  --Npc wird aus nächster Nähe angesprochen
		  if (originator.activeLanguage==5) then --If the Character speaks orcisch then...
			if (M.mainTask(message,originator)~=true) then
			    autonpcfunctions.TellSmallTalk(message,originator);
			end
		  elseif (originator.activeLanguage==0) then --If the Character. speaks Common then
				if (M.standardAnswer(message,1) or M.standardAnswer(message,2)) then --true password but wrong language
					gText="Du sprechen orkisch zu mir, wenn ich soll anfassen Orktor zu heiligem Berg!";  --HIER DIE TEXTE SCHREIBEN DIE DER NPC SAGT FALLS DAS LOSUNGSWORT RICHTIG; ABER NICHT AUF ORKISCH IST
					eText="Speak orcish ib yoo wunt meh touch da gate turr holy mountain!";
					outText=autonpcfunctions.GetNLS(originator,gText,eText);
					autonpcfunctions.NPCTalking(thisNPC,outText);
				else
					autonpcfunctions.TellSmallTalk(message,originator);
				end
		  else --WENN EINE ANDERE SPRACHE GESPROCHEN WURDE DANN(zum Beispiel antik )
				autonpcfunctions.Confused(
				"#me grunzt dich an, als er ob deine Sprache offenbar nicht versteht.",
				"#me grunts at you as he apparently does not understand you language."
				);
		  end
	elseif autonpcfunctions.BasicNPCChecks(originator,8) then --Npc wird aus mehreren Schritten Entfernung angesprochen
		  if (originator.activeLanguage==5) then --If the Character speaks orcisch then...
			M.mainTask(message, originator);
		  elseif (originator.activeLanguage==0) then --If the Character. speaks Common then
				if (M.standardAnswer(message,1) or M.standardAnswer(message,2)) then --true password but wrong language
					gText="Du sprechen orkisch zu mir, wenn ich soll anfassen Orktor zu heiligem Berg!";  --HIER DIE TEXTE SCHREIBEN DIE DER NPC SAGT FALLS DAS LOSUNGSWORT RICHTIG; ABER NICHT AUF ORKISCH IST
					eText="Speak orcish ib yoo wunt meh touch da gate turr holy mountain!";
					outText=autonpcfunctions.GetNLS(originator,gText,eText);
					autonpcfunctions.NPCTalking(thisNPC,outText);
				end
		  end
	end
end

--[[
    standardAnswer
    Checks whether a string can be counted to an answertype
    @param message - string
    @param answertype - integer
    
    @return boolean - true in case message can be counted to the answertype else false
]]
function M.standardAnswer(message,answertype)

	if (answertype==1) then --answertype 1 == standardphrases for "open door"
		     if (string.find(message,"[Bb]r.*ud.*a.+[Oo]pen.+[Gg]ate.*")~=nil or string.find(message,"[Bb]r.*[ou]th.*[ae].+[Oo]pen.+[Gg]ate.*")~=nil
			 or string.find(message,"[Oo]pen.+[Gg]ate.+[Bb]r.*ud.*a.*")~=nil or string.find(message,"[Oo]pen.+[Gg]ate.+[Bb]r.*[ou]th.*[ae].*")~= nil
			 or string.find(message,"[Bb]r.*ud.*[ae].+[Tt]or.*[Aa]uf.*")~=nil or string.find(message,"[Tt]or.+[Aa]uf.+[Bb]r.*ud.*[ae].*")~=nil
			 or string.find(message,"[Bb]r.*ud.*[ae].+[öoe]ffne.+[Tt]or.*")~=nil or string.find(message,"[Ööe]ffne.+[Tt]or.+[Bb]r.*ud.*[ae].*")~=nil) then
			 	return true;
		 	 else
		     	return false;
		 	 end

    elseif (answertype==2) then --answertype 2 == standardphrases for "close door"
			 if (string.find(message,"[Bb]r.*ud.*a.+[Cc]lose.+[Gg]ate.*")~=nil or string.find(message,"[Bb]r.*[ou]th.*[ae].+[Cc]lose.+[Gg]ate.*")~=nil
			 or string.find(message,"[Cc]lose.+[Gg]ate.+[Bb]r.*ud.*a.*")~=nil or string.find(message,"[Cc]lose.+[Gg]ate.+[Bb]r.*[ou]th.*[ae].*")~=nil
			 or string.find(message,"[Bb]r.*ud.*[ae].+[Tt]or.*[Zz]u.*")~=nil or string.find(message,"[Tt]or.+[Zz]u.+[Bb]r.*ud.*[ae].*")~= nil
			 or string.find(message,"[Bb]r.*ud.*[ae].+schlie[ßs].+[Tt]or.*")~=nil or string.find(message,"[Ss]chlie[ßs].+[Tt]or.+[Bb]r.*ud.*[ae].*")~=nil) then
		
		   		return true;
			 else
		   		return false;
			 end
	else
        	 return false;
   	end
end

--[[
    mainTask
    This function checks if the Char said the mean triggers(open door, close door,...) and sets all needed variables to open/close door
    @param originator - CharStruct - the Char who talked to the NPC
    @param message - String - The text the Character spoke
    
    @return true in case the NPC said one of the mean triggers else false
]]
function M.mainTask(message, originator) 
	if (M.standardAnswer(message,1)) then  --Open gate
		doora=world:getItemOnField(doorapos);
		doorb=world:getItemOnField(doorbpos);
		if (doora.id==666 and doorb.id==670) then--door already opened
			gText="Dummer Ork, Tor sein auf!";
			eText="Stoopid orc, da gate alrrready beh open!";
			outText=autonpcfunctions.GetNLS(originator,gText,eText);
			autonpcfunctions.NPCTalking(thisNPC,outText);
		else
			keys.UnlockDoor( doora ); --Tor entriegeln
			keys.UnlockDoor( doorb );

			doora=world:getItemOnField(doorapos);
			doorb=world:getItemOnField(doorbpos);
			OpenDoor( doora );  --Tor aufmachen
			OpenDoor( doorb );

			gText="#me öffnet schwerfällig das Tor wodurch die Höhle mit einem markerschütternden Knarren erfüllt wird.";
			eText="#me opens the gate. The whole cave is fillied with a loud noise.";
			outText=autonpcfunctions.GetNLS(originator,gText,eText);
			autonpcfunctions.NPCTalking(thisNPC,outText);
		end
		return true;
	elseif (M.standardAnswer(message,2)) then --Close gate
		doora=world:getItemOnField(doorapos);
		doorb=world:getItemOnField(doorbpos);	
		if (doora.id==654 and doorb.id==658) then --If both doors are already closed then...
			gText="Du keine Augen in deinem stinkigen Kopf haben? Tor sein schon zu!";
			eText="Yoo nub hab eyes in yoos smelly head? Da gate alrrready beh closed!";
			outText=autonpcfunctions.GetNLS(originator,gText,eText);
			autonpcfunctions.NPCTalking(thisNPC,outText);
		else	
			if ( world:isCharacterOnField(doorapos) or world:isCharacterOnField(doorbpos)) then -- Is a char. on the position of the doors?
				gText="Ich nix können Tor zumachen wenn da jemand rumstehen!";
                eText="Me nub can close dat gate when someone standing there!";
                outText=autonpcfunctions.GetNLS(originator,gText,eText);
		        autonpcfunctions.NPCTalking(thisNPC,outText);	
			else
				CloseDoor( doora ); --Tore schließen
				CloseDoor( doorb );

				doora=world:getItemOnField(doorapos);
				doorb=world:getItemOnField(doorbpos);
				keys.LockDoor( doora ); --Tore verriegeln
				keys.LockDoor( doorb );
				gText="#me lässt die Flügel des Tores krachend zufallen und sperrt ab."; --HIER DIE TEXTE REINSCHREIBEN DIE BEIM ZUMACHEN KOMMEN SOLLEN
				eText="#me shuts the gate crashing then locks it.";
				outText=autonpcfunctions.GetNLS(originator,gText,eText);
				autonpcfunctions.NPCTalking(thisNPC,outText);
			end
		end
		return true;
	end
end

return M
