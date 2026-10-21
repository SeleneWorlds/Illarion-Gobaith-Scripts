-- Basic functions for treasure maps
-- Useable for creating maps and finding treasures

local common = require("base.common")
local areas = require("base.areas")
local M = {}

local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")

local loot = Rolls:new()
local guardians = Rolls:new()
local mapLevels = Rolls:new()

local function definition(level)
    return assert(Registries.findByMetadata("illarion:treasure_maps", "id", level),
        "Unknown treasure level: " .. tostring(level))
end

local function registryId(registry, name)
    local entry = assert(Registries.findByName(registry, name), "Unknown treasure reference: " .. tostring(name))
    return assert(entry:getMetadata("id"), "Missing treasure reference ID: " .. tostring(name))
end

loot:registerType("nothing", function() end)
loot:registerType("item", function(entry)
    local data = entry.data
    return { registryId("illarion:items", data.item), math.random(data.count.min, data.count.max),
        data.data or 0, quality = data.quality, durability = data.durability }
end)
guardians:registerType("monster", function(entry)
    return registryId("illarion:monsters", entry.data.monster)
end)
mapLevels:registerType("level", function(entry) return entry.data end)

function M.GetTreasureName(level, lang, details)
    -- Empty/invalid-map labels are UI fallbacks, not treasure reward levels.
    if details and (level < 1 or level > 9) then
        return lang == 0 and "keinen Schatz" or "no treasure"
    end
    if not details and level == 0 then
        return lang == 0 and "leere Schatzkiste" or "empty treasure chest"
    end
    local profile = definition(details and level or math.max(1, math.min(9, math.ceil(level))))
    local message = profile:getField(details and "description" or "summary")
    return lang == 0 and message.de or message.en
end

