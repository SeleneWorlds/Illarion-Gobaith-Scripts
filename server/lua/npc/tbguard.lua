local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-64,-105,0,0,false,'John Leador','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-64,-108,0,4,false,'Adran Tanner','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-67,-117,0,6,false,'Faldor Norem','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-65,-130,0,6,false,'Hagen Delmos','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-73,-143,0,4,false,'Jon Fehrin','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-78,-143,0,4,false,'Kelvin Rakarv','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-100,-139,0,4,false,'Laran Threll','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-97,-139,0,4,false,'Manuel Lenath','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-98,-112,0,4,false,'Neris Ovento','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-116,-123,0,4,false,'Rowan Gavin','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-119,-97,0,6,false,'Seron Lefar','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-134,-102,0,4,false,'Talon Lefar','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-155,-88,0,6,false,'Viktor Arkon','npc_tbguard.lua',0);
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-155,-84,0,6,false,'Toran Lobas','npc_tbguard.lua',0);
local autonpcfunctions = require("npc.base.autonpcfunctions")
function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Finger weg!");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Don't you touch me!");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();

    -- ********* START DYNAMIC PART ********

    autonpcfunctions.SetRadius(0);
    autonpcfunctions.AddCycleText("#me blickt sich aufmerksam um.","#me looks around concentrated.");
    autonpcfunctions.AddCycleText("#me lehnt sich leicht gegen die Wand.","#me leans slightly against the wall.");
    autonpcfunctions.AddCycleText("#me blickt zum Tor.","#me looks towards the door.");
    autonpcfunctions.AddCycleText("#me blickt zu seinem Partner und nickt ihm zu.","#me looks to his partner and nods to him.");
    autonpcfunctions.AddCycleText("#me gähnt leicht und hält die Hand vor den Mund.","#me yawns slightly and puts his hand in front of his mouth.");
    autonpcfunctions.AddCycleText("#me wischt über seine Rüstung bis diese wieder glänzt.","#me wipes over his armor until it looks shiny again.");
    autonpcfunctions.AddCycleText("#me hustet kurz.","#me coughs once.");
    autonpcfunctions.AddTraderTrigger("Help","(( [Help] This is a NPC with the name %NPCNAME. He reacts on: Hello, Who are you, What do you do, Troll's Bane");
    autonpcfunctions.AddAdditionalTrigger("Hilfe");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Help","(( [Hilfe] Das ist ein NPC mit Namen %NPCNAME. Er reagiert auf: Hallo, Wer bist du, Was machst du, Troll's Bane");
    autonpcfunctions.AddAdditionalTrigger("Hilfe");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Grü[ßs]+e","Grüße euch");
    autonpcfunctions.AddAdditionalTrigger("Hallo");
    autonpcfunctions.AddAdditionalTrigger("Hi");
    autonpcfunctions.AddAdditionalTrigger("Hiho");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddAdditionalText("Guten Tag");
    autonpcfunctions.AddAdditionalText("Grüße, geht jetzt weiter ich muss aufpassen");
    autonpcfunctions.AddAdditionalText("Hmmm? Was? Ah...grüße, ja ja.");
    autonpcfunctions.AddAdditionalText("Grüße, wollt ihr etwas?");
    autonpcfunctions.AddTraderTrigger("Greetings","Greetings");
    autonpcfunctions.AddAdditionalTrigger("Hello");
    autonpcfunctions.AddAdditionalTrigger("Hi");
    autonpcfunctions.AddAdditionalTrigger("Good day");
    autonpcfunctions.AddAdditionalTrigger("Hiho");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddAdditionalText("Good day");
    autonpcfunctions.AddAdditionalText("Greetings, move along now please, I have to watch");
    autonpcfunctions.AddAdditionalText("Hmm? What? Ah... greetings, yes yes.");
    autonpcfunctions.AddAdditionalText("Greetings, do you want anything?");
    autonpcfunctions.AddTraderTrigger("Auf bald","Auf bald und haltet euch an die Gesetze in der Stadt.");
    autonpcfunctions.AddAdditionalTrigger("Bis bald");
    autonpcfunctions.AddAdditionalTrigger("Tschüss");
    autonpcfunctions.AddAdditionalTrigger("Wiedersehen");
    autonpcfunctions.AddAdditionalTrigger("Mach[t]*s gut");
    autonpcfunctions.AddAdditionalText("Bis bald, wenn etwas passiert wisst ihr wo ich bin.");
    autonpcfunctions.AddTraderTrigger("Farewell","Farewell and follow the laws of this town.");
    autonpcfunctions.AddAdditionalTrigger("Be well");
    autonpcfunctions.AddAdditionalTrigger("Bye");
    autonpcfunctions.AddAdditionalTrigger("see you");
    autonpcfunctions.AddAdditionalText("Farewell, in case something happens you know where to find me.");
    autonpcfunctions.AddTraderTrigger("Wer du","Ich bin %NPCNAME, Stadtwache von Troll's Bane und Soldat in der Armee Salkamars! Hail dem Imperium!");
    autonpcfunctions.AddAdditionalTrigger("Wer sie");
    autonpcfunctions.AddAdditionalTrigger("Wer ihr");
    autonpcfunctions.AddTraderTrigger("Who you","I'm %NPCNAME, town guard of Troll's Bane and soldier at the salkamaerian Army");
    autonpcfunctions.AddTraderTrigger("Was tust","Was meine Aufgabe ist? Wonach sieht es denn aus? Ich passe hier auf das keiner Ärger macht.");
    autonpcfunctions.AddAdditionalTrigger("Was machst");
    autonpcfunctions.AddAdditionalTrigger("Was macht");
    autonpcfunctions.AddAdditionalTrigger("Was tut");
    autonpcfunctions.AddAdditionalTrigger("Aufgabe");
    autonpcfunctions.AddTraderTrigger("What do","What my task is? What does it look like? I'm watching so nobody causes any trouble here.");
    autonpcfunctions.AddAdditionalTrigger("work");
    autonpcfunctions.AddAdditionalTrigger("task");
    autonpcfunctions.AddTraderTrigger("Troll's Bane","Ja das hier ist Troll's Bane, eine ziemlich herunter gekommene Stadt die nun aber dank Prinz von Lonewood wieder erblühen wird! Dabei helfen ihm Herzog Devan und Herzog Ross.");
    autonpcfunctions.AddAdditionalTrigger("Trolls Bane");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Troll's Bane","Well yes this is Troll's Bane, it's a mess here, but thanks to prince of Lonewood this town will become much better now! By this he is supported by Duke Devan and Duke Ross.");
    autonpcfunctions.AddAdditionalTrigger("Trolls Bane");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Varshikar","Varshikar ist eine kleine Stadt im Nordosten. Die Träger des Feuers haben dort ihren Sitz.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Varshikar","Varshikar is a small town in the northeast. The bearers of fire live there.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Nordmark","Das ist irgendeine Barbarensiedlung. Soll im Norden sein... mehr weis ich davon nicht.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Nordmark","This is some barbarian settlement. Somewhere in the north, I don't know more about this.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Greenbriar","Die Halblingssiedlung, liegt im Südwesten auf einer kleinen Insel. Etwas südlich davon ist das Versteck der Tempelratten.");
    autonpcfunctions.AddAdditionalTrigger("Green Briar");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Greenbriar","The halfling settlement, this is located in the south west on a small island. A little south of is the hideout of the temple rats is located.");
    autonpcfunctions.AddAdditionalTrigger("Green Briar");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Hellbriar","Das ist das Versteck des Tempels, einer Bande von Mördern, Entführern, Moschran Anbetern und Nekromanten. Die Sorte von Leuten die in Troll's Bane nichts zu suchen haben.");
    autonpcfunctions.AddAdditionalTrigger("Hell Briar");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Hellbriar","This is the hideout of the temple, a group of murderers, kidnappers, moshran worshippers and necromants. The kind of persons who are absolutly not wanted in Troll's Bane.");
    autonpcfunctions.AddAdditionalTrigger("Hell Briar");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Vanima","Die Insel der Elfen, soll ein ziemlich ruhiger Ort sein, ich war nie dort.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Vanima","The island of the elves. I heared is a pretty quiet place... but I was never there myself.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Silberbrand","Ah ja, Silberbrand, Heimat der Zwerge. Die haben mit Abstand das beste Bier hier auf der Insel!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Silverbrand","Ah yes, Silverbrand. Home of the dwarfs. They make the best beer on this island by far!");
    autonpcfunctions.AddAdditionalTrigger("Silberbrand");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Union","Die Farmers Union... das sind ein paar Bauern die südlich von Troll's Bane leben glaube ich.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Union","The farmers union... thats some peasants who live south of Troll's Bane as far as I know.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Lonewood","Unser großer Anführer, Prinz Anarius of Lonewood. Er regiert Troll's Bane und hat die ganzen Verbrecher, wie den Tempel, die diese Stadt bevölkert haben hinausgetrieben!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Lonewood","Out great leader, prince Anarius of Lonewood. He leads Troll's Bane and drove all those criminals, such as the temple, who were in that town out!");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Ross","Herzog Roland Ross ist einer der Herzöge von Troll's Bane die den Prinzen bei seiner Arbeit zum Wohle der Stadt unterstützen.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Ross","Duke Roland Ross is one of the dukes of Troll's Bane who help the prince at this work to improve the welfare of the town.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Devan","Herzog Geralt Devan ist einer der Herzöge von Troll's Bane die den Prinzen bei seiner Arbeit zum Wohle der Stadt unterstützen.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Devan","Duke Geralt Devan is one of the dukes of Troll's Bane who help the prince at this work to improve the welfare of the town.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Mitglieder Tempel","Man muss den Feind kennen um ihn zu besiegen. Darum sage ich euch die bekannten Mitglieder des Tempels. Es sind Verdazar, Joxia Doral, Dain Laiden, Daelyn, Johann Brown, Drathe Blue, Endyl, Dominic Fisher, Edward Cromwell, Orioli, Dramyr, Misjlah, Azrael Suruki, Slug'nar, Thain, Ian Blyte, Lindian und Erick McSpinan. Merkt euch diese Namen, sie sind der Feind!");
    autonpcfunctions.AddAdditionalTrigger("Mitglieder Temple");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Members Temple","One has to know the enemy to defend it. So I tell you the currently known members of the temple. There are Verdazar, Joxia Doral, Dain Laiden, Daelyn, Johann Brown, Drathe Blue, Endyl, Dominic Fisher, Edward Cromwell, Orioli, Dramyr, Misjlah, Azrael Suruki, Slug'nar, Thain, Ian Blyte, Lindian and Erick McSpinan. Remember them! They are the enemy!");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Temple","Der Tempel ist eine Bande von Verbrechern, Halsabschneidern, Mördern, Entführern, Moschran Anbetern und Nekromanten! Jedes ihrer Mitglieder ist aus der Stadt verbannt!");
    autonpcfunctions.AddAdditionalTrigger("Tempel");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Temple","The temple is a group of criminals, cutthroats, murderers, kidnappers, Moshran worshippers and necromants! Every of their members is banned from the town!");
    autonpcfunctions.AddAdditionalTrigger("Tempel");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Träger Feuer","Die Träger des Feuers leben im Nordenosten, bei Varshikar. Sie kämpfen wie auch Troll's Bane gegen Abschaum wie den Tempel. Angeführt werden sie von Djironnyma.");
    autonpcfunctions.AddAdditionalTrigger("Bearer Fire");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Bearer Fire","The Bearers of Fire live in the north east, at Varshikar. They fight, similar to Troll's Bane against scums like the temple. They are leaded by Djironnyma.");
    autonpcfunctions.AddCondition("lang","english");
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
            autonpcfunctions.TellSmallTalk(message,originator);
        else
            autonpcfunctions.Confused(
               "#me sieht dich leicht verwirrt an",
               "#me looks at you a little confused"
            );
        end
    end
end

return M
