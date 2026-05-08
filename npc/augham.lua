local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-81,-151,0,6,false,'Augham','npc_augham.lua',0);
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
-- drunken Town guard
    autonpcfunctions.AddTraderTrigger("Gobaith","Uhhh, Gobb...aithh... I got en'uff to doo with dis strange town over here! *hicks*");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Gobaith","Uhhh, Gobb...aithh... Ich hab schonnn genugg zu tun mitt diesser Stadd dord drübn! *hicks*");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Greenbriar","Greeeenn...what? Is diss that town with those li'l people?");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Greenbriar","Greeeenn...was? Is diss that town with those li'l people?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Hafen","Welcherrr 'afen? Gibt's da 'n Wirtshauss?");
    autonpcfunctions.AddTraderTrigger("Harbo[u]+r","Whhhhich 'arbooor? Is dere 'ny pub?");
    autonpcfunctions.AddTraderTrigger("Hellbriar","Whhhad is Hell...whaaad?");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Hellbriar","Wasss ist Hell...was?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("I am","Nice to meeet y'o.");
    autonpcfunctions.AddTraderTrigger("I'm","Nice to meeet y'o.");
    autonpcfunctions.AddTraderTrigger("Ich bin","Nett dich kennnnnen su lernn'n.");
    autonpcfunctions.AddTraderTrigger("Mag Academy","Dose ssstubid magess. Theyyy never dring anydn'g.");
    autonpcfunctions.AddTraderTrigger("Magierakademie","Diesee dumennn Mag'er. Die tringgen ja nie w's.");
    autonpcfunctions.AddTraderTrigger("Nordmark","Gee... isn'd dad som'where 'n da south?");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Nordmark","Ahhh... Isss das nicht irgennnwo im Südn?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Silberbrand","Habd ihr Zwergennnbier dabai? Es gibbd kein bessseres.");
    autonpcfunctions.AddTraderTrigger("Silverbrand","Do youuu 'ave some dre..daw...dwarfffen beer withh youuu? Dere's no bedder one.");
    autonpcfunctions.AddTraderTrigger("Tol Vanima","'olll Vvvanima?");
    autonpcfunctions.AddTraderTrigger("Troll Bane","Ya, Trollll's Bane. Dis is Torl..Trollll's Brane be'ind me.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Troll Bane","Jaa, Trollll's Bane. Das hinnder mir ist Torl..Trollll's Brane.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Varshikar","Vashhhigar. Wasn't theeere somethinggg with... whatever. Id's somewhere over therre.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Varshikar","Vashhhigar.Warr da nicccht was midd... wieauchimmer. Es iiisd irgendwo dordddrüb'n.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("auf bald","Prost!");
    autonpcfunctions.AddTraderTrigger("beruf","Ich binnn Wächder in Toroll...Troll's Bar..Bane. Und ich be'ache d'see verdammmmde Stadt verdammmmd gut!");
    autonpcfunctions.AddTraderTrigger("buy","Wanna buy sommething?");
    autonpcfunctions.AddTraderTrigger("bye","Cheeers!");
    autonpcfunctions.AddTraderTrigger("dein name","Mein nameee? Ich heiiiße %npcname");
    autonpcfunctions.AddTraderTrigger("deine aufgabe","Ich bewache die Staddd. Diese Stadddda, Terolles Bane. Hinder mirrr. *hicks*");
    autonpcfunctions.AddTraderTrigger("eure aufgabe","Ich bewache die Staddd. Diese Stadddda, Terolles Bane. Hinder mirrr. *hicks*");
    autonpcfunctions.AddTraderTrigger("farewell","You leave? I sh'ld have aaaanother drink.");
    autonpcfunctions.AddTraderTrigger("god","Gods, goddds. Overrated, I telllll you.");
    autonpcfunctions.AddTraderTrigger("good day","Day? What day? *hicks*");
    autonpcfunctions.AddTraderTrigger("gr[üue]+[sß]+e","Ich grüüße euch... Wi..Wie kann de Stadddwahe euch 'elfen? *hicks*");
    autonpcfunctions.AddTraderTrigger("greetings","Greeedings. How ca... can the townguardsss 'elp you? *hicks*");
    autonpcfunctions.AddTraderTrigger("greets","Greeedings. How ca... can the townguardsss 'elp you?");
    autonpcfunctions.AddTraderTrigger("guten tag","Tag? Welcher Tag? *hicks*");
-- götternamen
    autonpcfunctions.AddTraderTrigger("hail","Hail to you.");
    autonpcfunctions.AddTraderTrigger("hallo","Seid gergerrüßt! Issst es nich' schön hirr?");
    autonpcfunctions.AddTraderTrigger("helfen","Ihr wolld mir helfennn? Gud, bringt miir eine Flascheee Wein! *hicks*");
    autonpcfunctions.AddTraderTrigger("hello","Be grgreeeeded! Isssn't id nice here?");
    autonpcfunctions.AddTraderTrigger("help","You wannnnna helpp?");
    autonpcfunctions.AddTraderTrigger("hilfe","Du willllsd helfenn?");
    autonpcfunctions.AddTraderTrigger("how are you","Fine. I am thurstyyy.");
    autonpcfunctions.AddTraderTrigger("job","My job iss to *hicks* guard Torll..Tre..Trollos Bane. This townnn behind me.");
    autonpcfunctions.AddTraderTrigger("kaufen","Ich haabe doch gein Gellld, wie solll ich wasss gaufn?");
    autonpcfunctions.AddTraderTrigger("mein name","Sehrr angenemm. Meinnn Name... Ich heißßße %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("mission","My missission is to... yes, tooo guard thad town. Trorrs Bane.");
    autonpcfunctions.AddTraderTrigger("my name","Pleasssure to meet youu. Myyy name... I am %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("neu","Du bist neu hier? Geh am besten in die Stadt hinter mir, Troll's Bane, und suche nach Leuten, die dir helfen können.");
    autonpcfunctions.AddTraderTrigger("I[ a']+m new","You are new to Illarion? You should visit the town behind me, Troll's Bane. Search for people who can help you.");
    autonpcfunctions.AddTraderTrigger("newbie","You are new to Illarion? You should visit the town behind me, Troll's Bane. Search for people who can help you.");
    autonpcfunctions.AddTraderTrigger("quest","I'mm always searching *hicks* foor someth'ng do dringg.");
    autonpcfunctions.AddTraderTrigger("sell","I don't selll anyding.");
    autonpcfunctions.AddTraderTrigger("t[äae]+tigkeit","Ich bewache die Staddd. Diese Stadddda, Terolles Bane. Hinder mirrr. *hicks*");
    autonpcfunctions.AddTraderTrigger("verkaufen","Ichhh vergaufffe gar nix. *hicks*");
    autonpcfunctions.AddTraderTrigger("was kaufst","Ich haabe doch gein Gellld, wie solll ich wasss gaufn?");
    autonpcfunctions.AddTraderTrigger("was tust du","Ich bewache die Staddd. Diese Stadddda, Terolles Bane. Hinder mirrr. *hicks*");
    autonpcfunctions.AddTraderTrigger("was tut ihr","Ich bewache die Staddd. Diese Stadddda, Terolles Bane. Hinder mirrr. *hicks*");
    autonpcfunctions.AddTraderTrigger("was verkaufst","Ich vergaufffe gar nichhds.");
    autonpcfunctions.AddTraderTrigger("wer seid","Ich bewachhhhe die.. alsoo Tero...Trollse Banne.");
    autonpcfunctions.AddTraderTrigger("wer","Ich bewachhhhe die.. alsoo Tero...Trollse Banne.");
    autonpcfunctions.AddTraderTrigger("what buy","I haveee no money, how woould I buy anyth *hicks* ing?");
    autonpcfunctions.AddTraderTrigger("what sell","I don't selll anyding.");
    autonpcfunctions.AddTraderTrigger("what you do","My job iss to *hicks* guard Torll..Tre..Trollos Bane. This townnn behind me.");
    autonpcfunctions.AddTraderTrigger("where am I","You are inn Troob...Torb...Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("who","My job iss to *hicks* guard Torll..Tre..Trollos Bane. This townnn behind me.");
    autonpcfunctions.AddTraderTrigger("wie geht es","Mirr gehtt es gudd. Fragtt doch mal diee Stadd, derr gehts sich'r nicht gut, die drehht sich... *hicks*");
    autonpcfunctions.AddTraderTrigger("wie hei[sß]+t du","Ich heißße %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("wo bin ich","Du bisst in Troob...Torb...Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("you name","I amm %NPCNAME");
    autonpcfunctions.AddTraderTrigger("wache","Dieee Wache? Wir llleisten guute Arbeid!");
    autonpcfunctions.AddTraderTrigger("guard","Theee town guardss? We're doinnn' great worgg!");
    autonpcfunctions.AddCycleText("Hicks!","Hicks!");
    autonpcfunctions.AddCycleText("#me schwankt nach links","#me tumbles to the left");
    autonpcfunctions.AddCycleText("#me schwankt nach rechts","#me tumbles to the right");
    autonpcfunctions.AddCycleText("#me rülpst","#me burps");
    autonpcfunctions.AddCycleText("#me zieht eine kleine Flasche aus der Tasche und trinkt einen Schluck","#me pulls a bottle out of his pocket and takes a sip");
    autonpcfunctions.AddCycleText("#me lallt etwas unverständliches","#me brabbles something ununderstandable");    -- ********* END DYNAMIC PART ********
    TradSpeakLang={0,1};
    TradStdLang=0;
    
    autonpcfunctions.increaseLangSkill(TradSpeakLang)
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
