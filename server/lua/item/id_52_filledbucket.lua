local areas = require("base.areas")
local M = {}

-- I_52.lua voller Wassereimer

-- UPDATE common SET com_script='item.id_52_filledbucket' WHERE com_itemid IN (52);

local common = require("base.common")
function M.UseItem( User, SourceItem, TargetItem, Counter, Param )


    -- Wasserflasche auffüllen
    if( TargetItem.id == 2498 ) then
		if(TargetItem.number > 1) then
			common.InformNLS(User, "Du kannst nur eine Flasche befüllen!", "You can only fill one bottle.");
			return;
		end
        world:makeSound( 10, User.pos )
        world:swap(TargetItem,2496,9);
    else
        if TargetItem.id ~= 0 then
			common.InformNLS(User,"platsch!","splash!");
			world:makeSound( 9, User.pos );
            -- Lagerfeuer ausmachen
            if (TargetItem.id == 12 or TargetItem.id == 359) then
                world:erase(TargetItem,1);
                -- Esse ausmachen
            elseif ( TargetItem.id == 2835 ) then
                world:swap(TargetItem,2836,3);
                -- test for seedlings
            else
                --User:inform( "calling sprouts" );
                M.MakeSprout( User, SourceItem, TargetItem )
			end
		else
			M.UseItemWithCharacter(User, SourceItem, User, Counter, Param);
		end
    end
      SourceItem.id = 51;
      SourceItem.data = 0;
      world:changeItem(SourceItem);
end  -- function

function M.UseItemWithCharacter (Character, SourceItem, TargetCharacter, Counter, Param )
    find, stinkEffekt =  TargetCharacter.effects:find(18);
    if find then 
	    found, stinkIndex = stinkEffekt:findValue("stinkIndex");
	    if found then
	         stinkEffekt:addValue("stinkIndex",1);
               world:makeSound( 9, Character.pos );
               SourceItem.id = 51;
               SourceItem.data = 0;
               world:changeItem(SourceItem);
	     
	     
	         common.InformNLS(TargetCharacter, "Du fühlt dich gleich viel sauberer.", "You feel much cleaner.");
	    end
    end
end

function M.MakeSprout( User, SourceItem, TargetItem )
    if seedList == nil then
        seedList = {  };
        seedList[ 15 ] = {139,4};              -- Apfelsetzling
        seedList[ 302 ] = {132,4};             -- Kirschsetzling
        seedList[ 149 ] = {150,2};             -- Tannensetzling
    end
    local seed = seedList[ TargetItem.id ];
    if( seed == nil ) then
        return
    end
    --User:inform( "found sprouts" );
    local Field = world:getField( TargetItem.pos )
    --User:inform( "cecking ground "..Field:tile() );
    local boden = common.GetGroundType( Field:tile() );

    --User:inform( "standing on "..boden );
    -- only on fields
    if( boden == seed[2] ) then
        --User:inform( "on field" );

        --User:inform( "skill "..skillwert.." chance "..chance );
        if M.BlockCheck(TargetItem.pos) then
	    -- Auf dem Trainingsfeld der Akademie wächst nichts
	    if areas.contains("academy_training_ground", TargetItem.pos) then
	        common.InformNLS( User,
                    "Die Erde hier ist völlig ausgebrannt...hier kann nichts wachsen.",
                    "The ground here is totaly burned...here can't grow anything." );
        else
            if M.CheckSucceed(User) then
                --User:inform( "deleting fruit "..TargetItem.id );
                world:swap(TargetItem,seed[1],3)
            end
	    end	
        else
        common.InformNLS( User, 
            "An dieser Stelle war nicht genug Sonnenlicht. Der Setzling geht ein.", 
            "There was not enough sunlight in this place. The seedling whithers." ); 
        end    
        User:learn( 2, "peasantry", 1, 100 )
    end
end

function M.CheckSucceed(User)
    Dex=User:increaseAttrib("dexterity",0);
    Pea=User:getSkill("peasantry");
    TryValue=100*(Pea/100)*(Dex/20);
    if (math.random(0,90)<TryValue) then
        return true
    else
        return false
    end
end

function M.BlockCheck(Posi)
    local testLoc;
    local TestItem;
    local block = 0;
    if Directions == nil then
        Directions = {
        { 1, 0, 3 }, { 1, 1, 2 }, { 0, 1, 3 }, { -1, 1, 2 },
        { -1, 0, 3 }, { -1, -1, 2 }, { 0, -1, 3 }, { 1, -1, 2 }
        };
    end
    for i, dir in pairs(Directions) do
        --User:inform( "checking field "..i );
        testLoc = position( Posi.x + dir[ 1 ], Posi.y + dir[ 2 ], Posi.z );
        if world:isItemOnField( testLoc ) then
            --User:inform( "block found at "..i );
            block = block + dir[ 3 ];
        end
    end
	local Field = world:getField(Posi);
	if(Field:countItems() > 1) then
		return false
	end
    if (block<5) then
        return true
    else
        return false
    end
end

return M
