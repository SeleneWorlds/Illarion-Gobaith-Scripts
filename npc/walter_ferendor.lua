local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-120,-93,0,2,false,'Walter Ferendor','npc_walter_ferendor.lua',0);

-- nutrition

local common = require("base.common")
local autonpcfunctions = require("npc.base.autonpcfunctions")
function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Oh! So macht Ihr das also.");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Oh! So that's the way you do it.");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();
    if service==nil then
		service={}; 	-- price for service
		service[1]=50;	-- cure light wounds
		service[2]=80;	-- cure serious wounds
		service[3]=120;	-- full heal
		service[4]=120;	-- cure poison
		service[5]=50;	-- diet info
    end
    
    -- ********* START DYNAMIC PART ********

    -- small talk
    autonpcfunctions.AddTraderTrigger("hello","Be greeted. Nice weather, isn't it?");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddAdditionalTrigger("good day");
    autonpcfunctions.AddAdditionalText("Hm ... delicious cake ... Oh, greetings to you.");
    autonpcfunctions.AddAdditionalText("Hello there.");
    autonpcfunctions.AddTraderTrigger("hallo","Seid gegrüßt. Ganz nettes Wetter, nicht?");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddAdditionalTrigger("guten tag");
    autonpcfunctions.AddAdditionalTrigger("tach");
    autonpcfunctions.AddAdditionalTrigger("grue[sß]");
    autonpcfunctions.AddAdditionalText("Hm ... leckerer Kuchen ... Oh, grüß' Euch.");
    autonpcfunctions.AddAdditionalText("Hallöchen.");
    autonpcfunctions.AddTraderTrigger("bye","Good bye.");
    autonpcfunctions.AddAdditionalTrigger("be well");
    autonpcfunctions.AddAdditionalTrigger("farewell");
    autonpcfunctions.AddAdditionalText("The Five with you.");
    autonpcfunctions.AddAdditionalText("Farewell.");
    autonpcfunctions.AddAdditionalText("Have a nice day.");
    autonpcfunctions.AddTraderTrigger("auf bald","Auf Wiedersehen.");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalTrigger("auf wiederseh");
    autonpcfunctions.AddAdditionalTrigger("leb wohl");
    autonpcfunctions.AddAdditionalText("Schönen Tag noch!");
    autonpcfunctions.AddAdditionalText("Auf bald.");
    autonpcfunctions.AddAdditionalText("Bis bald.");
    autonpcfunctions.AddAdditionalText("Lebt wohl.");
    autonpcfunctions.AddTraderTrigger("weather","Well, any weather is nice as it is needed aswell.");
    autonpcfunctions.AddTraderTrigger("wetter","Naja, jedes Wetter ist schön, da es ja auch gebraucht wird.");
    autonpcfunctions.AddTraderTrigger("cake","Oh, this delicious cake ...  a halfling near the fields outside the walls gave it to me.");
    autonpcfunctions.AddTraderTrigger("kuchen","Oh, dieser leckere Kuchen ... ein Halbling bei den Äckern außerhalb der Mauern gab ihn mir.");
    autonpcfunctions.AddTraderTrigger("what sell","I am not a trader. I am a healer and a diet expert. I offer therefore some services.");
    autonpcfunctions.AddAdditionalTrigger("what buy");
    autonpcfunctions.AddTraderTrigger("was kauf","Ich bin kein Händler. Ich bin ein Heiler und Experte in Sachen Ernährung. Ich biete daher auch einige Dienste an.");
    autonpcfunctions.AddTraderTrigger("service","I offer the following services: cure light or serious wounds, full heal, cure poisoning or information about your current dietary condition. What do you want?");
    autonpcfunctions.AddTraderTrigger("dienst","Ich biete die folgenden Dienste an: Heilung von leichten oder schweren Wunden, vollständige Heilung, Heilung einer Vergiftung oder Auskunft über Euren derzeitigen Ernährungszustand. Was wollt Ihr?");
    autonpcfunctions.AddTraderTrigger("help","Say 'service' to get a list of my services. To make use of a service, just tell me which service. Say 'price' to get a list of my prices.");
    autonpcfunctions.AddTraderTrigger("helf","Sagt 'Dienst' um eine Liste meiner Dienste zu bekommen. Um davon Gebrauch zu machen, nennt mir einfach den Dienst. Sagt 'Preis' um eine Liste meiner Preise zu bekommen.");
    autonpcfunctions.AddAdditionalTrigger("hilf");
    autonpcfunctions.AddTraderTrigger("price","Healing of light and serious wounds costs "..service[1].." and "..service[2]..", a full healing "..service[3].." copper coins. The price of an antidote is "..service[4].." copper coins and for diet information I charge "..service[5].." copper coins.");
    autonpcfunctions.AddConsequence("state","=",6);
    autonpcfunctions.AddTraderTrigger("preis","Eine Heilung leichter und schwerer Wunden kostet "..service[1].." und "..service[2]..", eine volle Heilung "..service[3].." Kupfermünzen. Der Preis für ein Gegengift ist "..service[4].." Kupfermünzen und für Ernährungsinformationen verlange ich "..service[5].." Kupfermünzen.");
    autonpcfunctions.AddConsequence("state","=",6);
	autonpcfunctions.AddTraderTrigger("who you","I am "..thisNPC.name..", a healer and a diet expert. I offer therefore some services.");
    autonpcfunctions.AddAdditionalTrigger("what you");
    autonpcfunctions.AddTraderTrigger("wer du","Ich bin "..thisNPC.name..", ein Heiler und Experte in Sachen Ernährung. Ich biete daher auch einige Dienste an.");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddAdditionalTrigger("was du");
    autonpcfunctions.AddAdditionalTrigger("wer du");
	
    -- business
    autonpcfunctions.AddTraderTrigger(".+","I won't cure your light wounds unless you have "..service[1].." copper coins for me.");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("money","<",service[1]);
    autonpcfunctions.AddAdditionalText("Come back when you have "..service[1].." copper coins! Then I'll cure your light wounds.");
    autonpcfunctions.AddTraderTrigger(".+","Ich werde nicht Eure leichten Wunden heilen, es sei denn Ihr bringt mir "..service[1].." Kupfermünzen.");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("money","<",service[1]);
    autonpcfunctions.AddAdditionalText("Kommt wieder, wenn Ihr "..service[1].." Kupfermünzen habt! Dann heile ich Eure leichten Wunden.");
    autonpcfunctions.AddTraderTrigger(".+","");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("money",">=",service[1]);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddConsequence("money","-",service[1]);
    autonpcfunctions.AddTraderTrigger(".+","I won't cure your serious wounds unless you have "..service[2].." copper coins for me.");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("money","<",service[2]);
    autonpcfunctions.AddAdditionalText("Come back when you have "..service[2].." copper coins! Then I'll cure your serious wounds.");
    autonpcfunctions.AddTraderTrigger(".+","Ich werde nicht Eure schweren Wunden heilen, es sei denn Ihr bringt mir "..service[2].." Kupfermünzen.");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("money","<",service[2]);
    autonpcfunctions.AddAdditionalText("Kommt wieder, wenn Ihr "..service[2].." Kupfermünzen habt! Dann heile ich Eure schweren Wunden.");
    autonpcfunctions.AddTraderTrigger(".+","");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("money",">=",service[2]);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("money","-",service[2]);
    autonpcfunctions.AddTraderTrigger(".+","I won't heal your wounds fully unless you have "..service[3].." copper coins for me.");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("money","<",service[3]);
    autonpcfunctions.AddAdditionalText("Come back when you have "..service[3].." copper coins! Then I'll heal your wounds fully.");
    autonpcfunctions.AddTraderTrigger(".+","Ich werde Eure nicht vollständig heilen, es sei denn Ihr bringt mir "..service[3].." Kupfermünzen.");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("money","<",service[3]);
    autonpcfunctions.AddAdditionalText("Kommt wieder, wenn Ihr "..service[3].." Kupfermünzen habt! Dann werde ich Euch vollständig heilen.");
    autonpcfunctions.AddTraderTrigger(".+","");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddCondition("money",">=",service[3]);
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddConsequence("money","-",service[3]);
    autonpcfunctions.AddTraderTrigger(".+","I won't cure your poison unless you have "..service[4].." copper coins for me.");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("money","<",service[4]);
    autonpcfunctions.AddAdditionalText("Come back when you have "..service[4].." copper coins! Then I'll cure your poison.");
    autonpcfunctions.AddTraderTrigger(".+","Ich werde Eure Vergiftung nicht heilen, es sei denn Ihr bringt mir "..service[4].." Kupfermünzen.");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("money","<",service[4]);
    autonpcfunctions.AddAdditionalText("Kommt wieder, wenn Ihr "..service[4].." Kupfermünzen habt! Dann werde ich Eure Vergiftung heilen.");
    autonpcfunctions.AddTraderTrigger(".+","");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddCondition("money",">=",service[4]);
    autonpcfunctions.AddConsequence("state","=",4);
    autonpcfunctions.AddConsequence("money","-",service[4]);
    autonpcfunctions.AddTraderTrigger(".+","I won't tell you anything about your diet unless you have "..service[5].." copper coins for me.");
    autonpcfunctions.AddCondition("state","=",50);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("money","<",service[5]);
    autonpcfunctions.AddAdditionalText("Come back when you have "..service[5].." copper coins! Then I'll tell you something about the condition of your diet.");
    autonpcfunctions.AddTraderTrigger(".+","Ich werde Euch gar nichts über Euren Ernährungszustand sagen, es sei denn Ihr habt "..service[5].." Kupfermünzen für mich.");
    autonpcfunctions.AddCondition("state","=",50);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("money","<",service[5]);
    autonpcfunctions.AddAdditionalText("Kommt wieder, wenn Ihr "..service[5].." Kupfermünzen habt! Dann werde ich Euch etwas über Euren Ernährungszustand sagen.");
    autonpcfunctions.AddTraderTrigger(".+","");
    autonpcfunctions.AddCondition("state","=",50);
    autonpcfunctions.AddCondition("money",">=",service[5]);
    autonpcfunctions.AddConsequence("state","=",5);
    autonpcfunctions.AddConsequence("money","-",service[5]);
    -- ********* END DYNAMIC PART ********

    TradSpeakLang={0,1};
    TradStdLang=0;

    autonpcfunctions.increaseLangSkill(TradSpeakLang);
    thisNPC.activeLanguage=TradStdLang;

