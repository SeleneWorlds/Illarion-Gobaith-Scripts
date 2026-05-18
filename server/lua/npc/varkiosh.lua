local M = {}

-- In work! by avalyon
-- Varkiosh the Forsaken.

-- INSERT INTO npc VALUES (nextval('npc_seq'),Demon,-6,-6,0,2,false,'Varkiosh the Forsaken','npc_varkiosh_the_forsaken.lua',2);

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

    QuestID = 1001;
    autonpcfunctions.AddTraderTrigger("[Hh]ello","Ahh, fresh meat.. Know, motal, that you are now in the presence of great Varkiosh, the Forsaken. I should destroy you for your tressapassing, but since you are here, we should make it proffitable for us both. Accept to offer me some of your blood to nourish my rotten flesh and I shall tell you a great story.");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reetings");
    autonpcfunctions.AddAdditionalTrigger("[Hh]i");
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("[Aa]lright","#me suddenly hits the %CHARRACE with his sharp boney claws, licking them of blood afterwards 'Yeees, your blood rejuvenates me.. Thank you mortal, are you ready for my part of the deal?'");
    autonpcfunctions.AddAdditionalTrigger("[Oo]k");
    autonpcfunctions.AddAdditionalTrigger("[Yy]es");
    autonpcfunctions.AddAdditionalTrigger("[Aa]greed");
    autonpcfunctions.AddAdditionalTrigger("[Aa]gree");
    autonpcfunctions.AddAdditionalTrigger("[Bb]lood");
    autonpcfunctions.AddCondition("qpg","=",1);
    -- npc.base.autonpcfunctions.AddConsequence("attrib",attrib(hitpoints)-3000); -- attrib(int) does not exist
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("[Yy]es","There was once a great mage, a mage so great that all of his enemies shivered in fear only at the sound of his unholy name. Everyone feared him, everyone hated him, all wanted to see him defeated, but no power, nor man, nor creature, could face him in battle and survive. Can you comprehand this concept, mortal?");
    autonpcfunctions.AddAdditionalTrigger("[Oo]k");
    autonpcfunctions.AddAdditionalTrigger("[Aa]lright");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Find, mortal, that this great mage, loyal servant of the dark gods, was tricked and ambushed by no less than 50 mages. The battle lasted more than 7 days, at the end, the mage stepping on the burning ashes of his carbonised enemies. Shall I continue?");
    autonpcfunctions.AddAdditionalTrigger("[Ii]ndeed");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddConsequence("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("[Nn]o","Then get out of my sight!");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddTraderTrigger("[Yy]es","The mage destroyed all of his enemies, but he himself, received a serious, magic wound, that he could not manage to heal. Gattering his left strenght, he warped himself to the temple of his worshipped gods, praying to them for healing. But no.. the gods considered him unworthy for allowing himself to receive the hit and insted of healing, he received a gruesome curse... Do you know who that mage was, mostal?");
    autonpcfunctions.AddAdditionalTrigger("[Pp]lease");
    autonpcfunctions.AddCondition("qpg","=",4);
    autonpcfunctions.AddConsequence("qpg","=",5);
    autonpcfunctions.AddTraderTrigger("[Yy]ou","Indeed mortal, my soul has been cursed to inhabit this decaying body for all eternity, being binded to guard this infernal temple, where, a long time ago, I have kneeled to the gods asking them for healing. I will never leave this place, mortal, for that my curse if given by the gods and it is eternal. Do a few tasks for me, frail one, and you shall have my gratitude. Do you accept?");
    autonpcfunctions.AddCondition("qpg","=",5);
    autonpcfunctions.AddConsequence("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("[Nn]o","Then get out of my sight!");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Very well, mortal one, then this it shall be. I may be a lich now, but I am still a powerful mage.. they robbed me of my life, but my powers they did not take, and my supply of mana potions has long expired. Bring me 20 bottles and we shall discuss further");
    autonpcfunctions.AddAdditionalTrigger("[Aa]lright");
    autonpcfunctions.AddAdditionalTrigger("[Oo]k");
    autonpcfunctions.AddAdditionalTrigger("[Aa]gree");
    autonpcfunctions.AddCondition("qpg","=",6);
    autonpcfunctions.AddConsequence("qpg","=",7);
    autonpcfunctions.AddTraderTrigger("[Hh]ello","Do you have what I required of you? If not, you should better not waste my time anymore..");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reetings");
    autonpcfunctions.AddAdditionalTrigger("[Hh]i");
    autonpcfunctions.AddCondition("qpg","=",7);
    autonpcfunctions.AddConsequence("qpg","=",8);
    autonpcfunctions.AddTraderTrigger("[Nn]o","Why are you wasting my time then? I am eternally busy");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddConsequence("qpg","=",7);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Idiotic piece of flesh, bring them first!");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddCondition("item",165,"belt","<",20);
    autonpcfunctions.AddConsequence("qpg","=",7);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Ah, excellent my dark friend, excellent indeed. Let us continue, shall we? I require to use the dark energies for a ritual, but I have no items to draw them from. Be so kind and bring me arround 100 entrails and we shall see what will follow.");
    autonpcfunctions.AddCondition("qpg","=",8);
    autonpcfunctions.AddCondition("item",165,"belt",">",19);
    autonpcfunctions.AddConsequence("deleteitem",165,20);
    autonpcfunctions.AddConsequence("qpg","=",9);
    autonpcfunctions.AddTraderTrigger("[Hh]ello","Do you have what I required of you? If not, you should better not waste my time anymore..");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reetings");
    autonpcfunctions.AddAdditionalTrigger("[Hh]i");
    autonpcfunctions.AddCondition("qpg","=",9);
    autonpcfunctions.AddConsequence("qpg","=",10);
    autonpcfunctions.AddTraderTrigger("[Nn]o","Why are you wasting my time then? I am eternally busy");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddConsequence("qpg","=",9);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Idiotic piece of flesh, bring them first!");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("item",63,"belt","<",100);
    autonpcfunctions.AddConsequence("qpg","=",9);
    autonpcfunctions.AddTraderTrigger("yes","Your worth never stops to amaze me, living one.. Good good, give them to me and be on your way to bring me 10 bottles of the finest poison, the one that only spiders can breed");
    autonpcfunctions.AddCondition("qpg","=",10);
    autonpcfunctions.AddCondition("item",63,"belt",">",99);
    autonpcfunctions.AddConsequence("deleteitem",63,100);
    autonpcfunctions.AddConsequence("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("[Hh]ello","Do you have what I required of you? If not, you should better not waste my time anymore..");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reetings");
    autonpcfunctions.AddAdditionalTrigger("[Hh]i");
    autonpcfunctions.AddCondition("qpg","=",11);
    autonpcfunctions.AddConsequence("qpg","=",12);
    autonpcfunctions.AddTraderTrigger("[Nn]o","Why are you wasting my time then? I am eternally busy");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddConsequence("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Idiotic piece of flesh, bring them first!");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("item",167,"belt","<",10);
    autonpcfunctions.AddConsequence("qpg","=",11);
    autonpcfunctions.AddTraderTrigger("yes","Oh excellent work, dark one, excellent work indeed. Are you ready? I shall now give you a special power to help you in your next task.");
    autonpcfunctions.AddCondition("qpg","=",12);
    autonpcfunctions.AddCondition("item",167,"belt",">",9);
    autonpcfunctions.AddConsequence("deleteitem",167,10);
    autonpcfunctions.AddConsequence("qpg","=",13);
    autonpcfunctions.AddTraderTrigger("yes"," #me waves his skeletral hand in from of the %CHARRACE 's face, humming darkly 'Yes my dark friend, yes.. feel the power? Yes.. Now tell me, are you ready for the last task?' ");
    autonpcfunctions.AddCondition("qpg","=",13);
    autonpcfunctions.AddConsequence("qpg","=",14);
    autonpcfunctions.AddTraderTrigger("yes","During my... lifetime... a grand order of paladins was watching my every move, trying at every step to end my dark existance. Their leader, Antonius Cornelius, hunted me his entire life, since his childhood, when I slayed his troublemaking parents. When I received the curse, he swore that one day he will destroy me, even if he'd have to wait an eternity for it. As no servant of the light would ever dare to step in this doomed place, he prayed and prayed to his weak gods, asking them for mercy. The gods showed pitty to their loyal servant, blessing him with neverending life and ethernal yought. Thus, even today, Antonius resides somewhere in the dungeoun below, waiting for a chance to slay me, until the end of time. Find him, %CHARNAME, and end his pittyful existance. Bring me his holy sword as proof of his demise.");
    autonpcfunctions.AddCondition("qpg","=",14);
    autonpcfunctions.AddConsequence("qpg","=",15);
    autonpcfunctions.AddTraderTrigger("[Hh]ello","Have you slayed the paladin, %CHARNAME and brought me his sword? If not, you should better not waste my time anymore..");
    autonpcfunctions.AddAdditionalTrigger("[Gg]reetings");
    autonpcfunctions.AddAdditionalTrigger("[Hh]i");
    autonpcfunctions.AddCondition("qpg","=",15);
    autonpcfunctions.AddConsequence("qpg","=",16);
    autonpcfunctions.AddTraderTrigger("[Nn]o","Why are you wasting my time then? I am eternally busy");
    autonpcfunctions.AddCondition("qpg","=",16);
    autonpcfunctions.AddConsequence("qpg","=",15);
    autonpcfunctions.AddTraderTrigger("[Yy]es","Idiotic piece of flesh, do what I asked!");
    autonpcfunctions.AddCondition("qpg","=",16);
    autonpcfunctions.AddCondition("item",206,"belt","<",1);
    autonpcfunctions.AddConsequence("qpg","=",15);
    autonpcfunctions.AddTraderTrigger("yes","Well done %CHARNAME, well done! I must say that I wasn't expecting you to return. Your dark heart allowed you to slay the poor paladin, you are truely worthy of baring darkness in your soul. Receive this gift, dark one, receive it and bare it well.");
    autonpcfunctions.AddCondition("qpg","=",16);
    autonpcfunctions.AddCondition("item",206,"belt","=",1);
    autonpcfunctions.AddConsequence("qpg","=",17);
    autonpcfunctions.AddConsequence("deleteitem",206,1);
    autonpcfunctions.AddConsequence("item",278,1,1001,0000);
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