function M.GetMonsterList(level)
    local result = {}
    for _, selected in ipairs(guardians:roll(definition(level):getField("guardians"))) do
        result[#result + 1] = selected.value
    end
    return result
end

function M.GetTreasure(level)
    local result = {}
    for _, selected in ipairs(loot:roll(definition(level):getField("loot"))) do
        if selected.value then result[#result + 1] = selected.value end
    end
    return result
end

function M.GetQuality(level)
    local profile = definition(level)
    local quality, durability = profile:getField("quality"), profile:getField("durability")
    return math.random(quality.min, quality.max), math.random(durability.min, durability.max)
end

local function spawnItem(item, profile, pos)
    local quality = item.quality or profile:getField("quality")
    local durability = item.durability or profile:getField("durability")
    world:createItemFromId(item[1], item[2], pos, true,
        math.random(quality.min, quality.max), item[3], math.random(durability.min, durability.max))
end

    local treasureMonsters = {};

    function M.SpawnMonsters( User, level )
	    local TargetPos=User.pos; --attempt to fix a bug by Estralis
        if not treasureMonsters[User.id] then
            treasureMonsters[User.id] = {};
        end
        local monList = M.GetMonsterList( level );
        local newPos;
        local mon;
        for i, monID in pairs(monList) do
            newPos=M.getFreePos( TargetPos, 4 );
            world:gfx(31,newPos);
            mon = world:createMonster(monID, newPos, 10);

            table.insert( treasureMonsters[User.id], mon );
        end
    end

    function M.CheckMonsters( User )
        if not treasureMonsters[User.id] then
            return true;
        end

        for i,mon in pairs(treasureMonsters[User.id]) do
            if mon and mon:increaseAttrib("hitpoints",0) > 0 then
                return false;
            end
        end

        treasureMonsters[User.id] = nil;
        return true;
    end

    function M.KillMonsters( User )
        if not treasureMonsters[User.id] then
            return true;
        end

        for i,mon in pairs(treasureMonsters[User.id]) do
            if mon and mon:increaseAttrib("hitpoints",0) > 0 then
                mon:increaseAttrib("hitpoints",-10000);
            end
        end
        treasureMonsters[User.id] = nil;
        return true;
    end

    function M.getFreePos( CenterPos, Rad )
        local tarPos;
        while true do
            tarPos = position(CenterPos.x+math.random(-Rad,Rad),CenterPos.y+math.random(-Rad,Rad),CenterPos.z);
            if not world:isItemOnField( tarPos ) and not world:isCharacterOnField( tarPos ) then
                local tileID = world:getField( tarPos ):tile();
                if tileID ~= 0 and tileID ~= 5 and tileID ~= 6 and tileID~=42 and tileID ~= 43 and tileID~= 34 then --no inpassable tiles
                    return tarPos;
                end
            end
        end
    end

    function M.SpawnTreasure(level, pos)
        local profile = definition(level)
        local rewards, currency = profile:getField("loot"), profile:getField("currency")
        -- Validate both definitions before creating any rewards.
        loot:validate(rewards)
        loot:validate(currency)
        for _, selected in ipairs(loot:roll(rewards)) do
            if selected.value then spawnItem(selected.value, profile, pos) end
        end
        for _, selected in ipairs(loot:roll(currency)) do
            if selected.value then spawnItem(selected.value, profile, pos) end
        end
    end

    function M.getDistance( User, Item )
        local RealTarget = position(tonumber(Item:getData("x")), tonumber(Item:getData("y")), tonumber(Item:getData("z")));
        local TargetLocation = M.modPosition( User, RealTarget );
        if not TargetLocation then
            return false;
        end
        local metricDistance = User:distanceMetricToPosition ( TargetLocation );
        if ( metricDistance < 20 ) then
            return common.GetNLS( User, "sehr nah", "very close" );
        elseif ( metricDistance < 60 ) then
            return common.GetNLS( User, "nah", "close" );
        elseif ( metricDistance < 200 ) then
            return common.GetNLS( User, "fern", "far" );
        elseif ( metricDistance < 500 ) then
            return common.GetNLS( User, "sehr fern", "very far" );
        else
            return common.GetNLS( User, "äußerst fern", "extremely far" );
        end
    end

    function M.getDirection( User, Item )
        local RealTarget = position(tonumber(Item:getData("x")), tonumber(Item:getData("y")), tonumber(Item:getData("z")));
        local TargetLocation = M.modPosition( User, RealTarget );
        if not TargetLocation then
            return false;
        end
        local dir = common.GetDirection( User.pos, TargetLocation );
        if ( dir == 0 ) then
            return common.GetNLS( User, "Norden", "north" );
        elseif ( dir == 1 ) then
            return common.GetNLS( User, "Nordosten", "northeast" );
        elseif ( dir == 2 ) then
            return common.GetNLS( User, "Osten", "east" );
        elseif ( dir == 3 ) then
            return common.GetNLS( User, "Südosten", "southeast" );
        elseif ( dir == 4 ) then
            return common.GetNLS( User, "Süden", "south" );
        elseif ( dir == 5 ) then
            return common.GetNLS( User, "Südwesten", "southwest" );
        elseif ( dir == 6 ) then
            return common.GetNLS( User, "Westen", "west" );
        elseif ( dir == 7 ) then
            return common.GetNLS( User, "Nordwesten", "northwest" );
        end
    end

    function M.modPosition( User, posi )
    	local UserPer = User:increaseAttrib( "perception", 0 );
    	math.randomseed( User.id + UserPer+math.abs(posi.x) );

    	local diff = math.ceil( -0.007342*UserPer*UserPer-0.676*UserPer+15.1336 );
    	diff = math.min( 15, math.max( 0, diff ) );
    	local modBy = math.random( 0, diff );
    	local rad = math.rad( math.random(0, 360) );

    	local newPos = position( posi.x + (modBy * math.sin(rad)), posi.y + (modBy * math.cos(rad)), posi.z )
    	if User:isInRangeToPosition( newPos, diff ) then
    	    return false;
    	else
    	    return newPos;
    	end
    end

    function M.createMap( Char, level )
        local MapPosition = M.findPosition( );
        if not MapPosition then
            return false;
        end
        local MapQuality
        if type(level) == "number" and level == math.floor(level)
            and Registries.findByMetadata("illarion:treasure_maps", "id", level) then
            MapQuality = level
        else
            local entries = {}
            for _, profile in pairs(Registries.findAll("illarion:treasure_maps")) do
                entries[#entries + 1] = { type = "level", weight = profile:getField("mapWeight"),
                    data = profile:getMetadata("id") }
            end
            table.sort(entries, function(a, b) return a.data < b.data end)
            local selected = mapLevels:roll({ pools = {{ entries = entries }} })
            local selectedLevel = assert(selected[1], "No treasure levels available for maps").value
            MapQuality = selectedLevel
        end
        common.CreateItem(Char, 505, 1, MapQuality, {x = MapPosition.x, y = MapPosition.y, z = MapPosition.z});
		return true;
    end

    function M.findPosition( )
        local newPos;
        local tileID;
        local itemID;
        local i = 0;
        while true do
            newPos = areas.randomPosition("treasure_wilderness");
            if not newPos then return false end
            tileID = world:getField(newPos):tile();
            if tileID == 2 or tileID == 3 or tileID == 4 or tileID == 8 or tileID == 9 or tileID == 10 or tileID == 11 or tileID == 15 then -- only "non-urban" basic tiles
                if not world:isItemOnField(newPos) then
                    return newPos;
                end
            end
            i = i + 1;
            if i == 40 then
                return false;
            end
        end
        return newPos;
    end

    local foundTreasureAt = {};

    function M.DigForTreasure( User, TargetPosition, maxToFind, diggingOutMsg, foundMessage )
        local worked;
        local mapItem;
        local mapItemNr;

        worked,mapItem,mapItemNr = M.checkMap( User, TargetPosition );
        if not worked then
            return false;
        end

        local treasureLevel = mapItem.quality;
        if ( treasureLevel > maxToFind ) then
            common.TempInformNLS( User,
            "Du bist nicht erfahren genug in der Bergarbeit um diesen Schatz auszugraben.",
            "You are not skilled enough in mining to dig out the treasure." );
            return false;
        end

        local mapPosition = position(tonumber(mapItem:getData("x")), tonumber(mapItem:getData("y")), tonumber(mapItem:getData("z")));
        local mapPositionKey = table.concat({mapPosition.x, mapPosition.y, mapPosition.z}, ",");
        if diggingOutMsg and not foundTreasureAt[mapPositionKey] then
            User:inform( diggingOutMsg );
            foundTreasureAt[mapPositionKey] = true;
            return true;
        end

        if foundMessage then
            User:inform( foundMessage );
        else
            common.TempInformNLS( User,
            "Du gräbst den Schatz aus dem Boden aus und musst dabei leider feststellen, dass der Schatz einige Wächter hat.",
            "You dig the treasure out of the ground and realize that the treasure sadly has some guards." );
        end

        local fndTreasure;
        local treasureEff;
        fndTreasure, treasureEff = User.effects:find(16);
        if not fndTreasure then --User:inform("Effect given");
            treasureEff=CLongTimeEffect(16,1);
            treasureEff:addValue("x", mapPosition.x);
            treasureEff:addValue("y", mapPosition.y);
            treasureEff:addValue("z", mapPosition.z);
            treasureEff:addValue("category",treasureLevel);
            User.effects:addEffect(treasureEff);
        else
            common.InformNLS(User,
                "Du hast schon einen Schatz ausgegraben und die Wächter noch nicht besiegt.",
                "You already dug out a treasure and didn't overcome the guardians." );
            treasureEff.nextCalled =20;
        end
        if ( mapItemNr > 0 ) then
            local thisBP=User:getBackPack();
            thisBP:takeItemNr(mapItemNr,255);
        else
            world:erase( mapItem, 1 );
        end
        return true;
    end

    function M.analyzeMap( Item )
        local mapDiff=Item.quality;
        local mapPartsMax=math.floor(Item.durability/10);
        local mapPartsThis=(Item.durability % 10);

        return mapDiff, mapPartsMax, mapPartsThis
    end

    function M.checkMap( User, TargetPosition )
        if User:countItem(505)==0 then
            return false,0,0;
        end

        -- inventory
        local myItem;
        local theMax;
        local theDiff;
        local thePart;
        for i=1,17 do
            myItem = User:getItemAt( i );
            if ( myItem.id == 505 and tonumber(myItem:getData("x")) == TargetPosition.x
                    and tonumber(myItem:getData("y")) == TargetPosition.y
                    and tonumber(myItem:getData("z")) == TargetPosition.z ) then
                return true, myItem, 0;
            end
        end

        -- backpack
        local theBackpack=User:getBackPack();
        if theBackpack==nil then
            return false,0,0;
        end
        local i = 0;
        local worked = true;
        local thisCont;
        repeat
            i = i + 1;
            worked,myItem,thisCont=theBackpack:viewItemNr(i);
            if worked then
                if ( myItem.id == 505 and tonumber(myItem:getData("x")) == TargetPosition.x
                    and tonumber(myItem:getData("y")) == TargetPosition.y
                    and tonumber(myItem:getData("z")) == TargetPosition.z ) then
                    return true, myItem, i;
                end
            end
        until not worked;
        return false,0,0;
    end

return M
