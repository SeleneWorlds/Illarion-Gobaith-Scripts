local M = {}

-- Food script
local common = require("base.common")

local Registries = require("selene.registries")
local furtunecookies = require("content.furtunecookies")

-- Racial arrays use race ID + 1; index 10 covers all other races.
local function findFood(id)
    local item = Registries.findByMetadata("illarion:items", "id", id)
    return item and item:getField("food")
end

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
	-- Item not on map!
	if SourceItem.wear == 255 then
		return;
	end
	local food = findFood(SourceItem.id);
	if not food then
		User:inform("unknown food item ");
		return;
	end
	-- define user's race (+1 for valid table index), non-playable races are set to 10
	local race = math.min(User:get_race()+1, 10);
	-- not eatable for user's race
	if food.uneatable[race] then
		return;
	end
	
	-- user is not fighting
	if not User.attackmode then
		
		-- known food item?
		if (food ~= nil ) then
			-- consume food
			local poison = food.poison;
			local foodLevel = User:increaseAttrib("foodlevel",0);
			-- adjust food value for small races
			local foodVal;
			if ( User:get_race() == 7 ) then                                    -- fairy (food * 1.8)
				foodVal = math.ceil( food.value * 1.8 )
			elseif ( User:get_race() == 2 ) or ( User:get_race() == 6 ) or ( User:get_race() == 8 ) then    -- halfling or gnome and goblin (food * 1.4)
				foodVal = math.ceil( food.value * 1.4 )
			else                                                                -- other races
				foodVal = food.value;
			end
			foodLevel = foodLevel + foodVal;
			
			local domMalus = 0;
			if not poison then
				-- if ate too much, domMalus is negative. See diet system below for more.
				-- grant a buffer of half of the actual food value
				domMalus = ((60000 + (0.5*foodVal) - foodLevel) / 60000);
			else
				-- set poison value
				User:setPoisonValue( common.Limit( (User:getPoisonValue() + poison) , 0, 10000) );
				--User:increasePoisonValue(poison);
			end
			
			world:erase(SourceItem,1);
			
			-- create leftovers
			if( food.leftover ~= nil ) then
				if( math.random( 50 ) <= 1 ) then
					common.InformNLS( User, "Das alte Geschirr ist nicht mehr brauchbar.", "The old dishes are no longer usable.");
				else
					local leftover = assert(Registries.findByName("illarion:items", food.leftover));
                    User:createItem( leftover:getMetadata("id"), 1, 3,0, 33);
				end
			end
			-- inform the player
			if poison then
				common.TempInformNLS(User,
				"Du fühlst dich krank und etwas benommen.",
				"You feel sick and a little dizzy.");
			elseif (domMalus < 0) then
				common.TempInformNLS( User,
				"Du bekommst kaum noch was runter und dir wird schlecht. Dies schadet sicherlich deinem Körper.",
				"You hardly manage to eat something more and get sick! This surely harms your body.");
				-- check for newbie state
				if not (User:getQuestProgress(2) > 0) and not (User:increaseAttrib("hitpoints",0) < 2000) then
					User:increaseAttrib("hitpoints",-1000);
				end
				foodLevel = foodLevel - 10000;
			elseif  (foodLevel > 55000) then
				common.TempInformNLS( User,
				"Nur mit Mühe kannst du dir noch etwas hinunter zwingen.",
				"You hardly manage to eat something more.");
			elseif  (foodLevel > 50000) then
				common.TempInformNLS( User,
				"Du bist sehr satt.",
				"You have had enough.");
			elseif  (foodLevel > 40000) then
				common.TempInformNLS( User,
				"Du bist satt",
				"You are stuffed");
			elseif  (foodLevel > 30000) then
				common.TempInformNLS( User,
				"Du fühlst dich noch etwas hungrig.",
				"You still feel a little hungry.");
			elseif  (foodLevel > 20000) then
				common.TempInformNLS( User,
				"Du hast noch immer Hunger.",
				"You are still hungry.");
			elseif  (foodLevel > 5000) then
				common.TempInformNLS( User,
				"Dein Magen schmerzt noch immer vor Hunger.",
				"Your stomach still hurts because of your hunger.");
			end
			-- Glückskeks!
			--
			if (SourceItem.id == 453) then
                if (math.random(1,100)==1) then
                    local deText, enText = furtunecookies.cookie();
                    common.InformNLS( User,
                    "Du findest ein Stück Papier in dem Keks: \""..deText.."\"",
                    "You find a piece of paper inside the cookie: \""..enText.."\"");
                end
            end
			-- refill user's food level
			foodLevel = math.max(0,math.min(60000,foodLevel));
			local FoodToAdd = foodLevel - User:increaseAttrib("foodlevel",0);
			while true do
				User:increaseAttrib("foodlevel",math.min(10000,FoodToAdd));
				FoodToAdd = FoodToAdd - math.min(10000,FoodToAdd);
				if (FoodToAdd == 0) then
					break;
				end
			end
			
			---------- diet system ----------
			local foundEffect,dietEffect=User.effects:find(12);
			local found1, found2, dom, constModOld;
			-- check for diet LTE
			if not foundEffect then
				dietEffect=CLongTimeEffect(12,2147483640);
				User.effects:addEffect(dietEffect);
				found1 = true;
				found2 = true;
				dom    = 0;
				constModOld = 0;
			else
				found1,dom = dietEffect:findValue("dom");
				found2,constModOld = dietEffect:findValue("constMod");
			end
			-- if something's missing, restore as good as possible
			if not found1 or not found2 then
				if found1 then
					if dom < 2500 then
						constModOld = 0;
					elseif dom < 7500 then
						constModOld = 1;
					else
						constModOld = 2;
					end
				elseif found2 then
					if constModOld <= 0 then
						dom = 0;
					elseif constModOld == 1 then
						dom = 2500;
					else
						dom = 7500;
					end
				else
					User:inform("Error: Diet values not found. Reset to 0");
					dom = 0;
					constModOld = 0;
				end
			end
			
			local domRange, foodMod, dietMod, dietType;
			if (dom<=2500) then domRange=0 end
			if (dom>2500 and dom<7500) then domRange=1 end
			if (dom>=7500) then domRange=2 end
			foodMod=food.value/60000;

			dietMod = food.diet + food.racialDiet[race];

			if dietMod>=0 then
				if math.random(50)<=dietMod then
					dietType=2;
					if dietMod < 50 then
						dietMod = (dietMod + 75)/2;
					end
					dietMod=dietMod/100;
				else
					dietType=1;
					dietMod=(dietMod+50)/100;
				end
			else
				dietType=0;
				dietMod=(dietMod-50)/-100;
			end

			-- calculate DoM Modifier according to diet type and current DoM
			local domMod;
			if (dietType==0) then											-- Free Food
				if (domRange==0) then domMod=math.ceil(foodMod*dietMod*-115)
				elseif (domRange==1) then domMod=math.ceil(foodMod*dietMod*-350)
				elseif (domRange==2) then domMod=math.ceil(foodMod*dietMod*-700)
				end
			elseif (dietType==1) then										-- Cooked Food
				if (domRange==0) then domMod=math.ceil(foodMod*dietMod*350)
				elseif (domRange==2) then domMod=math.ceil(foodMod/dietMod*-350)
				elseif (dom<5000) then domMod=math.ceil(foodMod*dietMod*115)
				elseif (dom>5000) then domMod=math.ceil(foodMod*dietMod*-115)
				else domMod=0
				end
			elseif (dietType==2) then										-- High Quality Food
				if (domRange==0) then domMod=math.ceil(foodMod*dietMod*700)
				elseif (domRange==1) then domMod=math.ceil(foodMod*dietMod*350)
				elseif (domRange==2) then domMod=math.ceil(foodMod*dietMod*115)
				end
			else
				User:inform("Error: Unknown diet type. Please report bug.");
				return;
			end

			-- if ate too much, decrease surely the dom
			if (domMalus<0) then
				domMod = math.min(0,domMod) + math.ceil(domMalus*350);
			end

			dom=dom+domMod;

			dom = math.max( 0, math.min( 10000, dom ) );
			constModOld = math.max(0, math.min(constModOld, 2));
			local constMod = constModOld;
			if (dom>=0 and dom<2500) then
				constMod=0;
				if (constModOld < constMod) then
					common.InformNLS(User,
					"Durch deine ausgewogene Ernährung erlangt dein Körper seine gewohnte Verfassung wieder.",
					"Due to your balanced diet your body regains its usual condition.");
				elseif (constModOld > constMod) then
					common.InformNLS(User,
					"Durch deine nur gewöhnliche Ernährung kann dein Körper seine gute Verfassung nicht halten.",
					"Due to your commoners' diet your body cannot retain its good condition.");
				end
			elseif (dom>=2500 and dom<7500) then
				constMod=1;
				if (constModOld < constMod) then
					common.InformNLS(User,
					"Durch deine großartige Ernährung erlangt dein Körper eine gute Verfassung.",
					"Due to your great diet your body gains a good condition.");
				elseif (constModOld > constMod) then
					common.InformNLS(User,
					"Da du deine Ernährung etwas vernachlässigt hast, kann dein Körper seine großartige Verfassung nicht halten.",
					"As you have slightly neglected your dietary choices, your body can´t retain its great condition.");
				end
			elseif (dom>=7500 and dom<=10000) then
				constMod=2;
				if (constModOld < constMod) then
					common.InformNLS(User,
					"Durch deine perfekte Ernährung erlangt dein Körper eine großartige Verfassung.",
					"Due to your perfect diet your body gains a great condition.");
				end
			else
				User:inform("Error: DoM not in range. Please report bug. Set to normal value again.");
				dom = 0;
			end
			if constModOld ~= constMod then
				User:setAttrib("constitution",User:increaseAttrib("constitution",0)+(constMod-constModOld));
				if (User:increaseAttrib("constitution",0)<1) then
					User:setAttrib("constitution",1);
				end
			end
			dietEffect:addValue("constMod",constMod);
			dietEffect:addValue("dom",dom);
			-------- end diet system --------
		else
			User:inform("unknown food item ");
		end
	else
		common.TempInformNLS( User,
			"Du kannst nicht während eines Kampfes essen.",
			"You cannot eat during a fight.");
	end
end

return M
