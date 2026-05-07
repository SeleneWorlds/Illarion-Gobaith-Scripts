local M = {}
local addTalkText, PlayInstrument

-- Standartscript f�r Instrumente spielen
-- Nitram

local common = require("base.common")

local TalkTexts = {}

function M.addTalkText(eText,gText)
    table.insert(TalkTexts,{eText,gText});
end

function M.PlayInstrument(User,Item,Skill)
    local Skl=User:getSkill(Skill);
    local Qual=math.floor(Item.quality/100);
    local PlayVal=common.Limit(math.floor((Skl+(Qual*5))/120*#TalkTexts*(math.random(8,13)/10)),1,#TalkTexts);
    User:talkLanguage( CCharacter.say, CPlayer.german, TalkTexts[PlayVal][2]);
    User:talkLanguage( CCharacter.say, CPlayer.english, TalkTexts[PlayVal][1]);
    User:learn(8,Skill,3,100);
end

return M
