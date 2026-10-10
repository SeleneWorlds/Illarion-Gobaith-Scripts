local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-86,-23,0,2,false,'Hauptmann Arkos Seldaran','npc_hauptmann_arkos_seldaran.lua',0);

local autonpcfunctions = require("npc.base.autonpcfunctions")

function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Finger weg!");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Dont you touch me!");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();

    -- ********* START DYNAMIC PART ********
    QuestID = 589;
    autonpcfunctions.SetRadius(40);
    autonpcfunctions.AddCycleText("#me blickt sich um, offenbar jemanden suchend.","#me looks around, it seems he's looking for someone.");
    autonpcfunctions.AddCycleText("#me trägt eine alte albarische Rüstung","#me wears an old albarian armor");
    autonpcfunctions.AddCycleText("#me blickt gedankenverloren zum Himmel","#me looks lost in thought to the sky");
    autonpcfunctions.AddCycleText("#me versucht vergeblich, seine stumpf gewordene albarische Rüstung zu polieren.","#me tries in vain to polish his dull albarian armor.");

    autonpcfunctions.AddTraderTrigger("[wW]er bist du","Ich bin "..thisNPC.name..". Wie ist dein Name?");
    autonpcfunctions.AddTraderTrigger("[wW]er seid ihr","Mein Name ist "..thisNPC.name..", wie lautet den eurer?");
    autonpcfunctions.AddTraderTrigger("[wW]ie hei[sß]+t du","Ich heisse "..thisNPC.name..". Wie ist dein Name?");
    autonpcfunctions.AddTraderTrigger("[dD]u bist","Ich bin "..thisNPC.name..". Wie ist dein Name?");
    autonpcfunctions.AddTraderTrigger("[Ii]hr seid","Ich bin "..thisNPC.name..". Wie ist euer Name?");
    autonpcfunctions.AddTraderTrigger("[Ii]ch bin neu","Tach, schön dich zu treffen. Mein Name ist "..thisNPC.name..", wie ist deiner?");
    autonpcfunctions.AddTraderTrigger("[Ww]ie geht[s]","Mir geht es eigentlich ganz gut, danke.");
    autonpcfunctions.AddTraderTrigger("[Hh]elping, [Mm]aking","Aye, I could need your help. Maybe you can bring me a pipe and after this about 10 Sibanac leaves?");
    autonpcfunctions.AddCondition("qpg","=",0);

    autonpcfunctions.AddTraderTrigger("[Dd]ein.+[Jj]ob","Was interessiert dich was ich mache?");
    autonpcfunctions.AddTraderTrigger("[Dd]ein.+[Bb]eruf","Was interessiert dich was ich mache?");
    autonpcfunctions.AddTraderTrigger("[Ee]uer.+[Bb]eruf","Was interessiert dich was ich mache?");
    autonpcfunctions.AddTraderTrigger("[Dd]eine [Tt][äae]+tigkeit","Ich suche nach jemanden der mir was besorgt! Willst mir helfen?");
    autonpcfunctions.AddTraderTrigger("[Ee]ure [Tt][äae]+tigkeit","Ich suche nach jemanden der mir was besorgt! Willst mir helfen?");
    autonpcfunctions.AddTraderTrigger("[Dd]eine [Aa]ufgabe","Ich suche nach jemanden der mir was besorgt! Willst mir helfen?");
    autonpcfunctions.AddTraderTrigger("[Ee]ure [Aa]ufgabe","Ich suche nach jemanden der mir was besorgt! Willst mir helfen?");
    autonpcfunctions.AddTraderTrigger("[Ww]as tust du","Ich suche nach jemanden der mir was besorgt! Willst mir helfen?");
    autonpcfunctions.AddTraderTrigger("[Ww]as tut ihr","Ich suche nach jemanden der mir was besorgt! Willst mir helfen?");
    autonpcfunctions.AddTraderTrigger("[Kk]aufen","Ich verkaufe nichts! Sehe ich etwa aus wie ein Händler ?");
    autonpcfunctions.AddTraderTrigger("[Vv]erkaufen","Nein! Ich habe bereits alles, was ich brauche.");
    autonpcfunctions.AddTraderTrigger("[Ww]as kaufst","Nein! Ich habe bereits alles, was ich brauche.");
    autonpcfunctions.AddTraderTrigger("[Ww]as verkaufst","Ich verkaufe nichts! Sehe ich etwa aus wie ein Händler ?");
    autonpcfunctions.AddTraderTrigger("[Gg]obiath","Diese ganze Inselgruppe wird Gobiath genannt. Nette Gegend, das Wetter wird nicht zu rauh oder zu heiß, ich mag es.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Gg]reenbriar","Greenbriar ist eine Halblingsstadt.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Hh]afen","Troll's Bane und Vanima haben Häfen. Der Hafen südwestlich von Troll's Bane ist aber größer.");
    autonpcfunctions.AddTraderTrigger("[Hh]ellbriar","Das war ein von einem barbarischen Kult besetzter Dungeon nahe bei Greenbriar. Die bösartigen Kultisten dort haben die meisten der Halblinge geopfert.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Mm]agierakademie","Ihr wollt nicht wirklich DA hin ! Es wird gesagt, den Ort kann nur ein Magier erreichen. Die verwandeln dort Leute in Schweine, Kühe oder schlimmeres !");
    autonpcfunctions.AddTraderTrigger("[Nn]ordmark","Es ist da nicht kälter als anderswo auf Gobiath, abgesehen vom Nordwind im Winter. Dort haben sich einige Norodaj-Barbaren angesiedelt.");
    autonpcfunctions.AddTraderTrigger("[Ss]ilberbrand","Silberbrand ist eine Zwergenstadt, in den bergen nordöstlich von Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("[Vv]anima","Tol Vanima ? Das ist eine ganze kleine Insel voller Bäume und Elfen.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Tt]roll['s] bane","Tja, das ist die grösste Stadt auf Gobiath.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Vv]arshikar","Das findet man weit im Nordwesten hinter der kleinen Sandwüste. Ich würde den Teleporter benutzen, die Wüste ist voller Skorpione.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Ww]ho [a']+re you","I am "..thisNPC.name..". What's your name ?");
    autonpcfunctions.AddTraderTrigger("[wW]ho might you be","I'm called "..thisNPC.name..". And what might your name be ?");
    autonpcfunctions.AddTraderTrigger("[Yy]our name","My name is "..thisNPC.name..". What is your name ?");
    autonpcfunctions.AddTraderTrigger("[Yy]ou are","I am "..thisNPC.name..". What's your name ?");
    autonpcfunctions.AddTraderTrigger("[Ii][ a']+m new","Nice to meet you, then. I am "..thisNPC.name..", what is your name ?");
    autonpcfunctions.AddTraderTrigger("[Hh]ow are you","Oh, i am fine, thanks.");
    autonpcfunctions.AddTraderTrigger("[Yy]our job","I don't want to talk about that right now.");
    autonpcfunctions.AddTraderTrigger("[Yy]our profession","I don't want to talk about that right now.");
    autonpcfunctions.AddTraderTrigger("[Yy]our mission","I'm looking for someone who can bring me some things. Would you like to help me?");
    autonpcfunctions.AddTraderTrigger("[Yy]our mission","I'm looking for someone who can bring me some things. Would you like to help me?");
    autonpcfunctions.AddTraderTrigger("[Yy]our mission","I'm looking for someone who can bring me some things. Would you like to help me?");
    autonpcfunctions.AddTraderTrigger("[Yy]our task","I'm looking for someone who can bring me some things. Would you like to help me?");
    autonpcfunctions.AddTraderTrigger("[wW]hat do you","I'm looking for someone who can bring me some things. Would you like to help me?");
    autonpcfunctions.AddTraderTrigger("[Bb]uy","I don't sell anything. Do i look like a merchant ?");
    autonpcfunctions.AddTraderTrigger("[Ss]ell","Thanks, but i already have everything i need.");
    autonpcfunctions.AddTraderTrigger("[Ww]hat buy","Thanks, but i already have everything i need.");
    autonpcfunctions.AddTraderTrigger("[Ww]hat sell","I don't sell anything. Do i look like a merchant ?");
    autonpcfunctions.AddTraderTrigger("[Gg]obaith","This whole island group is called Gobiath. Nice place, the weather usually does not get too rough or too hot, i like it.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("[Gg]reenbriar","Greenbriar is the city of the halflings.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("[Hh]arbo[u]+r","Troll's Bane and Vanima both have Harbors. The one southwest from Troll's Bane is bigger though.");
    autonpcfunctions.AddTraderTrigger("[Hh]ellbriar","That was an evil dungeon near Greenbriar ! The evil Cultists there sacrificed most of the Halflings of Greenbriar.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("[Mm]agic academy","You don't want to go THERE ! It can only be reached by a mage, they say. They turn people into pigs or cows or worse things there!");
    autonpcfunctions.AddTraderTrigger("[Nn]orthmark","it's not cooler there than elsewhere on Gobiath, except for the north wind in winter. Some Norodaj-Barbarians have settled there.");
    autonpcfunctions.AddTraderTrigger("[Ss]ilverbrand","Silverbrand is a dwarven town in the mountains northeast from Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("[Vv]anima","Tol Vanima ? That's a whole small island full of trees and elves.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("[Tt]roll['s] bane","Well, that's the biggest town on Gobiath.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("[Vv]arshikar","You find it past the small sand desert in the far northwest. I would use the Teleporter, the desrt is full of scorpions.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("[aA]uf bald","Man sieht sich, aber hoffentlich nicht in nächster Zeit.");
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("[Hh]allo","Grüß dich, was willst du?");
    autonpcfunctions.AddAdditionalTrigger("[Gg]rü[ßs]+e");
    autonpcfunctions.AddAdditionalTrigger("[Ss]eid gegrüßt");
    autonpcfunctions.AddCondition("qpg","<",2);
	autonpcfunctions.AddConsequence("talk","begin");
    autonpcfunctions.AddTraderTrigger("[Hh]ello","Greetings, what do you want?");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reeting[s]");
    autonpcfunctions.AddAdditionalTrigger("[Bb]e greeted");
    autonpcfunctions.AddCondition("qpg","<",2);
	autonpcfunctions.AddConsequence("talk","begin");
    autonpcfunctions.AddTraderTrigger("[Hh]elfen","Aye, ich könnt deine Hilfe gebrauchen, kannst du mir erstma' ne Pfeife bringen und danach etwa 10 Sibanacblätter?");
    autonpcfunctions.AddAdditionalTrigger("[Mm]achen");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",2);
--
    autonpcfunctions.AddTraderTrigger("[Pp]feife","Eine Pfeife kannst du dir sicher von einem Schreiner machen lassen, oder frag einen der Händler hier in der Stadt vielleicht verkauft dir einer von denen die Pfeife.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("[Pp]ipe","A pipe? A carpenter can make you surely one or even ask a merchant here in town. Maybe he would sell you one.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("[Ss]ibanac","Sibanacblätter findet man in der nähe von Flüssen hinter Schilf und falls du da kein Glück hast schau dich mal in den Wäldern um, da findet man ab und zu auch Sibanac.");
    autonpcfunctions.AddAdditionalTrigger("[Bb]lätter");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Ss]ibanac","You can find Sibanac leaves not far away from rivers behind reed and if you can't find it there you could search for at the forest. From time to time you can find Sibanac there.");
    autonpcfunctions.AddAdditionalTrigger("[Ll]eaves");
    autonpcfunctions.AddCondition("qpg","=",2);
	autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("[Hh]elfen","Aye, ich könnt deine Hilfe gebrauchen, kannst du mir erstma' ne Pfeife bringen und danach etwa 10 Sibanacblätter?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("[Hh]elping","Aye, I could need your help. Maybe you can bring me a pipe and after this about 10 Sibanac leaves?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("[Jj]a","Dann geh mal los und bring mir ne Pfeife und die 10 Sibanacblätter! Dann bring ich dir auch was bei.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Well, then go and bring me a pipe and 10 sibanac leaves! Maybe then I might teach you something.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("[Nn]ein","Dann verschwinde....oder komm wieder wenn du mir doch helfen willst!");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("[Nn]o","Come again, if you want to help me!");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",0);
	autonpcfunctions.AddTraderTrigger("[Hh]allo"," Hast du endlich die Pfeife und die 10 Sibanacblätter dabei?");
    autonpcfunctions.AddAdditionalTrigger("[Gg]r[üs][sß]e");
    autonpcfunctions.AddAdditionalTrigger("[Ss]eid gegrüßt");
    autonpcfunctions.AddAdditionalTrigger("[hH][ei]lf");
	autonpcfunctions.AddAdditionalTrigger("[Mm]achen");
	autonpcfunctions.AddCondition("qpg","=",3);
	autonpcfunctions.AddConsequence("talk","begin");
	autonpcfunctions.AddTraderTrigger("[Hh]ello"," Do you have the pipe and the 10 sibanac leaves with you?");
	autonpcfunctions.AddAdditionalTrigger("[Gg]reeting[s]");
    autonpcfunctions.AddAdditionalTrigger("[Bb]e greeted");
    autonpcfunctions.AddAdditionalTrigger("[Hh]elp");
	autonpcfunctions.AddAdditionalTrigger("[Mm]ake");
	autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("talk","begin");
	
	autonpcfunctions.AddTraderTrigger("[Pp]feife","Dank dir und jetzt bring mir noch die 10 Sibanacblätter!");
    autonpcfunctions.AddCondition("item",2744,"all",">=",1);
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddConsequence("deleteitem",2744,1);
    autonpcfunctions.AddTraderTrigger("[Pp]ipe","Thank you. Now bring me the 10 Sibanac leaves!");
    autonpcfunctions.AddCondition("item",2744,"all",">=",1);
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddConsequence("deleteitem",2744,1);
    autonpcfunctions.AddTraderTrigger("[Ss]ibanac","Arr...das hast du gut gemacht. Aber mir fällt noch ein, dass ich kein Essen mehr hab. Kannst mir noch 20 geräucherten Schinken bringen?");
    autonpcfunctions.AddCondition("item",155,"all",">=",10);
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("qpg","=",5);
    autonpcfunctions.AddConsequence("deleteitem",155,10);
    autonpcfunctions.AddTraderTrigger("[Ss]ibanac","Arr...well done! But there I remember, I got nothing to eat! Maybe you can bring me 20 ham?");
    autonpcfunctions.AddCondition("item",155,"all",">=",10);
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("qpg","=",5);
    autonpcfunctions.AddConsequence("deleteitem",155,10);    
	
	autonpcfunctions.AddTraderTrigger("[Ss]chinken","Gut, gut dann pass mal gut auf was ich dir jetzt zeige. Sag 'Los' wenn ich beginnen soll.");
    autonpcfunctions.AddCondition("item",306,"all",">=",20);
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",7);
    autonpcfunctions.AddConsequence("deleteitem",306,20);
	autonpcfunctions.AddTraderTrigger("[Ss]chinken","Den Schinken kannst du in Trollsbane bei den Schweinen holen und dann musst du zum Räucheroffen gehn und den rohen Schinken räuchern. Und dann kommst du zu mir und gibst es mir!");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddTraderTrigger("[Hh]am","Well, pay attention to what I say you now! If you are ready, say ready.");
    autonpcfunctions.AddCondition("item",306,"all",">=",20);
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",7);
    autonpcfunctions.AddConsequence("deleteitem",306,20);
	autonpcfunctions.AddTraderTrigger("[Hh]am","You can pick up meat by the pigs in Trollsbane and after this, you have to go to the fumigation house for curing the meat. If you've done this, come to me and give it me!");
    autonpcfunctions.AddCondition("qpg","=",5);
	
    autonpcfunctions.AddTraderTrigger("[Ss]ibanac","Ey..was soll ich damit? Bring mir erstmal die Pfeife und dann erst die 10 Sibanacblätter!");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Ss]ibanac","Ey, what I should do with this? First bring me the pipe and after this the 10 Sibanac leaves!");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddCondition("lang","english");	
    autonpcfunctions.AddTraderTrigger("[Pp]feife","Sach mal bist du taub oder dämlich? Du hast die Pfeife gar nicht dabei, bring sie mir wenn ich dir was beibringen soll!");
    autonpcfunctions.AddCondition("item",2744,"all","<",1);
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("[Pp]ipe","Say, are you deaf or daffy? You haven't got the pipe in you inventory, bring it me, if you want to learn something!");
    autonpcfunctions.AddCondition("item",2744,"all","<",1);
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("[Ss]ibanac","Bring mir die 10 Sibanacblätter wenn du was von mir lernen willst.");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddCondition("item",155,"all","<",10);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("[Ss]ibanac","Bring me 10 Sibanac leaves, if you want to learn someting!");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddCondition("item",155,"all","<",10);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("[Jj]a","Spitze! Ich wart hier auf dich und wärm mich schon mal auf, für dein Training.");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Good! I'll wait on you and I will warm me up for your training!");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("[Nn]ein","Wenn du mir kein Essen bringen willst Freundchen, bring ich dir auch nix bei, so einfach is das! Wenn du es dir anders überlegst, dann sprich mich einfach wieder an.");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",100);
    autonpcfunctions.AddTraderTrigger("[Nn]o","If you don't want to bring me something to eat, I won't teach you something! If you've decided you in another way, come and talk to me again!");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",100);
    autonpcfunctions.AddTraderTrigger("[Hh]allo","Arr..da bist du ja wieder, bringst mir jetzt die 20 geräucherten Schinken oder nicht?");
    autonpcfunctions.AddAdditionalTrigger("[Gg]r[üs][sß]e");
    autonpcfunctions.AddAdditionalTrigger("[Ss]eid gegrüßt");
    autonpcfunctions.AddAdditionalTrigger("[Ss]chinken");
    autonpcfunctions.AddAdditionalTrigger("[hH][ei]lf");
    autonpcfunctions.AddCondition("qpg","=",100);
    autonpcfunctions.AddConsequence("qpg","=",5);
	autonpcfunctions.AddConsequence("talk","begin");
    autonpcfunctions.AddTraderTrigger("[Hh]ello","Arr, there you are again! You're bringing me the 20 ham now or not?");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reeting[s]");
    autonpcfunctions.AddAdditionalTrigger("[Bb]e greeted");
    autonpcfunctions.AddAdditionalTrigger("[Hh]am");
    autonpcfunctions.AddAdditionalTrigger("[Hh]elping");
    autonpcfunctions.AddCondition("qpg","=",100);
    autonpcfunctions.AddConsequence("qpg","=",5);
	autonpcfunctions.AddConsequence("talk","begin");
	
	autonpcfunctions.AddTraderTrigger("[Hh]allo","Arr..da bist du ja wieder, bringst mir jetzt die 20 geräucherten Schinken oder nicht?");
    autonpcfunctions.AddAdditionalTrigger("[Gg]r[üs][sß]e");
    autonpcfunctions.AddAdditionalTrigger("[Ss]eid gegrüßt");
    autonpcfunctions.AddAdditionalTrigger("[Ss]chinken");
    autonpcfunctions.AddAdditionalTrigger("[hH][ei]lf");
    autonpcfunctions.AddCondition("qpg","=",5);
	autonpcfunctions.AddConsequence("talk","begin");
	
	autonpcfunctions.AddTraderTrigger("[Hh]ello","Arr, there you are again! You're bringing me the 20 ham now or not?");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reet");
    autonpcfunctions.AddAdditionalTrigger("[Bb]e greeted");
    autonpcfunctions.AddAdditionalTrigger("[Hh]am");
    autonpcfunctions.AddAdditionalTrigger("[Hh]elping");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("talk","begin");
	
	autonpcfunctions.AddTraderTrigger("[Hh]allo","Arr..da bist du ja wieder, hast du nun die 20 geräucherten Schinken dabei? Wenn nicht dann verschwinde!");
    autonpcfunctions.AddAdditionalTrigger("[Gg]r[üs][sß]e");
    autonpcfunctions.AddAdditionalTrigger("[Ss]eid gegrüßt");
    autonpcfunctions.AddAdditionalTrigger("[Ss]chinken");
    autonpcfunctions.AddAdditionalTrigger("[hH][ei]lf");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("talk","begin");
    autonpcfunctions.AddTraderTrigger("[Hh]ello","Arr, there you are again! Do you have the 20 ham with you? If not then leave!");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reeting[s]");
    autonpcfunctions.AddAdditionalTrigger("[Bb]e greeted");
    autonpcfunctions.AddAdditionalTrigger("[Hh]am");
    autonpcfunctions.AddAdditionalTrigger("[Hh]elp");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("talk","begin");
--
    autonpcfunctions.AddTraderTrigger("[Ll]os","#me zeigt dir ein taktisches Kampfmanöver.");
    autonpcfunctions.AddCondition("qpg","=",7);
	autonpcfunctions.AddCondition("skill","tactics","=<",60);
    autonpcfunctions.AddConsequence("skill","fighting","tactics","+",5);
    autonpcfunctions.AddConsequence("qpg","=",8);
	autonpcfunctions.AddTraderTrigger("[Ll]os","#me zeigt dir ein taktisches Kampfmanöver.");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddCondition("skill","tactics",">",60);
    autonpcfunctions.AddConsequence("skill","fighting","tactics","+",1);
    autonpcfunctions.AddConsequence("qpg","=",8);	
    autonpcfunctions.AddTraderTrigger("[Rr]eady","#me shows you some tactical maneuvers.");
    autonpcfunctions.AddCondition("qpg","=",7);
	autonpcfunctions.AddCondition("skill","tactics","=<",60);
    autonpcfunctions.AddConsequence("skill","fighting","tactics","+",5);
    autonpcfunctions.AddConsequence("qpg","=",8);
	autonpcfunctions.AddTraderTrigger("[Rr]eady","#me shows you some tactical maneuvers.");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddCondition("skill","tactics",">",60);
    autonpcfunctions.AddConsequence("skill","fighting","tactics","+",1);
    autonpcfunctions.AddConsequence("qpg","=",8);
	
    autonpcfunctions.AddTraderTrigger("","Lass mich in Ruhe, ich hab dir schon etwas beigebracht.");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("","Don't bother me, I've taught you anything yet!");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddCondition("lang","english");
	autonpcfunctions.AddTraderTrigger("[Hh]elp","I'm looking for someone who can bring me some things. Would you like to help me?");
    autonpcfunctions.AddCondition("qpg","<",2);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("[Hh]ilfe","Ich suche nach jemanden der mir was besorgt! Willst mir helfen?");
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddCondition("qpg","<",2);
	
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
