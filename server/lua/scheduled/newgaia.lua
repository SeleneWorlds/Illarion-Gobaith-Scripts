local areas = require("base.areas")
local M = {}

-- INSERT INTO scheduledscripts VALUES('scheduled.newgaia', 10, 30, 'plantdrop');

function M.initHerbs()
	-- id  		= Itemid
	-- ground	= Ground the herb is dropping on
	-- item		= item, the herb can found in
	-- region	= Array with the reagions
	M.herbs = {}
	M.herbs[133] = {id = 133, ground = 11, item = {273}, region = {}} 			-- Sunflower
	M.herbs[142] = {id = 142, ground =  3, item = {273}, region = {}} 			-- Sandbeere
	M.herbs[146] = {id = 146, ground =  3, item = {301}, region = {}} 			-- Wuestenhimmelskaspel

	M.initRegions();
end


function M.initRegions()
    -- Area name and seasonal drop chances {spring, summer, autumn, winter}.
    M.addRegion(133, "herb_growth_sunflower", {30, 60, 40, 50});
    M.addRegion(142, "herb_growth_sandberry", {30, 60, 40, 50});
    M.addRegion(146, "herb_growth_desert_sky_capsule", {30, 60, 40, 50});
end


function M.plantdrop()
	M.initHerbs();
	if (world:isCharacterOnField(position(136,648,0))) then
		user = world:getCharacterOnField( position(136,648,0) );
		table.foreach( M.herbs, M.setHerb )
	end
end


function M.setHerb(HerbID)
    local herb = M.herbs[HerbID]
    user:inform("Herb: " .. herb.id)
    user:inform("Herb ground: " .. herb.ground)
    for _, region in ipairs(herb.region) do
        local positions = areas.positions(region.area)
        user:inform("Anzahl der Tiles: " .. #positions)
        user:inform("Drop-Chance: " .. M.getDropChance(region.season))
        for _, TilePos in ipairs(positions) do
            if M.checkGround(herb, TilePos) and math.random(100) <= M.getDropChance(region.season) then
                world:createItemFromId(HerbID, 1, TilePos, false, 333, 333)
            end
        end
    end
end

function M.addRegion(HerbID, areaName, season)
    table.insert(M.herbs[HerbID].region, { area = areaName, season = season })
end

function M.getTileNumbersofRegion(region)
    return #areas.positions(region.area)
end

function M.getDropChance(Season)
	currentSeason = math.ceil( world:getTime("month") / 4 );
	chance = Season[currentSeason];
	return chance;
end

function M.checkGround(herbs,TilePos)
	-- Check Ground
	TileID = world:getField(TilePos):tile();
	if not (TileID==herbs.ground) then
		return false;
	end
	return true;
end

return M