end

function M.nextCycle()  -- ~10 times per second
    M.initializeNpc();
    autonpcfunctions.SpeakerCycle();
end

function M.receiveText(texttype, message, originator)
    if autonpcfunctions.BasicNPCChecks(originator,2) then
		if autonpcfunctions.LangOK(originator,TradSpeakLang) then
            local status = 0;
		    race=originator:get_race()
		    if race>8 then
				thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Igitt, was auch immer du bist, hau bloß ab!")
				thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Yuck, whatever you are, go away!")
				return
		    elseif originator.attackmode then
				thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Bei den Fünfen, hört doch auf zu kämpfen!");
				thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "For the Five's sake, stop fighting!");
				return
		    end
			if NPCStatus[originator.id] ~= 6 then
				local text = string.lower(message);
				if string.find(text,"cure") or string.find(text,"heil") or string.find(text,"heal") then
					if string.find(text,"wound") or string.find(text,"wunde") then
						if string.find(text,"light") or string.find(text,"leicht") then
							status = 10;
						elseif string.find(text,"serious") or string.find(text,"schwer") then
							status = 20;
						end
					elseif string.find(text,"full") or string.find(text,"voll") then
						status = 30;
					end
				elseif string.find(text,"information") or string.find(text,"auskunft") or string.find(text,"diet") or string.find(text,"ern[äa]hrung") or string.find(text,"ernaehrung") then
					status = 50;
				end
				if string.find(text,"antidote") or string.find(text,"poison") or string.find(text,"gift") then
					status = 40;
				end
			end
			NPCStatus[originator.id]=status;
			-- check trigger
			--
			autonpcfunctions.TellSmallTalk(message,originator);
			
		    status=NPCStatus[originator.id];
		    local potion=false
		    if status==1 then
				thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Ihr wollt eine Heilung von leichten Wunden? Das macht "..service[1].." Kupfermünzen.");
				thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "You want to cure light wounds? That makes "..service[1].." copper coins.");
				potion=true;
				originator:LTIncreaseHP(500,5,2);
		    elseif status==2 then
				thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Ihr wollt eine Heilung von schweren Wunden? Das macht "..service[2].." Kupfermünzen.");
				thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "You want to cure serious wounds? That makes "..service[2].." copper coins.");
				potion=true;
				originator:LTIncreaseHP(500,10,2);
		    elseif status==3 then
				thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Ihr wollt eine volständige Heilung? Das macht "..service[3].." Kupfermünzen.");
				thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "You want a full heal? That makes "..service[3].." copper coins.");
				potion=true;
				originator:LTIncreaseHP(500,20,2);
		    elseif status==4 then
				thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Ihr wollt eine Heilung einer Vergiftung? Das macht "..service[4].." Kupfermünzen.");
				thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "You want to cure poisoning? That makes "..service[4].." copper coins.");
				potion=true;
				local PV=math.random(7500) + 5000;
				originator:setPoisonValue( common.Limit( (originator:getPoisonValue() - PV) , 0, 10000) );
				--originator:increasePoisonValue(-1*PV);
		    elseif status==5 then
				M.tellDiet(originator);
		    end
		    if potion then
				originator:talkLanguage(CCharacter.say, CPlayer.german, "#me trinkt einen Trank.");
				originator:talkLanguage(CCharacter.say, CPlayer.english, "#me drinks a potion.");
				originator.movepoints=originator.movepoints-20;
				world:makeSound(12,originator.pos);
		    end
        else
            autonpcfunctions.Confused(
               "#me sieht dich leicht verwirrt an",
               "#me looks at you a little confused"
            );
        end
    end
