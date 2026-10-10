local M = {}
local responses = {
    [1] = {{"Nicht so schnell. Es ist nicht so das ich gierig bin, aber es ist normal für Elfen, das die Studenten eine kleine Gabe an ihren Lehrer übergeben", "Not so fast. It is not that I am greedy, but it is customary among Elves that a student provide a tribute to his/her teacher."}},
    [2] = {{"Ah. Ihr habt eine Firnis Blüte. Ich danke euch.", "Oh. You have a firnis blossom. Thank you."}},
    [3] = {{"Firnis...ja. Dies schöne Gebirgsblume möchte ich, wenn ich euch die Sprache der Elfen beibringen soll.", "Firnis...yes. This nice Mountainflower i want to have, if i shall teach you the elven language."}},
    [4] = {{"Ihr habt mir doch bereits eine Firnisblüte gegeben.", "You give already a firnis blossom to me."}},
    [5] = {{"Firnis ist eine Pflanze die im Gebirge wächst.", "Firnis is a plant, growing in the mountains."}},
    [6] = {{"Ah. Ihr habt eine Nacht Engels Blüte. Vielen Dank", "Oh. You have a night angels blossom. Thank you"}},
    [7] = {{"Die wunderschöne Nacht Engels Blüte, hätte ich gern von euch. Ich komme so selten in den Wald.", "The wonderful night angels blossom, i want to have from you. I'm to seldom the forest..."}},
    [8] = {{"Ihr habt mir doch bereits eine Nacht Engels Blüte gegeben", "You give already a night angels blossom to me."}},
    [9] = {{"Die Nacht Engels Blüte kann in den Wäldern gefunden werden", "The night angels blossom can be founded in the forests"}},
    [10] = {{"#me stopft seine Pfeife mit den Sibanacblättern und zündet sie an. Bald beginnt er dünne Rauchringe wegzublasen", "#me puts the Sibanac leaves in a pipe and lights it. He soon begins to puff away at the pipe"}, {"Ahh...so. Wo waren wir? Ahja. Ich war dabei euch die Grundlagen der schönen Sprache der Elfen beizubringen.", "Ah. Now where were we? Ah, yes. I was to teach you the basics of the Elven Tongue."}},
    [12] = {{"Ein Blatt gutes Sibanac...das wäre was feines. Ein warer Genuss es zu rauchen. Nur will ich dafür nicht in die Wüste gehen.", "A leave of good sibanac...this would be fine. A real pleasure to smoke it. But i don't want to go into the desert to get one leave."}},
    [13] = {{"Sibanac. Ja. Es kommt nur in der Wüste vor. Schwer zu finden.", "Sibanac. Yes. It only grows in the desert. Hard to get such a leave."}},
    [14] = {{"Ah. Sehr gut. Nun da ihr mir alles gebracht habt, verlange ich nur noch ein Sibanac Blatt und wir können mit dem Unterricht beginnen.", "Ah. Very good. Now you give every thing to me, i just want to have one thing more. A Sibanac leaf. Then we can start the lesson."}},
    [15] = {{"Ihr als Elf müsst wohl kaum etwas über die Sprache unseres Volkes lernen", "I sure, you as a elf, don't have to learn anything about our language."}},
}

local function say(context, status)
    local language = context.player:getPlayerLanguage() == 0 and 1 or 2
    for _,pair in ipairs(responses[status]) do context.npc:talk(Character.say, pair[language]) end
end

local function student(context)
    context.state.students = context.state.students or {}
    local students = context.state.students
    students[context.player.id] = students[context.player.id] or {}
    return students[context.player.id]
end

function M.start(context)
    local progress = student(context)
    if context.player:getRace() == 3 then say(context, 15); return end
    progress.started = true
    say(context, 1)
end

local function blossom(context, key, other, item, accepted, missing, duplicate, information)
    local progress = student(context)
    if not progress.started then say(context, information); return end
    if progress[key] then say(context, duplicate); return end
    if context.player:countItem(item) < 1 then say(context, missing); return end
    context.player:eraseItem(item, 1)
    progress[key] = true
    say(context, progress[other] and 14 or accepted)
end

function M.firnis(context)
    blossom(context, 'firnis', 'night', 148, 2, 3, 4, 5)
end

function M.night(context)
    blossom(context, 'night', 'firnis', 138, 6, 7, 8, 9)
end

function M.teach(context)
    local progress = student(context)
    if not (progress.started and progress.firnis and progress.night) then say(context, 13); return end
    local player = context.player
    if player:countItem(155) < 1 then say(context, 12); return end
    local race = player:getRace()
    local baseSkill = ({[0]=40, [1]=10, [2]=20, [3]=100, [4]=5, [5]=5, [6]=5, [7]=60, [8]=5})[race] or 0
    local target = race == 3 and 100 or math.floor(baseSkill * player:increaseAttrib('intelligence', 0) / 18)
    local skill = player:getSkill('elf language')
    local learned = race ~= 3 and skill < target
    if target > skill then player:increaseSkill('elf language', target - skill) end
    player:eraseItem(155, 1)
    say(context, 10)
    if learned then
        player:inform(player:getPlayerLanguage() == 0
            and 'Seine Ausführungen lassen die Sprache recht leicht erscheinen und du denkst, dass du schnell lernst.'
            or 'His discourses make the language seem quite simple as compared to the common tongue, and you find yourself learning fast.')
        player:inform(player:getPlayerLanguage() == 0
            and 'Du erkennst, dass du nun viele Wörter schon kennst und die Sprache schon etwas anwenden kannst.'
            or 'You begin to realize that many words you already know have a common heritage with many of the words you are learning.')
    else
        player:inform(player:getPlayerLanguage() == 0
            and 'Yastahl fängt mit den Grundlagen der Sprache der Elfen an, aber du kennst die Wörter schon seit einiger Zeit, wie auch immer, Yastahl nimmt es nicht wohlwollend hin, wenn sein Unterricht unterbrochen wird.'
            or 'Yastahl begins with the basics of the Elven Tongue, but you already have known these words for some time; however, Yastahl does not take kindly to being interrupted during lessons.')
        player:inform(player:getPlayerLanguage() == 0
            and 'Nach einiger Zeit fängt er an von den komplexeren Teilen der Sprache zu sprechen, doch dann beginnt das Sibanac sein Denken zu beeinflussen und so kannst du nicht mehr lernen.'
            or 'By the time he begins to get to the more advanced rules of the language, the sibanac has started to affect his thinking, and he is no longer of any use to you.')
    end
end

return M
