local M = {}

local chardescription = require("content.chardescription")

local getAgeText = chardescription.getAgeText
local getClothesDuraText = chardescription.getClothesDuraText
local getClothesFactor = chardescription.getClothesFactor
local getClothesQualText = chardescription.getClothesQualText
local getFigureText = chardescription.getFigureText
local getHPText = chardescription.getHPText

-- UPDATE common SET com_script='item.id_2874_mirror' WHERE com_itemid = 2874;

function M.LookAtItem(User, Item)
    if User:getPlayerLanguage() == 0 then
        world:itemInform(User, Item, "Du siehst Spiegel")
    else
        world:itemInform(User, Item, "You see mirror")
    end
end

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
	local output = "";
	local lang = User:getPlayerLanguage();
	local qual,dura = getClothesFactor(User);
	local ft = getFigureText(User:increaseAttrib("body_height",0),User:increaseAttrib("weight",0),User:increaseAttrib("strength",0), lang);
	if(lang == 0) then
		output = "Du bist ";
		output = output..getAgeText(User:get_race(), User:increaseAttrib("age", 0), lang);
		if(ft ~= nil) then
			output = output..", "..ft;
		end
		output = output.." und "..getHPText(User:increaseAttrib("hitpoints",0), lang)..". ";
		output = output.."Deine Kleidung wirkt "..getClothesQualText(qual, lang).." und "..getClothesDuraText(dura, lang)..".";
	else
		output = "You are ";
		output = output..getAgeText(User:get_race(), User:increaseAttrib("age", 0), lang);
		if(ft ~= nil) then
			output = output..", "..getFigureText(User:increaseAttrib("body_height",0),User:increaseAttrib("weight",0),User:increaseAttrib("strength",0), lang);
		end
		output = output.." and "..getHPText(User:increaseAttrib("hitpoints",0), lang)..". ";
		output = output.."Your clothes look "..getClothesQualText(qual, lang).." and "..getClothesDuraText(dura, lang)..".";
	end
	User:sendCharDescription(User.id, output);
end

return M
