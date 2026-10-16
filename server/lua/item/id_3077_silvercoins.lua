local M = {}

local common = require("base.common")

-- UPDATE common SET com_script='item.id_3077_silvercoins' WHERE com_itemid IN (3077);

if not InitTime then
	InitTime=true;
	TimeList = {};
end

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
	if ( SourceItem.number == 1 ) then  --works only with 1 coin

    	if TimeList[User.id]~=nil then
			if  ( (math.abs(world:getTime("second") - TimeList[User.id]) ) <=3) then  --1 Rl. second delay
				return;
			end
		end

		
		if math.random(2) == 1 then	gValue = "Kopf"; eValue = "head";
		else gValue = "Zahl"; eValue = "tail"; end    
		
		User:talkLanguage(CCharacter.say, CPlayer.german, "#me wirft eine Münze in die Luft und fängt sie wieder auf. Sie zeigt "..gValue..".");
		User:talkLanguage(CCharacter.say, CPlayer.english, "#me throws a coin in the air and catches it again. It shows "..eValue..".");
      	TimeList[User.id] = world:getTime("second");
	end
end

return M
