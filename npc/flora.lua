local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-115, -84, 0,2,false,'Flora','npc_flora.lua',1);
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
-- Queststats:
-- 1 - Does Player like flowers?
-- 2 - Player likes flower. Can he be asked a question?
-- 3 - Did Player ever see Night Angels Blossom?
-- 4 - Player asked to bring a Night Angels Blossom.
-- 5 - Player never seen a Night Angels Blossom
-- 6 - Player agrees to bring the flower
-- 7 - Player disagrees to bring the flower
-- 8 - Player brought the flower
-- 10 - Quest completed (NPC will offer healing capabilities)

    QuestID = 558

-- CYCLE TEXT
    autonpcfunctions.AddCycleText("","#me crouches down and looks closely at the flowers, frowning slightly.");
    autonpcfunctions.AddCycleText("","#me sniffs a flower she's holding.");
    autonpcfunctions.AddCycleText("","#me whispers something inaudible while plucking out the petals of a flower.");

-- Queststatus = 10 (COMPLETED) - Person named
    autonpcfunctions.AddTraderTrigger("hello","Hello again, sir %CHARNAME, it is always nice seeing you.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","Ah, sir %CHARNAME, a pleasure seeing you again.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("hello","Hello again, sir %CHARNAME, it is always nice seeing you.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","Ah, sir %CHARNAME, a pleasure seeing you again.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("hello","Hello %CHARNAME, it is always nice seeing you.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","%CHARNAME, a pleasure seeing you again.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("hello","Hello %CHARNAME, it is always nice seeing you.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","%CHARNAME, a pleasure seeing you again.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("sex","male");

-- Queststatus = 10 (COMPLETED)
    autonpcfunctions.AddTraderTrigger("hello","Hello again. Oh, you seem to be wounded. Would you allow me to tend to your wounds?");
    autonpcfunctions.AddCondition("attrib","hitpoints","<",1500);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddConsequence("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("greet","Greetings again. Hmm, you seem to be hurt. May I tend to your wounds?");
    autonpcfunctions.AddCondition("attrib","hitpoints","<",1500);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddConsequence("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("hello","Hello again there! It is so nice to see you.");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("greet","Greetings once again. It is always nice seeing you.");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("farewell","Farewell and come back soon to see me!");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("yes","#me uses a small bottle of liquid which helps cure the wounds, 'There you go. You should feel better.'");
    autonpcfunctions.AddCondition("attrib","hitpoints","<",1500);
    autonpcfunctions.AddConsequence("attrib","hitpoints","+",5000);
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("sure","#me applies a small bottle of liquid, soothing the pain of the wounds, 'There. You should feel less pain now.'");
    autonpcfunctions.AddCondition("attrib","hitpoints","<",1500);
    autonpcfunctions.AddConsequence("attrib","hitpoints","+",5000);
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("yes","Oh well, you aren't that bad. I'll heal you when you are in a worse condition.");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("no","If you insist. Take care then.");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("thank","I am glad to be of help, just as you were to me.");
    autonpcfunctions.AddCondition("state","=",6);
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("why","My mother used to tell me stories about this wonderful flower. But now she passed out, and I have no memories of her. The flower can serve as one.");
    autonpcfunctions.AddCondition("qpg",">=",2);

-- Queststatus = 1
    autonpcfunctions.AddTraderTrigger("I like flowers","You like the flowers? That makes me happy! May I ask you a question?");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("I love flowers","You love the flowers? Wow, I love them too! Can I ask you a question?");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("yes","Oh you like them too? That is so nice to hear. May I ask you a question?");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("no","Oh, pity. You should look at them closely, their colors, their scent, it's a unique sensation.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddConsequence("qpg","=",0);

-- Queststatus = 2
    autonpcfunctions.AddTraderTrigger("ask","Did you ever see a Night Angels Blossom?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("yes","Have you ever seen a Night Angels Blossom?");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("of course","#me smiles before she inquires, 'Have you ever seen the lovely Night Angels Blossom?'");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("sure","#me smiles before she inquires, 'Have you ever seen the lovely Night Angels Blossom?'");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("no","Sorry then, I won't disturb you.");
    autonpcfunctions.AddCondition("qpg","=",2);

-- Queststatus = 3
    autonpcfunctions.AddTraderTrigger("many times","Oh that is so nice to hear. Do you think you'll be able to bring me one?");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("yes","Really? You have seen it? Would you be kind enough if you brought me one?");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("once","You've seen it once? A rare flower, isn't it? Do you think you'll be able to bring me one?");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("of course","That's lovely. Would you be able to bring me one please?");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("no","Oh, what a pity. You see, my biggest wish is to see and experience the scent of that flower.");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",5);
    autonpcfunctions.AddTraderTrigger("never","#me frowns then, before she says, 'A pity. You know, my biggest wish is to see the Night Angels Blossom.'");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",5);
    autonpcfunctions.AddTraderTrigger("saw","That is very nice but...I would really wish to see one. Can you bring me one, please?");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("seen","Really? You've seen it? Could you bring me one, please?");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);

-- Queststatus = 4
    autonpcfunctions.AddTraderTrigger("yes","#me smiles widely suddenly before she says, 'You are too kind. I will eagerly wait to see it.'");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("sure","You are too kind. I will wait for you to bring it.");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("of course","I am so glad you will. Thank you. I will wait patiently.");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("will try","Oh please do try. I will be so grateful if you did.");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("no","#me frowns and lowers her head before she says, 'Oh, I understand. I would have loved to see it.'");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",7);
    autonpcfunctions.AddTraderTrigger("I have flower","What? You have the Night Angels Blossom?");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I got flower","What? You have the Night Angels Blossom?");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I have it","You mean, the Night Angels Blossom? You have it?");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I got it","You mean, the Night Angels Blossom? You have it?");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I have night angels blossom","What? You have the flower with you?");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I got night angels blossom","What? You have got the flower with you?");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",8);

-- Queststatus = 5
    autonpcfunctions.AddTraderTrigger("seen","What? Have I understood well? You've seen the Night Angels Blossom?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("saw","Have I heard well? Did you see the Night Angels Blossom?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("I have flower","What? You have the Night Angels Blossom? Can you give it to me?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I got flower","What? You have the Night Angels Blossom? Can you give it to me?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I have it","You mean, the Night Angels Blossom? You have it? May I take it?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I got it","You mean, the Night Angels Blossom? You have it? May I take it?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I have night angel blossom","Oh you have it?");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I brought night angel blossom","You brought the flower? May I look at it?");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);

-- Queststatus = 6
    autonpcfunctions.AddTraderTrigger("hello","Hello again! Have you brought the Night Angels Blossom?");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("greet","Ah it's you! The flower? Have you brought it?");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I have flower","What? You have the Night Angels Blossom? Can you give it to me please?");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I got flower","What? You have the Night Angels Blossom? Can you give it to me please?");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I brought flower","You brought the flower? Really? Can I take it please?");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I have night angel blossom","You have the flower with you? Can I see it?");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I brought night angel blossom","You brought the flower? May I look at it?");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);

-- Queststatus = 7
    autonpcfunctions.AddTraderTrigger("hello","#me speaks with a gloomy, unenthusiastic voice, 'Hello.'");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddTraderTrigger("greet","#me shows a lack of enthusiasm as she speaks, 'Greetings.'");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddTraderTrigger("I have flower","#me blinks and lifts her eyebrows, 'What? You have the flower? Can I see it?'");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I got flower","#me blinks and lifts her eyebrows, 'What? You have the flower? Can I see it?'");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I brought flower","#me blinks and raises her eyebrows, 'You brought the flower? Really? Can I see it?");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I have night angel blossom","Hm? You've brought the flower? Really? May I see it?");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("I brought night angel blossom","What? You brought the flower? Can I see it?");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);

-- Queststatus = 8
    autonpcfunctions.AddTraderTrigger("yes","Wow. This is the magnificent Night Angels Blossom. It will remind me of my passed away mother. Here, take these bottles for your troubles. Thank you.");
    autonpcfunctions.AddConsequence("deleteitem",138,1);
    autonpcfunctions.AddConsequence("item",1316,2,333,0);
    autonpcfunctions.AddCondition("item",138,"all",">=",1);
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("sure","Wow. This is the magnificent Night Angels Blossom. It will remind me of my passed away mother. Here, take these bottles for your troubles. Thank you.");
    autonpcfunctions.AddConsequence("deleteitem",138,1);
    autonpcfunctions.AddConsequence("item",1316,2,333,0);
    autonpcfunctions.AddCondition("item",138,"all",">=",1);
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("of course","Wow. This is the magnificent Night Angels Blossom. It will remind me of my passed away mother. Here, take these bottles for your troubles. Thank you.");
    autonpcfunctions.AddConsequence("deleteitem",138,1);
    autonpcfunctions.AddConsequence("item",1316,2,333,0);
    autonpcfunctions.AddCondition("item",138,"all",">=",1);
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("yes","So? Where is it? Don't lie to me!");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("sure","You don't have it! Do not lie!");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("of course","Lies! You have none.");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("no","A pity. I will continue to wait.");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddConsequence("qpg","=",6);

-- NPC DESCRIPTION
    autonpcfunctions.AddTraderTrigger("#me examine","#me looks in her mid 20s, with dark orange hair reaching just below her shoulders, brown eyes and freckles on her cheek.");
    autonpcfunctions.AddTraderTrigger("#me examine clothes","#me is wearing a simple white dress, decorated with small pink circles.");

-- SHOUT
    autonpcfunctions.AddTraderTrigger("#s","Ooww! Would you mind not shouting so loud?");

-- GREETINGS/GOODBYES - known person
    autonpcfunctions.AddTraderTrigger("hello","Hello again, Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("hello","Hello again, Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("greet","Greetings Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","Greetings Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell to you and take care. Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell to you and stay safe. Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("see you","Be well, Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("see you","See you another time, Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night and sleep well, Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("hello","Hello again, Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("hello","Hello again, Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("greet","Greetings Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","Greetings Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell to you and take care. Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell to you and stay safe. Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("see you","Be well, Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("see you","See you another time, Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night and sleep well, Sir %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, Lady %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("hello","Hello again, %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger("greet","Greetings %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger("see you","Be well %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, %CHARNAME");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger("how are you","I am fine, thank you.");
    autonpcfunctions.AddCondition("state","=",1);

-- GREETINGS/GOODBYES - known person (no sir)
    autonpcfunctions.AddTraderTrigger("hello","Hello %CHARNAME. Nice to see you again.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","Greetings %CHARNAME. It is always nice seeing you.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell %CHARNAME, and come talk to me again soon.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("see you","See you soon %CHARNAME");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, %CHARNAME");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("hello","Hello %CHARNAME. Nice to see you again.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","Greetings %CHARNAME. It is always nice seeing you.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell %CHARNAME, and come talk to me again soon.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("see you","See you soon %CHARNAME");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, %CHARNAME");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");

-- GREETINGS/GOODBYES - unknown person
    autonpcfunctions.AddTraderTrigger("greet","Greetings good sir.");
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","Greetings to you, ma'am.");
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, sir.");
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, madam.");
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("greet","Greetings good sir.");
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("greet","Greetings to you, ma'am.");
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, sir.");
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night, madam.");
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("hello","Hello to you.");
    autonpcfunctions.AddTraderTrigger("greet","Greetings to you.");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell to you and take care.");
    autonpcfunctions.AddTraderTrigger("bye","Goodbye and be well.");
    autonpcfunctions.AddTraderTrigger("see you","Goodbye.");
    autonpcfunctions.AddTraderTrigger("good day","And good day to you too.");
    autonpcfunctions.AddTraderTrigger("good night","Have a good night.");

-- INTRODUCTION PHRASES
    autonpcfunctions.AddTraderTrigger("my name is","It is a real pleasure to meet you, sir %CHARNAME");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("is my name","#me curtsies politely as she says, 'It is my pleasure, sir %CHARNAME.'");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("no sir","#me blushes a bit, then says, 'Excuse me. I'll just say %CHARNAME then.'");
    autonpcfunctions.AddCondition("state","<>",2);
    autonpcfunctions.AddConsequence("state",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("call sir","#me blushes a bit, then says, 'Apologies. I'll just say %CHARNAME then.'");
    autonpcfunctions.AddCondition("state","<>",2);
    autonpcfunctions.AddConsequence("state",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("my name is","It is a real pleasure to meet you, sir %CHARNAME");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("is my name","#me curtsies politely as she says, 'It is my pleasure, sir %CHARNAME.'");
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("no sir","#me blushes a bit, then says, 'Excuse me. I'll just say %CHARNAME then.'");
    autonpcfunctions.AddCondition("state","<>",2);
    autonpcfunctions.AddConsequence("state",2);
    autonpcfunctions.AddCondition("race",CCharacter.elf);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("call sir","#me blushes a bit, then says, 'I aplogize. I'll just say %CHARNAME then.'");
    autonpcfunctions.AddCondition("state","<>",2);
    autonpcfunctions.AddConsequence("state",2);
    autonpcfunctions.AddCondition("race",CCharacter.human);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("my name is","It is a pleasure to meet you, %CHARNAME");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddTraderTrigger("is my name","It is my pleasure to meet you, %CHARNAME'");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state",1);
    autonpcfunctions.AddTraderTrigger("who [a']+re you","I am %NPCNAME. What is your name?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger("who might you be","My name is %NPCNAME. And you might be?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger("your name","My name is %NPCNAME. What is your name?");
    autonpcfunctions.AddCondition("state","=",0);

-- HELP
    autonpcfunctions.AddTraderTrigger("help","[Game Help]: ((This is a NPC, you can talk to them just like other player characters. NPCs will react to keywords like 'Hello', so listen closely to what they say.))");
    autonpcfunctions.AddTraderTrigger("hilfe","[Game Help]: ((Das ist ein NPC, du kannst mit ihnen sprechen wie mit anderen Spielercharakteren. NPCs werden auf Schlüsselwörter wie 'Hallo' reagieren, also achte gut auf das was sie dir sagen.))");

-- GENERAL
    autonpcfunctions.AddTraderTrigger("I[ a']+m new","Nice to meet you, then. I am %NPCNAME, what is your name?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger("newbie","#w((A newbie? Welcome! I am an NPC. I cannot really help you, but other players can. Please remember to mark OOC talk in double brackets.))");
    autonpcfunctions.AddTraderTrigger("n[0O]b","#w((A newbie? Welcome! I am an NPC. I cannot really help you, but other players can. Please remember to mark OOC talk in double brackets.))");
    autonpcfunctions.AddTraderTrigger("how are you","I am doing well, thank you.");
    
-- JOB after quest completed
    autonpcfunctions.AddTraderTrigger("your job","I have basic abilities in druidry. If you are injured, please come to me.");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("what do you","I'm a competent druid. Should you be injured, come to me.");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("what you doing","Observing the beauty of the flowers.");
    autonpcfunctions.AddCondition("qpg","=",10);
    
-- JOB
    autonpcfunctions.AddTraderTrigger("your job","I...sometimes work as a druid. I study the plants, especially the flowers. Aren't they lovely?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("what do you","Sometimes I study the plants, or better the flowers. Don't you find them lovely?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("what you doing","I'm just observing the flowers. Aren't they pretty?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",1);
    
-- QUEST STARTERS
    autonpcfunctions.AddTraderTrigger("you like flowers","Yes, I love flowers. They are the passion of my life. Don't you like them too?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("i like flowers","You like flowers too? That is so lovely. May I ask you a question then?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("i love flowers","You love the flowers? Really? I love them too! Then may I ask you a question?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("flowers","What? You mentioned flowers? Do you like them?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddConsequence("qpg","=",1);
    
-- DEBUGGING
    autonpcfunctions.AddTraderTrigger("reset me","I will reset you");
    autonpcfunctions.AddConsequence("state",0);
    autonpcfunctions.AddConsequence("qpg","=",0);
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
            debugText="";
            if debugMode then
                if QuestID~=nil then
                    QeSt=originator:getQuestProgress( QuestID );
                    if QeSt~=nil then
                        debugText="QS="..QeSt;
                    else
                        debugText="QS=0";
                    end
                end
                St=NPCStatus[originator.id]
                if St~=nil then
                    debugText=debugText.." St="..St;
                else
                    debugText=debugText.." St=0";
                end
                thisNPC:talk(CCharacter.say,"Debug Info: "..debugText);
            end
            autonpcfunctions.TellSmallTalk(debugText..message,originator);
        else
            autonpcfunctions.Confused(
               "#me sieht dich leicht verwirrt an",
               "#me looks at you a little confused"
            );
        end
    end
end

return M
