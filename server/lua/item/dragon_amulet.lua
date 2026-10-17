local parent = require("item.id_222_amulett")
local common = require("base.common")
local M = setmetatable({}, { __index = parent })

function M.UseItem(User, SourceItem, TargetItem, counter, param, ltstate)
    if not TargetItem or TargetItem.id ~= 914 or TargetItem.data ~= 666 then return end
        User:talkLanguage(CCharacter.say,CPlayer.german ,"#me's Hand leuchtet, ebenso wie das Drachenamulett, hell auf und als das Licht verlischt, liegt ein seltsam geformter Schlüssel in der Hand und die Schrift auf dem Steinsockel glüht auf.");
        User:talkLanguage(CCharacter.say,CPlayer.english,"#me's hand and the dragon amulet glow brightly. As the light fades, a strangely shaped key appears in the hand and the letters on the stone pedestal begin to shine.");
		world:gfx(8,TargetItem.pos);
		world:gfx(11,TargetItem.pos);
		world:gfx(31,TargetItem.pos);
		world:swap(TargetItem,3105,333);
		world:makeSound(7,TargetItem.pos);
		world:makeSound(26,TargetItem.pos);
		local Keydata=0;
		if (User.pos.z == -6) then
			Keydata=666;
		elseif (User.pos.z == 1) then
			Keydata=667;
		elseif (User.pos.z == 3) then
			Keydata=668;
		elseif (User.pos.z == 0) then
			Keydata=669;
		end
		User:createItem( 2144, 1, 333, Keydata );

end

return M
