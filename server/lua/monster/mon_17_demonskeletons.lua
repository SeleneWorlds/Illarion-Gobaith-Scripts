local init
local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("Die Toten dulden keine Lebenden in ihrer Mitte. Die Strafe für euer Eindringen ist der Tod.", "The undead shall not allow the living to dwell here. The punishment for such insolence shall be death!");
msgs:addMessage("Die Toten verlangen nach frischem Blut. Deinem Blut!", "The undead demand fresh blood, your blood!");
msgs:addMessage("Es ist gut das ihr hier seid, Sterblicher. Die Stimmung hier war irgendwie tot.", "It's good that you are here, mortal. Now you can entertain me.");
msgs:addMessage("Selbst wenn du meinen Körper zerschlägst, werde ich zurück kommen. Wie ist es bei dir?", "Even if you destroy my body, I will return. How about you?");
msgs:addMessage("Wie tötet man etwas was schon tot ist? Das hättest du dir eher überlegen sollen!", "How do you expect to kill something that is already dead? You should have thought about that earlier!");
msgs:addMessage("#me unternimmt nichts um die blutbefleckten Folterinstrumente zu verstecken die von seiner knochigen Hüfte baumeln: eine rostige Schere, gezackte Metallscherben, Zangen, und verschiedene Phiolen mit Flüssigkeiten.", "#me does nothing to conceal the blood soaked devices of torture clanging from its bony hip: rusted scissors, jagged shards of metal, tongs, and various vials of liquid.");
msgs:addMessage("#mes schreckliche Aura zerstört das natürliche Gleichgewicht. Jene, denen die höheren, geistigen Ebenen offen stehen, spüren vielleicht seine ruchlose Gier.", "#me's unholy aura corrupts the natural balance, even those oblivious to the ethereal planes might sense its heinous lust.");
msgs:addMessage("#mes Durst nach Zerstörung ist unerbittlich, und so benutzt es seine höllische Macht um seine verderbliche Wut zu entfesseln.", "#me is unrelenting in its thirst for destruction, using its infernal powers to unleash its baleful wrath.");
msgs:addMessage("#mes Knochen krachen und knirschen bedrohlich mit jeder lebhaften Bewegung.", "#me's bones grind and crack ominously with its animated movements.");
msgs:addMessage("#mes teuflisch gerötete Knochen tropfen von geronnenem Blut während ein abscheulicher Gestank die Luft vergiftet.", "#me's fiendishly reddened bones drip with clotted blood as an abhorrent stench pollutes the air.");
msgs:addMessage("#me bewegt seinen deformierten Unterkiefer als wolle es sprechen, aber stattdessen rasselt ein beunruhigendes Krachen durch die Luft.", "#me moves its mangled jaw as if to speak, but instead an unsettling crackle rattles through the air.");
msgs:addMessage("#me weicht wie in Trance erstarrt aus, niemals zögerlich oder locker, sein einziges Ziel ist es die zerstörerische Gier zu befriedigen.", "#me manoeuvres in a rigid trance, never hesitant or lax, its only purpose is to devour.");
msgs:addMessage("#me beugt sich in verwirrtem Irrsinn nieder, all sein Können benutzend um in elendem Zorn Leben zu verschlingen.", "#me bears down with a deranged frenzy using everything in its répertoire to consume life in its blighted rage.");
msgs:addMessage("#mes scheinbar zerbrechliches Äußeres stellt sich als täuschend heraus, verschleiert es doch die tatsächliche Macht der schwarzen Magie, die das Skelett umgibt, auf verräterische Weise.", "#me's seemingly fragile exterior proves to be deceiving as he mutters words of black magic.");
msgs:addMessage("#me streift eine lästige Sammlung blutverkrusteter, ineinander verwickelter Ketten über seine Schultern und seinen Oberkörper.", "#me drags a cumbersome set of blood encrusted chains that intertwine around its shoulders and torso.");
msgs:addMessage("#me zischt erbost: 'Ich bin nicht auferstanden, um mir von euch erneut ein Ende bereiten zu lassen. Sterbt!'", "#me hisses in fury: 'I did not rise from the dead just to get finished off by you. Die!'");
msgs:addMessage("#me lacht mit krachenden Kiefern und kleine Flammen züngeln aus seinen Augenhöhlen.", "#me laughs with snapping jaw, small flames glowing from its eyeholes.");
msgs:addMessage("Du kannst mich nicht bezwingen, das vermochte nicht einmal der Tod zu erreichen.", "You will not succeed in what death failed in.");
msgs:addMessage("Ich werde dich töten, Sterblicher, auf dass du die Qualen erleiden mögest, die ich durchgestanden habe!", "I will slay you, mortal, for you shall suffer as I did.");
msgs:addMessage("#me schnarrt drohend und dreht den Kopf von einer Seite zur anderen.", "#me snares evilly and turns its head from side to side.");
msgs:addMessage("#me kreischt hysterisch mit schriller Stimme 'Na los, erlöse mich von meinem unseligen Dasein!'.", "#me screams in a shrill voice: 'Come on, relive me from my puny existance!'.");
msgs:addMessage("#me breitet die Arme aus und ein blutrotes Leuchten geht von seinen Knochen aus. Ein Schaudern scheint das Skelett zu erfüllen, ehe es sich wie im Rausch auf sein Opfer stürzt.", "#me spreads its arms and a blood red glow is radiated from its bones. A shiver seems to overcome the skeleton before it charges its victim.");
msgs:addMessage("Geht in die Knie, Sterblicher, und ich werde euch vielleicht verschonen… vielleicht werd ich euer Ende aber auch nur schneller bereiten!", "Kneel down, mortal, and I will spare you... or just make the end approach faster.");
msgs:addMessage("#me krächzt verworren: 'Du dachtest, du hättest mich erledigt. Das wirst du nun büßen!'", "#me croaks abstrusely: 'You thought you were done with me. You shall regret this!'");
msgs:addMessage("#me flüstert lockend: 'Begib dich in Cherga's Umarmung und werde einer von uns…'.", "#me whispers alluringly: 'Embrace Cherga and become one of us…'.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==172) then
        return ( drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1) == true );
    elseif (MonID==175) then
        if drop.SuddenWarp(Monster,Enemy,true) then
            return true
        end
        if drop.CastMonster(Monster,Enemy,10,{111,115},40) then
            return true
        end
        if drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1) then
            return true
        end
        return false
    else
        return false;
    end
end

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if drop.DefaultSlowdown( Monster ) then
        return true
    elseif (MonID==172) then
        return ( drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1) == true );
    elseif (MonID==175) then
        if drop.CastMonster(Monster,Enemy,10,{111,115},40) then
            return true
        end
        if drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1) then
            return true
        end
        return false
    else
        return false;
    end
end

function M.onAttacked(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function M.onCasted(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function M.onDeath(Monster)

    if killer[Monster.id] ~= nil then

        murderer=getCharForId(killer[Monster.id]);
    
        if murderer then
            killer[Monster.id]=nil;
            murderer=nil;

        end
    end

    drop.Dropping(Monster);
end

return M
