local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-413, -145, 0,6,false,'Siloli','npc_siloli.lua',0);

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
-- comes from trader with qs=2
-- qs=3: can you proove?
-- qs=4: want that children starve?
-- qs=5: half of ham
-- qs=10: finished talking ham, gave something to him
-- qs=11: finished talking, didn't give anything to him, lack of proof.
-- qs=12: finished talking, angry
autonpcfunctions.SetRadius( 10 );
QuestID=557;
    autonpcfunctions.AddTraderTrigger(".+","Geh mir aus den Augen!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("chance",20);
    autonpcfunctions.AddTraderTrigger(".+","Verschwinde, ich will dich nicht mehr sehn!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("chance",25);
    autonpcfunctions.AddTraderTrigger(".+","Mörder meiner Kinder, weg mit dir!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("chance",33);
    autonpcfunctions.AddTraderTrigger(".+","Geh weg!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("chance",50);
    autonpcfunctions.AddTraderTrigger(".+","Was machst du noch hier?");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger(".+","Get out of my sight!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("chance",20);
    autonpcfunctions.AddTraderTrigger(".+","Get lost, I don't want to see you anymore!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("chance",25);
    autonpcfunctions.AddTraderTrigger(".+","murderer of my children, go away!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("chance",33);
    autonpcfunctions.AddTraderTrigger(".+","Go away!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("chance",50);
    autonpcfunctions.AddTraderTrigger(".+","Why are you still here?");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("one[ ]*arm","I have two arms, of course!");
    autonpcfunctions.AddTraderTrigger("ein[ ]*arm","Ich habe natürlich zwei Arme!");
    autonpcfunctions.AddTraderTrigger("steal","What should I have stolen?");
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("stehlen","Was soll ich gestohlen haben?");
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("thief","What should I have stolen?");
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("dieb","What should I have stolen?");
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("ham","You accuse me of stealing ham? That's a bad accusation, can you prove that?");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("schinken","Ich soll Schinken gestohlen haben? Das ist eine harte Beschuldigung, kannst du das beweisen?");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("ham","I should have delivered ham? That would mean that I stole it? That's a bad accusation, can you prove that?");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("schinken","Ich sollte Schinken liefern? Das würde ja heißen, dass ich ihn gestohlen habe! Das ist eine harte Beschuldigung, kannst du das beweisen?");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("wo schinken","Welcher Schinken denn? Wo soll der denn sein?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("gib schinken","Ich soll dir meinen Schinken geben? Wieso?");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("give ham","I should give you my ham? Why?");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("where ham","Which ham? Where should that ham be?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("schinken gestohlen","Ich soll Schinken gestohlen haben? Das ist eine harte Beschuldigung, kannst du das beweisen?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("schinken genommen","Ich soll Schinken gestohlen haben? Das ist eine harte Beschuldigung, kannst du das beweisen?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("gestohlen","Ich soll Schinken gestohlen haben? Das ist eine harte Beschuldigung, kannst du das beweisen?");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("schinken geklaut","Ich soll Schinken gestohlen haben? Das ist eine harte Beschuldigung, kannst du das beweisen?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("geklaut","Ich soll Schinken gestohlen haben? Das ist eine harte Beschuldigung, kannst du das beweisen?");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("stole ham","You accuse me of stealing ham? That's a bad accusation, can you prove that?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("took ham","You accuse me of stealing ham? That's a bad accusation, can you prove that?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("take ham","You accuse me of stealing ham? That's a bad accusation, can you prove that?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("ham stole","You accuse me of stealing ham? That's a bad accusation, can you prove that?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("wo schinken","Ich habe keinen Schinken, wie oft denn noch?");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("where ham","I don't have any ham, how often should I repeat that?");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("stole ham","I didn't steal any ham!");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("ham stole","I didn't steal any ham!");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("du schinken gestohlen","Ich habe keinen Schinken gestohlen!");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("ja","Oh... nun, ich habe den Schinken, der mir angeboten wurde, genommen, aber kann man das 'Stehlen' nennen? Ich brauche ihn doch für meine Familie! Willst du wirklich, dass meine Kinder hungern?");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("nein","Na eben. Wenn du's nicht beweisen kannst, dann äußere solche Anschuldigungen besser nicht.");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("ja","Hast du keine Kinder? Du bist herzlos! Also gut, ich schlage dir ein Geschäft vor: Ich gebe dir die Hälfte des Schinkens, einverstanden?");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",5);
    autonpcfunctions.AddTraderTrigger("nein","Na eben, du bist ja doch nicht so herzlos wie ich dachte. Aber ich denke, ich kann dir zwei Stück Schinken abgeben.");
    autonpcfunctions.AddConsequence("item",306,2,333,0);
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("ja","Gut, ich glaube, das ist fair, immerhin hast du ja Beweise. Und bis Übermorgen habe ich sicher im Wald einige Pilze für meine Kinder gesammelt. Hier, der Schinken.");
    autonpcfunctions.AddConsequence("item",306,2,333,0);
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("nein","Du willst wirklich meine Kinder sterben sehen! Hast du denn gar keine Vaterinstinkte?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("nein","Du willst wirklich meine Kinder sterben sehen! Hast du denn gar keine Mutterinstinkte?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("doch","Na eben. Ich gebe dir sechs Stück Schinken, dann bekommt jedes meiner Kinder noch ein halbes Stück.");
    autonpcfunctions.AddConsequence("item",306,6,333,0);
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("ja","Na eben. Ich gebe dir sechs Stück Schinken, dann bekommt jedes meiner Kinder noch ein halbes Stück.");
    autonpcfunctions.AddConsequence("item",306,6,333,0);
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("nein","Nun gut, du erbarmungsloses Etwas. Ich werde dir eine Einladung zur Beerdigung meiner Kinder schicken... Hier, dein verdammter Schinken! Und jetzt geh mir aus den Augen!");
    autonpcfunctions.AddConsequence("item",306,10,333,0);
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",12);
    autonpcfunctions.AddTraderTrigger("yes","Oh... well, I took that ham that someone wanted to give to me, but can you consider that 'stealing'? I need it for my family! Or do you want to see my children starving?");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("no","See? If you can't prove it, you shouldn't speak our such bad accusations.");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("yes","Don't you have children? You are so heartless! Well, I propose a deal: I'll give you half of my ham, can you accept that?");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",5);
    autonpcfunctions.AddTraderTrigger("no","Ah, you're not so heartless than I thought. I think I can give you two pieces of my ham.");
    autonpcfunctions.AddConsequence("item",306,2,333,0);
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("yes","Good, I think that's fair enough, I mean, you have a proof. I will surely find some mushrooms within the next days to feed my children. Here you are.");
    autonpcfunctions.AddConsequence("item",306,2,333,0);
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("no","You really want to see my children starve! Don't you have paternal instinkts?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("no","You really want to see my children starve! Don't you have maternal instinkts?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("yes","Very good. I will give you six pieces of my ham, that way my children get half a piece each.");
    autonpcfunctions.AddConsequence("item",306,6,333,0);
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("no","Well, you merciless something! I'll send you invitations for the burial of my children... Here, your damn ham! And now, get lost!");
    autonpcfunctions.AddConsequence("item",306,10,333,0);
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",12);
    autonpcfunctions.AddTraderTrigger("schinken","Ein wundervoller Genuß, so ein paar Stücke Schinken können eine ganze Familie einige Tage lang ernähren!");
    autonpcfunctions.AddTraderTrigger("ham","Mmmh, ham, I love it! A few pieces of ham can feed a whole family for some days!");
    autonpcfunctions.AddTraderTrigger("Hafen","Der Hafen? Da war ich als Kind einmal, ich weiß gar nicht genau, wo der ist.");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("Hafen","Am Hafen war ich erst unlängst, schöne Gegend!");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("Hafen","Jaja, der Hafen. Da gibt es Schiffe und Wasser, nicht?");
    autonpcfunctions.AddTraderTrigger("Harbo[u]+r","The harbor? I once was there, as a child. I can't even remember where it was.");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("Harbo[u]+r","I visited the harbor recently, nice spot there!");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("Harbo[u]+r","Yes, the harbor. There are ships and water, isn't it?");
    autonpcfunctions.AddTraderTrigger("I am","Greetings, %CHARNAME, nice to meet you.");
    autonpcfunctions.AddTraderTrigger("I'm","Greetings, %CHARNAME, nice to meet you.");
    autonpcfunctions.AddTraderTrigger("Ich bin","Seid gegrüßt, %CHARNAME, schön euch zu treffen.");
    autonpcfunctions.AddTraderTrigger("auf bald","Gehabt euch wohl!");
    autonpcfunctions.AddTraderTrigger("beruf","Ich bin ein einfacher Bauer, nur ein Bauer.");
    autonpcfunctions.AddTraderTrigger("buy","I don't buy anything.");
    autonpcfunctions.AddTraderTrigger("bye","Farewell!");
    autonpcfunctions.AddTraderTrigger("dein name","Ich heiße %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("deine aufgabe","Ich bin nur ein Bauer.");
    autonpcfunctions.AddTraderTrigger("eure aufgabe","Ich bin nur ein Bauer.");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell, thanks for visiting me!");
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("good day","Hello.");
    autonpcfunctions.AddTraderTrigger("gr[üue]+[sß]+e","Seid gegrüßt!");
    autonpcfunctions.AddTraderTrigger("greetings","Be greeted.");
    autonpcfunctions.AddConsequence("talk","begin");
    autonpcfunctions.AddTraderTrigger("greets","Be greeted.");
    autonpcfunctions.AddTraderTrigger("guten tag","Seid gegrüßt!");
    autonpcfunctions.AddCondition("idlestate","idle");
    autonpcfunctions.AddTraderTrigger("guten tag","Ich rede später mit dir.");
    autonpcfunctions.AddCondition("idlestate","busy");
    autonpcfunctions.AddTraderTrigger("hail","Be greeted.");
    autonpcfunctions.AddTraderTrigger("hallo","Seid gegrüßt!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("hallo","Be greeted.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("helfen","Wenn du Hilfe brauchst, geh nach Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("hello","Be greeted.");
    autonpcfunctions.AddTraderTrigger("help","If you need help, visit Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("hilfe","Wenn du Hilfe brauchst, geh nach Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("how are you","I am fine, thanks. How are you?");
    autonpcfunctions.AddTraderTrigger("job","I am just a simple farmer.");
    autonpcfunctions.AddTraderTrigger("kaufen","Ich kaufe nichts.");
    autonpcfunctions.AddTraderTrigger("mein name","Sehr angenehm.");
    autonpcfunctions.AddTraderTrigger("my name","Nice to meet you.");
    autonpcfunctions.AddTraderTrigger("sell","I don't sell anything");
    autonpcfunctions.AddTraderTrigger("verkaufen","Ich handle nicht.");
    autonpcfunctions.AddTraderTrigger("was kaufst","Ich handle nicht.");
    autonpcfunctions.AddTraderTrigger("was tust du","Was ein Bauer eben so tut.");
    autonpcfunctions.AddTraderTrigger("was tut ihr","Was ein Bauer eben so tut.");
    autonpcfunctions.AddTraderTrigger("was verkauf[s]*t","Ich handle nicht.");
    autonpcfunctions.AddTraderTrigger("wer seid","Ich bin %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("what buy","I don't trade");
    autonpcfunctions.AddTraderTrigger("what sell","I don't trade");
    autonpcfunctions.AddTraderTrigger("what you do","I just do what a farmer does.");
    autonpcfunctions.AddTraderTrigger("who","I am %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("wie geht es","Danke, mir geht es gut.");
    autonpcfunctions.AddTraderTrigger("wie hei[sß]+t du","Ich heiße %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("you name","My name is %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("carrier","What carrier? What should I have delivered?");
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("bote","Was für ein Bote? Was soll ich denn überbracht haben?");
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddCondition("qpg","=",2);
    -- ********* END DYNAMIC PART ********
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

function M.lookAtNpc(Char, mode)
    if initLook==nil then
        output={};
        output[0]="Ein verdächtig wirkender, magerer Kerl, der nervöse Blicke um sich wirft. Ein abgenagter Knochen lugt aus seiner Hosentasche.";
        output[1]="A suspicious, thin guy glancing around nervously. You can see a bone peeking out of his pocket.";
        initLook=1;
    end
    lang=Char:getPlayerLanguage();
    Char:sendCharDescription( thisNPC.id , output[lang] );
end

return M
