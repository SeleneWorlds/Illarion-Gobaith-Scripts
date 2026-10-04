local M = {}

-- Standartscript für Instrumente spielen
-- Nitram

local common = require("base.common")

function M.new()
    local music = {}
    local talkTexts = {}

    function music.addTalkText(eText,gText)
        table.insert(talkTexts,{eText,gText});
    end

    function music.PlayInstrument(User,Item,Skill)
        local Skl=User:getSkill(Skill);
        local Qual=math.floor(Item.quality/100);
        local PlayVal=common.Limit(math.floor((Skl+(Qual*5))/120*#talkTexts*(math.random(8,13)/10)),1,#talkTexts);
        User:talkLanguage( CCharacter.say, CPlayer.german, talkTexts[PlayVal][2]);
        User:talkLanguage( CCharacter.say, CPlayer.english, talkTexts[PlayVal][1]);
        User:learn(8,Skill,3,100);
    end

    return music
end

return M
