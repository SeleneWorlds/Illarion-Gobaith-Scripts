-- Skript f�r das Druidensystem
-- Pflanzennamen
require("base.common")

local M = {}
		M.dummyIDList = {9001,9002,9003,9004,9005,9006,9007,9008,9009,9010,9011,9012,9013,9014,9015,9016}
		M.dummyNameListDE = {}
		M.dummyNameListEN = {}
		M.dummyNameListDE[1] = "Einbl�ttrige Vierbeere";		-- Sonnenkraut
		M.dummyNameListDE[2] = "Blaue Vogelbeere";			-- Vierbl�ttrige Einbeere
		M.dummyNameListDE[3] = "Schwefelkraut";				-- Gelbkraut
		M.dummyNameListDE[4] = "Frommbeere";					-- Wutbeere
		M.dummyNameListDE[5] = "Wasserbl�te";					-- Flamkelchbl�te
		M.dummyNameListDE[6] = "Tagteufel";					-- Nachtengelsbl�te
		M.dummyNameListDE[7] = "Rauchblatt";					-- Donfblatt
		M.dummyNameListDE[8] = "Graue Distel";				-- Schwarze Distel
		M.dummyNameListDE[9] = "W�stenbeere";					-- Sandbeere
		M.dummyNameListDE[10] = "Altweiberkraut";				-- Jungfernkraut
		M.dummyNameListDE[11] = "Regenkraut";					-- Heidebl�te
		M.dummyNameListDE[12] = "Gottesblume";				-- W�stenhimmelskapsel
		M.dummyNameListDE[13] = "Feuerwurz";					-- Lebenswurz
		M.dummyNameListDE[14] = "Trugbl�te";					-- Firnisbl�te
		M.dummyNameListDE[15] = "Wolfsfarn"					-- Steppenfarn
		M.dummyNameListDE[16] = "Wiesen-Rhabarber"			-- Fussblatt

		M.dummyNameListEN[1] = "oneleaved fourberry";
		M.dummyNameListEN[2] = "blue birdsberry";
		M.dummyNameListEN[3] = "sulfur weed";
		M.dummyNameListEN[4] = "pious berry";
		M.dummyNameListEN[5] = "water blossom";
		M.dummyNameListEN[6] = "daydevil";
		M.dummyNameListEN[7] = "reek leave";
		M.dummyNameListEN[8] = "grey thistle";
		M.dummyNameListEN[9] = "desert berry";
		M.dummyNameListEN[10] = "gossamer weed";
		M.dummyNameListEN[11] = "rain weed";
		M.dummyNameListEN[12] = "godsflower";
		M.dummyNameListEN[13] = "fire root";
		M.dummyNameListEN[14] = "con blossom";
		M.dummyNameListEN[15] = "wolverine fern";
		M.dummyNameListEN[16] = "meadow rhabarb";

function M.getDummyIDList()
	return M.dummyIDList
end

function M.getDummyNameDE(i)
	return M.dummyNameListDE[i]
end

function M.getDummyNameEN(i)
	return M.dummyNameListEN[i]
end

function M.LookAtItem(User,Item)
-- 133 Sonnenkraut                15 / 9001 / 81
-- 134 Vierbl�ttrige Einbeere     16 / 9002 / 72
-- 135 Gelbkraut                  17 / 9003 / 63
-- 136 Wutbeere                   18 / 9004 / 48
-- 137 Flamkelchbl�te             25 / 9005 / 53
-- 138 Nachtengelsbl�te           26 / 9006 / 64
-- 140 Donfblatt                  27 / 9007 / 71
-- 141 Schwarze Distel            28 / 9008 / 73
-- 142 Sandbeere                  35 / 9009 / 82
-- 144 Jungfernkraut              37 / 9010 / 74
-- 145 Heidebl�te                 38 / 9011 / 83
-- 146 W�stenhimmelskapsel        45 / 9012 / 84
-- 148 Firnisbl�te                47 / 9014 / 46
-- 152 Lebenswurz				  51 / 9013 / 62
-- 153 Fussblatt				  52 / 9016 / 36
-- 156 Steppenfarn                61 / 9015 / 54

	ItemName=world:getItemName( Item.id, User:getPlayerLanguage() );
	textDE = ItemName
	textEN = ItemName
	--initSpecialPlants()

	for i=1,16 do
		if M.dummyIDList[i] == Item.data then

			textDE = M.dummyNameListDE[i]
			textEN = M.dummyNameListEN[i]
		end
	end
	if User:getPlayerLanguage() == 0 then
		world:itemInform(User,Item,textDE)
	else
		world:itemInform(User,Item,textEN)
	end
end

return M
