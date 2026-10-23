local M = {}
local common = require("base.common")

function M.UseItem(User, SourceItem, TargetItem, Counter, Param, ltstate)
    if (User:getSkill("ancient language") < 60) then return end
    if ( ltstate == nil or ltstate == Action.success ) then
        User:warp(position(-243,-340,-3));
    elseif ( ltstate == Action.none ) then
        User:startAction( 100,53, 4, 0, 0);
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt in einem Buch zu lesen.", { showInChat = false });
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts reading in a book.", { showInChat = false });
    elseif ( ltstate == Action.abort ) then
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me hört auf in dem Buch zu lesen.", { showInChat = false });
        User:talkLanguage(CCharacter.say, CPlayer.english,"#me stops reading in the book.", { showInChat = false });
    end
end

function M.LookAtItem(User, Item)
    world:itemInform(User, Item, common.GetNLS(User, "Buch des Ephraim", "Book of Ephraim"))
end

return M
