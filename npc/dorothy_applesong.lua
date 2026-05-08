local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),2,-66,-100,0,2,false,'Dorothy Applesong','npc_dorothy_applesong.lua',1);

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

    QuestID = 22;
    -- the NPC lost a necklace while near greenbriar she wishes to ask a friend of hers whether the amulet was found...
    -- Before Quest--
    autonpcfunctions.AddTraderTrigger("Hello","Hello there, my name's Dorothy *looks sadly at the ground*, could you help me please?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Hallo","Hallo auch, mein Name ist Dorothy *sieht traurig zu Boden*, könntest du mir vielleicht helfen?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Greetings","Hello there, my name's Dorothy *looks sadly at the ground*, could you help me please?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Grüße","Hallo auch, mein Name ist Dorothy *sieht traurig zu Boden*, könntest du mir vielleicht helfen?");
    autonpcfunctions.AddCondition("qpg","=",0);
    autonpcfunctions.AddTraderTrigger("Help","I lost my locket while I was in Greenbriar, picking strawberries. Could you go ask Barney Haycrop whether he found a locket? You'll find him near the entrance of the town.");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Hilfe","Ich habe mein Medaillon verloren, als ich in Greenbriar Erdbeeren pflückte. Könntest du wohl Barney Haycrop fragen, ob er es gefunden hat? Du wirst ihn in der Nähe des Eingangs zur Stadt finden.");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("How",", queststatus=1");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Wie","Ich habe mein Medaillon verloren, als ich in Greenbriar Erdbeeren pflückte. Könntest du wohl Barney Haycrop fragen, ob er es gefunden hat? Du wirst ihn in der Nähe des Eingangs zur Stadt finden.");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Wrong",", queststatus=1");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Fehlt","Ich habe mein Medaillon verloren, als ich in Greenbriar Erdbeeren pflückte. Könntest du wohl Barney Haycrop fragen, ob er es gefunden hat? Du wirst ihn in der Nähe des Eingangs zur Stadt finden.");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Was","Ich habe mein Medaillon verloren, als ich in Greenbriar Erdbeeren pflückte. Könntest du wohl Barney Haycrop fragen, ob er es gefunden hat? Du wirst ihn in der Nähe des Eingangs zur Stadt finden.");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Bye","Umm, goodbye *wipes eyes*");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Tschüss","Ahm, auf Wiedersehen *wischt sich die Augen*");
    autonpcfunctions.AddCondition("qpg","<>",3);
    -- Already given quest
    autonpcfunctions.AddTraderTrigger("Hello","Hello again, did you find my locket yet? *looks hopeful*");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Hallo","Hallo nochmal, hast du mein Medaillon schon gefunden? *schaut hoffnungsvoll*");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Greetings","Hello again, did you find my locket yet? *looks hopeful*");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Grüße","Hallo nochmal, hast du mein Medaillon schon gefunden? *schaut hoffnungsvoll*");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("Yes","Thank you kind sir. *gives a broad smile* I'll be ever so grateful!");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("Ja","Danke euch, gütiger Herr. *lächelt dich breit an* Ich werde euch ewig dankbar sein!");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddCondition("sex","male");
    autonpcfunctions.AddTraderTrigger("Yes","Thank you miss. *gives a broad smile* I'll be ever so grateful");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddCondition("sex","female");
    autonpcfunctions.AddTraderTrigger("Ja","Danke euch, gütige Dame. *lächelt dich breit an* Ich werde euch ewig dankbar sein!");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddCondition("sex","female");
    -- Talked to other NPC
    autonpcfunctions.AddTraderTrigger("Hello","Please tell me you found my locket... it was a gift from my mother, and very precious to me");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Hallo","Bitte sagt mir, wenn ihr das Medaillon gefunden habt... es war ein Geschenk meiner Mutter und ist sehr wertvoll für mich.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Greetings","Please tell me you found my locket... it was a gift from my mother, and very precious to me");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Grüße","Bitte sagt mir, wenn ihr das Medaillon gefunden habt... es war ein Geschenk meiner Mutter und ist sehr wertvoll für mich.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Locket","Oh Thank you! Thank you!, I don't know what I can do to ever repay you... here, have this, I made it myself");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddCondition("item",222,"belt",">",0);
    autonpcfunctions.AddConsequence("deleteitem",222,1);
    autonpcfunctions.AddConsequence("item",353,1,333,0);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Medaillon","Oh, ich danke euch! Danke! Ich weiß nicht, wie ich euch das vergelten könnte... hier, nehmt dies, ich habe es selbst gemacht.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddCondition("item",222,"belt",">",0);
    autonpcfunctions.AddConsequence("deleteitem",222,1);
    autonpcfunctions.AddConsequence("item",353,1,333,0);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Here","Oh Thank you! Thank you!, I don't know what I can do to ever repay you... here, have this, I made it myself");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddCondition("item",222,"belt",">",0);
    autonpcfunctions.AddConsequence("deleteitem",222,1);
    autonpcfunctions.AddConsequence("item",353,1,333,0);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Hier","Oh, ich danke euch! Danke! Ich weiß nicht, wie ich euch das vergelten könnte... hier, nehmt dies, ich habe es selbst gemacht.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddCondition("item",222,"belt",">",0);
    autonpcfunctions.AddConsequence("deleteitem",222,1);
    autonpcfunctions.AddConsequence("item",353,1,333,0);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Have","Oh Thank you! Thank you!, I don't know what I can do to ever repay you... here, have this, I made it myself");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddCondition("item",222,"belt",">",0);
    autonpcfunctions.AddConsequence("deleteitem",222,1);
    autonpcfunctions.AddConsequence("item",353,1,333,0);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Habe","Oh, ich danke euch! Danke! Ich weiß nicht, wie ich euch das vergelten könnte... hier, nehmt dies, ich habe es selbst gemacht.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddCondition("item",222,"belt",">",0);
    autonpcfunctions.AddConsequence("deleteitem",222,1);
    autonpcfunctions.AddConsequence("item",353,1,333,0);
    autonpcfunctions.AddConsequence("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Locket","You have my locket? Where is it? *smiles hopefully*");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Medaillon","Ihr habt mein Medaillon? Wo ist es? *lächelt hoffnungsvoll*");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Here","You have my locket? Where is it? *smiles hopefully*");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Hier","Ihr habt mein Medaillon? Wo ist es? *lächelt hoffnungsvoll*");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Have","You have my locket? Where is it? *smiles hopefully*");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Habe","Ihr habt mein Medaillon? Wo ist es? *lächelt hoffnungsvoll*");
    autonpcfunctions.AddCondition("qpg","=",2);
    -- Quest Is done
    autonpcfunctions.AddTraderTrigger("Hello","Hello, and thanks for all you did for me. Hope you enjoyed the pie *smiles*");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Hallo","Hallo und danke nochmal für alles, dass ihr für mich getan habt. Ich hoffe, der Kuchen schmeckte euch. *lächelt*");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Greetings","Hello, and thanks for all you did for me. Hope you enjoyed the pie *smiles*");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Grüße","Hallo und danke nochmal für alles, dass ihr für mich getan habt. Ich hoffe, der Kuchen schmeckte euch. *lächelt*");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Bye","Goodbye *smiles broadly*");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Tschüss","Auf Wiedersehen *lächelt breit*");
    autonpcfunctions.AddCondition("qpg","=",3);
    -- Generic NPC Stuff
    autonpcfunctions.AddTraderTrigger("Sell","#me sobs quietly to herself");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Verkaufe","#me schluchzt leise vor sich hin");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Buy","#me sobs quietly to herself");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Kaufe","#me schluchzt leise vor sich hin");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Wares","#me sobs quietly to herself");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Waren","#me schluchzt leise vor sich hin");
    autonpcfunctions.AddCondition("qpg","<>",3);
    autonpcfunctions.AddTraderTrigger("Sell","Hehe, you seem to have liked that pie... I'm sorry but I don't make enough to sell");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Verkaufe","Hehe, der Kuchen scheint euch geschmeckt zu haben..., es tut mir leid aber ich mache nicht genug, um ihn zu verkaufen.");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Buy","I don't buy anything, I'm quite content now *looks proudly at her locket*");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Kaufe","Ich kaufe nichts, ich bin nun sehr zufrieden mit der Welt *sieht stolz auf ihr Medaillon*");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Wares","Sorry, I'm no vendor");
    autonpcfunctions.AddCondition("qpg","=",3);
    autonpcfunctions.AddTraderTrigger("Waren","Tut mir Leid, ich bin kein Händler.");
    autonpcfunctions.AddCondition("qpg","=",3);
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