end

function M.tellDiet(User)
	foundEffect, dietEffect = User.effects:find(12);
	if foundEffect then
		foundConstMod, constMod = dietEffect:findValue("constMod");
	end
	if not foundEffect or not foundConstMod then
		constMod = 0;
	end
	
	if dietText == nil then
		dietText = {};
		dietText[1] = {};
		dietText[2] = {};
		dietText[1][1] = "Eure Ernährung scheint mir nur gewöhnlich zu sein, da gibt es viel zu verbessern."
		dietText[2][1] = "Many things about your commoner's diet can be improved."
		dietText[1][2] = "Ihr scheint auf Eure Ernährung zu achten, Euer Körper ist in guter Verfassung."
		dietText[2][2] = "You seem to eat quite well, your body is in a good condition."
		dietText[1][3] = "Also eine solch perfekte Ernährung habe ich schon lange nicht mehr gesehen."
		dietText[2][3] = "I haven't seen such a perfect diet for a long time."
		
		tipText = {};
		tipText[1] = {};
		tipText[2] = {};
		tipText[1][1] = "Ihr solltet wirklich Essen von Köchen und Bäckern zu Euch nehmen";
		tipText[2][1] = "Try asking a cook or a baker, you really should eat better food";
		tipText[1][2] = "Esst am besten mehr Schlemmereien von guten Köchen und Bäckern"
		tipText[2][2] = "Best you eat more gourmet dishes from good cooks and bakers"
		tipText[1][3] = "Macht einfach so weiter wie bisher"
		tipText[2][3] = "It's great, just keep it up"
		
		raceText = {};
		raceText[1] = {};
		raceText[2] = {};
		-- halflings
		raceText[1][3] = ", besonders Backwaren aber nichts mit Fisch";
		raceText[2][3] = ", especially bakery products but nothing that contains fish";
		-- orcs
		raceText[1][5] = ", besonders mit Fleisch aber nichts mit Früchten oder Gemüse";
		raceText[2][5] = ", especially containing meat but no fruit or vegetables";
		-- lizards
		raceText[1][6] = ", besonders mit Fisch aber keine Backwaren";
		raceText[2][6] = ", especially containing fish but no bakery products";
		-- fairies
		raceText[1][8] = ", besonders mit Früchten aber nichts mit Fleisch oder Fisch";
		raceText[2][8] = ", especially containing fruit but no meat or fish";
	end
	
	local race = User:get_race();
	local lang = User:getPlayerLanguage();
	local tellRace = false;
	if (race == 2 or race == 4 or race == 5 or race == 7) and constMod ~= 2 then
		tellRace = true;
	end
	
	thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Diese Auskunft kostet "..service[5].." Kupfermünzen.");
	thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "My professional services cost "..service[5].." copper coins.");
	thisNPC:talk(CCharacter.whisper, dietText[lang+1][constMod+1].." "..tipText[lang+1][constMod+1]..( tellRace and raceText[lang+1][race+1] or "" ).."!");
end

return M
