-- ds_base_missile.lua
-- Druidensystem
-- Effekte f�r Wurfk�rper
-- Falk & Nitram

-- Liste der IDs mit Objekten aus Holz
-- WICHTIG: Liste MUSS aufsteigend geordnet sein

require("base.common")

local M = {}

local ListeObjHolz = {39,40,56,57,76,207,208,209,293,323,2782,2783,2784,2785,2786};

function M.fieldOfRadius1( posi )
    local actionfield = { };

    for x=-1,1 do
        for y=-1,1 do
            table.insert( actionfield, position( posi.x+x, posi.y+y, posi.z ) );
        end
    end
	return actionfield;
end

function M.fieldOfRadius2( posi )
    local actionfield = { };

    for x=-2,2 do
        for y=-2,2 do
            if math.abs(x) + math.abs(y) < 4 then
                table.insert( actionfield, position( posi.x+x, posi.y+y, posi.z ) );
            end
        end
    end
	return actionfield;
end

function M.createRabbits( targetArea )
    local rabbit;
    -- Bestimme lebenszeit der Hasen. Vernichtung Hasen erfolgt �ber die initiale Verwendung von Gift.
    -- Vergebene Giftpunkte werden Skaliert von 1000 (bei quality 100) bis 50 (bei quality 999)
    local lifeTime = base.common.Scale( 1000, 50, (Item.quality-100)*100/899 );

    for i, posi in pairs(targetArea) do
        if not world:isCharacterOnField( posi ) then
            world:createMonster(295,posi,-20);
            rabbit = world:getCharacterOnField( posi );
		rabbit:setPoisonValue( lifeTime );
            --rabbit:increasePoisonValue( lifeTime );
        end
    end

    -- Sollte sich die Verwendung von Gift bei diesem Effekt als nicht verwertbar herausstellen kann auch ein LTE auf die einzelnen Hasen gelegt werden.
end

function M.causeDamage( Item, DamagedArea, DamagedAttrib, ShieldAttribs, gfxid, sfxid, modifier )
    local Person;
    local AttribEffect;
    local Schaden;
    local Stiffness;

    if modifier == nil then
        modifier = 1;
    end

    for i, posi in pairs(DamagedArea) do
        if world:isCharacterOnField( posi ) then
            Person = world:getCharacterOnField( posi );

            -- Schaden bestimmt sich aus Item Qualit�t
            -- 1000HP - 9990HP
            local qual = Item.quality;
            if (qual > 999) then
                qual = ( qual % 1000 );
            end
            Schaden = 10 * qual;

            -- Ermittle Summe der als sch�tzend angegebene Attribute
            AttribEffect = 0;
            for k, attrib in pairs(ShieldAttribs) do
                AttribEffect = AttribEffect + Person:increaseAttrib( attrib, 0 );
            end
            -- Teile durch die Menge der angegebenen Attribute um den Mittelwert zu erhalten
            -- 0 - 20
            AttribEffect = AttribEffect / # ShieldAttribs ;

            -- Sch�tzender Einfluss der Attribute besteht sich aus dem Quadrat des Mittelwertes * 2
            -- 0 - 800
            AttribEffect = ( AttribEffect * AttribEffect * 2 );

            -- Sch�tzender AttributeEffekt vom Schaden abziehen
            Schaden = Schaden - AttribEffect;

            -- Steifheit der R�stung ermitteln. Je steifer die R�stung deszo mehr wird der Schaden durch die R�stung abgefangen
            -- 0 - 360
            Stiffness = base.common.GetStiffness( Person );

            -- Der dreifache Wert der R�stungssteifheit wird vom Schaden abgezogen ( max. -1080 )
            Schaden = Schaden - Stiffness * 3;

            -- Modifier f�r Attribute mit mehr als 10000 Punkten
            Schaden = math.ceil(Schaden * modifier);

            if ( Schaden > 0 ) then
                Person:increaseAttrib( DamagedAttrib, -Schaden );
            end
        end
        if ( gfxid ~= 0 ) then
            world:gfx( gfxid, posi );
        end
        if ( sfxid ~= 0 ) then
            world:makeSound( sfxid, posi );
        end
    end
end

function M.damageItemDura( Item, targetArea, gfxid, sfxid, modifier, ItemType )
    local Person;
    local slotItem;
    local found;
    local thisArmor;
    local thisWeapon;
    local ItemQual;
    local ItemDura;
    local minReduce;
    local maxReduce;

    local qual = Item.quality;
    if (qual > 999) then
        qual = ( qual % 1000 );
    end

    for i, posi in pairs(targetArea) do
        if world:isCharacterOnField( posi ) then
            Person = world:getCharacterOnField( posi );

            for slotCount = 1,11 do
                found = false;
                slotItem  = Person:getItemAt( slotCount );
                if ItemType == "armor" then
                    found, thisArmor = world:getArmorStruct( slotItem.id );
                elseif ItemType == "weapon" then
                    found, thisWeapon = world:getWeaponStruct( slotItem.id );
                elseif ItemType == "wood" then
                    found = M.checkWoody( slotItem.id, 0, # ListeObjHolz  );
                else
                    found = true;
                end

                if found then
                    ItemQual = math.floor( slotItem.quality / 100 );
                    ItemDura = slotItem.quality - ItemQual * 100;

                    minReduce = base.common.Scale(  30, -1, ItemQual * 11 );
                    maxReduce = base.common.Scale( 100, 50, ItemQual * 11 );

                    ItemDura = base.common.Limit( ItemDura - math.floor( base.common.Scale( minReduce, maxReduce, (qual-100)/8.99 ) )*modifier, 1, ItemDura );

                    slotItem.quality = ItemQual*100 + ItemDura;
                    world:changeItem( slotItem );
                end
            end
        end
        if ( gfxid ~= 0 ) then
            world:gfx( gfxid, posi );
        end
        if ( sfxid ~= 0 ) then
            world:makeSound( sfxid, posi );
        end
    end
end

function M.damageItemQual( Item, targetArea, gfxid, sfxid, modifier, ItemType )
    local Person;
    local slotItem;
    local found;
    local thisArmor;
    local thisWeapon;
    local ItemQual;
    local ItemDura;

    local qual = Item.quality;
    if (qual > 999) then
        qual = ( qual % 1000 );
    end

    for i, posi in pairs(targetArea) do
        if world:isCharacterOnField( posi ) then
            Person = world:getCharacterOnField( posi );

            for slotCount = 1,11 do
                found = false;
                slotItem  = Person:getItemAt( slotCount );
                if ItemType == "armor" then
                    found, thisArmor = world:getArmorStruct( slotItem.id );
                elseif ItemType == "weapon" then
                    found, thisWeapon = world:getWeaponStruct( slotItem.id );
                elseif ItemType == "wood" then
                    found = M.checkWoody( slotItem.id, 0, # ListeObjHolz  );
                else
                    found = true;
                end

                if found then
                    ItemQual = math.floor( slotItem.quality / 100 );
                    ItemDura = slotItem.quality - ItemQual * 100;

                    ItemQual = base.common.Limit( ItemDura - math.floor( base.common.Scale( 1, 9, (qual-100)/8.99 ) )*modifier, 1, 9 );

                    slotItem.quality = ItemQual*100 + ItemDura;
                    world:changeItem( slotItem );
                end
            end
        end
        if ( gfxid ~= 0 ) then
            world:gfx( gfxid, posi );
        end
        if ( sfxid ~= 0 ) then
            world:makeSound( sfxid, posi );
        end
    end
end

function M.checkWoody( id, lower, upper )
    if lower > upper then
        return false;
    end;
    local margin = math.floor((lower+upper)/2);
    if ListeObjHolz[margin] == id then
        return true;
    elseif ListeObjHolz[margin] < id then
        return M.checkWoody( id, margin+1, upper );
    else
        return M.checkWoody( id, lower, margin-1 );
    end
end

function M.checkHit( User, Item )
    local wetter     = world.weather.fog_density + world.weather.thunderstorm; -- 0 - 200
    local dexterity  = User:increaseAttrib( "dexterity", 0 ); -- 3 - 20
    local perception = User:increaseAttrib( "perception", 0 ); -- 3 - 20
    local Skill      = User:getSkill( "distance weapons" ); -- 0 - 100
    local distance   = User:distanceMetricToPosition( Item.pos ); -- 1 - 10

    local factor = Skill + dexterity * 2 + perception * 3; -- 15 - 300
    factor = factor - wetter; -- -185 - 300
    factor = factor - distance * distance; -- -285 - 299
    factor = ( factor + 100 ) / 2; -- -92,5 - 199,5

    factor = base.common.Limit( factor, 0, 100 );

    maxPosiModify = base.common.Scale( 5, 0, factor );

    if maxPosiModify == 0 then
        return Item.pos;
    end

    local phi = math.random()*2*math.pi;

    local modX = maxPosiModify * math.sin( phi );
    local modY = maxPosiModify * math.cos( phi );

    return position( Item.pos.x + math.floor( modX ), Item.pos.y + math.floor( modY ), Item.pos.z );
end

-- Z�hle alle Charakter auf einem bestimmten Gebiet
function M.countCharacters( targetPosis )
    local cnt = 0;
    for i, posi in pairs(targetPosis) do
        if world:isCharacterOnField( posi ) then
            cnt = cnt + 1;
        end
    end
    return cnt;
end

-- Feststellen wo es Charaktere gibt und einen ausw�hlen
function M.selectCharacter( targetPosis )
    local finePosis = {};
    for i, posi in pairs(targetPosis) do
        if world:isCharacterOnField( posi ) then
            table.insert( finePosis, posi );
        end
    end

    if # finePosis  == 0 then
        return false;
    end

    return finePosis[ math.random( 1, # finePosis  ) ];
end

---- HITPOINT WURFBOMBEN ----

-- Voller Hitpoint-Schaden auf 1er-Feld
function M.effect_66475155(User,Item)
    M.causeDamage( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, "hitpoints", { "strength", "constitution" }, 12, 5 );
end

-- Voller Hitpoint-Schaden auf 9er-Feld
function M.effect_93531588(User,Item)
    M.causeDamage( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), "hitpoints", { "strength", "constitution" }, 12, 5 );
end

-- Aufgeteilter Hitpoint-Schaden auf 9er Feld
function M.effect_84254555(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.causeDamage( Item, hitArea, "hitpoints", { "strength", "constitution" }, 12, 5, 1/M.countCharacters( hitArea ) );
end

-- Voller Hitpoint-Schaden auf 21er-Feld
function M.effect_75568356(User,Item)
    M.causeDamage( Item, M.fieldOfRadius2( M.checkHit( User, Item ) ), "hitpoints", { "strength", "constitution" }, 12, 5 );
end

-- Aufgeteilter Hitpoint-Schaden auf 21er Feld
function M.effect_36835636(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.causeDamage( Item, hitArea, "hitpoints", { "strength", "constitution" }, 12, 5, 1/M.countCharacters( hitArea ) );
end


---- MANA WURFBOMBEN ----

-- Voller Mana-Schaden auf 1er-Feld
function M.effect_24968253(User,Item)
    M.causeDamage( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, "mana", { "willpower", "essence" }, 4, 5 );
end

-- Voller Mana-Schaden auf 9er-Feld
function M.effect_16359531(User,Item)
    M.causeDamage( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), "mana", { "willpower", "essence" }, 4, 5 );
end

-- Aufgeteilter Mana-Schaden auf 9er Feld
function M.effect_71943574(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.causeDamage( Item, hitArea, "mana", { "willpower", "essence" }, 4, 5, 1/M.countCharacters( hitArea ) );
end

-- Voller Mana-Schaden auf 21er-Feld
function M.effect_47564545(User,Item)
    M.causeDamage( Item, M.fieldOfRadius2( M.checkHit( User, Item ) ), "mana", { "willpower", "essence" }, 4, 5 );
end

-- Aufgeteilter Mana-Schaden auf 21er Feld
function M.effect_33421656(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.causeDamage( Item, hitArea, "mana", { "willpower", "essence" }, 4, 5, 1/M.countCharacters( hitArea ) );
end


---- FOODLEVEL WURFBOMBEN ----

-- Voller Sattmacher-Schaden auf 1er-Feld
function M.effect_63155452(User,Item)
    M.causeDamage( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, "foodlevel", { "constitution", "agility" }, 5, 5, 6 );
end

-- Voller Sattmacher-Schaden auf 9er-Feld
function M.effect_21915579(User,Item)
    M.causeDamage( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), "foodlevel", { "constitution", "agility" }, 5, 5, 6 );
end

-- Aufgeteilter Sattmacher-Schaden auf 9er Feld
function M.effect_64312656(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.causeDamage( Item, hitArea, "foodlevel", { "constitution", "agility" }, 4, 5, 6/M.countCharacters( hitArea ) );
end

-- Voller Sattmacher-Schaden auf 21er-Feld
function M.effect_87783632(User,Item)
    M.causeDamage( Item, M.fieldOfRadius2( M.checkHit( User, Item ) ), "foodlevel", { "constitution", "agility" }, 4, 5, 6 );
end

-- Aufgeteilter Sattmacher-Schaden auf 21er Feld
function M.effect_62358491(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.causeDamage( Item, hitArea, "foodlevel", { "constitution", "agility" }, 4, 5, 6/M.countCharacters( hitArea ) );
end

---- MONSTER UM DEN WEG ZU BLOCKIEREN ----

--Hasenbarriere auf 9er-Feld
function M.effect_84613666(User,Item)
    M.createRabbits( M.fieldOfRadius1( M.checkHit( User, Item ) ) );
end

--Hasenbarriere auf 21er-Feld
function M.effect_29732752(User,Item)
    M.createRabbits( M.fieldOfRadius2( M.checkHit( User, Item ) ) );
end

---- SCHADEN AUF R�STUNGEN - HALTBARKEIT ----

-- Voller Haltbarkeits-Schaden auf R�stungen auf 1er Feld
function M.effect_55938556(User,Item)
    M.damageItemDura( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, 4, 5, 1, "armor" );
end

--Voller Haltbarkeits-Schaden auf R�stungen auf 9er Feld
function M.effect_43245354(User,Item)
    M.damageItemDura( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "armor" );
end

--Aufgeteilter Haltbarkeits-Schaden auf R�stungen auf 9er Feld
function M.effect_95257533(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.damageItemDura( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "armor" );
end

--Voller Haltbarkeits-Schaden auf R�stungen auf 21er Feld
function M.effect_59159412(User,Item)
    M.damageItemDura( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "armor" );
end

--Aufgeteilter Haltbarkeits-Schaden auf R�stungen auf 21er Feld
function M.effect_36557188(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.damageItemDura( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "armor" );
end

---- SCHADEN AUF R�STUNGEN - QUALIT�T ----

--Voller Qualit�ts-Schaden auf R�stungen auf 1er Feld
function M.effect_98538617(User,Item)
    M.damageItemQual( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, 4, 5, 1, "armor" );
end

--Voller Qualit�ts-Schaden auf R�stungen auf 9er Feld
function M.effect_79684787(User,Item)
    M.damageItemQual( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "armor" );
end

--Aufgeteilter Qualit�ts-Schaden auf R�stungen auf 9er Feld
function M.effect_32484266(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.damageItemQual( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "armor" );
end

--Voller Qualit�ts-Schaden auf R�stungen auf 21er Feld
function M.effect_96261935(User,Item)
    M.damageItemQual( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "armor" );
end

--Aufgeteilter Qualit�ts-Schaden auf R�stungen auf 21er Feld
function M.effect_26372612(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.damageItemQual( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "armor" );
end


---- SCHADEN AUF WAFFEN - HALTBARKEIT ----

--Voller Haltbarkeits-Schaden auf Waffen auf 1er Feld
function M.effect_56548394(User,Item)
    M.damageItemDura( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, 4, 5, 1, "weapon" );
end

--Voller Haltbarkeits-Schaden auf Waffen auf 9er Feld
function M.effect_81876627(User,Item)
    M.damageItemDura( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "weapon" );
end

--Aufgeteilter Haltbarkeits-Schaden auf Waffen auf 9er Feld
function M.effect_86656358(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.damageItemDura( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "weapon" );
end

--Voller Haltbarkeits-Schaden auf Waffen auf 21er Feld
function M.effect_77254231(User,Item)
    M.damageItemDura( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "weapon" );
end

--Aufgeteilter Haltbarkeits-Schaden auf Waffen auf 21er Feld
function M.effect_32185872(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.damageItemDura( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "weapon" );
end

---- SCHADEN AUF WAFFEN - QUALIT�T ----

--Voller Qualit�ts-Schaden auf Waffen auf 1er Feld
function M.effect_91357421(User,Item)
    M.damageItemQual( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, 4, 5, 1, "weapon" );
end

--Voller Qualit�ts-Schaden auf Waffen auf 9er Feld
function M.effect_52761593(User,Item)
    M.damageItemQual( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "weapon" );
end

--Aufgeteilter Qualit�ts-Schaden auf Waffen auf 9er Feld
function M.effect_19123643(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.damageItemQual( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "weapon" );
end

--Voller Qualit�ts-Schaden auf Waffen auf 21er Feld
function M.effect_35471525(User,Item)
    M.damageItemQual( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "weapon" );
end

--Aufgeteilter Qualit�ts-Schaden auf Waffen auf 21er Feld
function M.effect_32812622(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.damageItemQual( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "weapon" );
end

---- SCHADEN AUF HOLZITEMS - HALTBARKEIT ----

--Voller Haltbarkeits-Schaden auf Holzitems auf 1er Feld
function M.effect_12836431(User,Item)
    M.damageItemDura( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, 4, 5, 1, "wood" );
end

--Voller Haltbarkeits-Schaden auf Holzitems auf 9er Feld
function M.effect_43185342(User,Item)
    M.damageItemDura( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "wood" );
end

--Aufgeteilter Haltbarkeits-Schaden auf Holzitems auf 9er Feld
function M.effect_57771997(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.damageItemDura( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "wood" );
end

--Voller Haltbarkeits-Schaden auf Holzitems auf 21er Feld
function M.effect_13245638(User,Item)
    M.damageItemDura( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "wood" );
end

--Aufgeteilter Haltbarkeits-Schaden auf Holzitems auf 21er Feld
function M.effect_88343542(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.damageItemDura( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "wood" );
end

---- SCHADEN AUF HOLZITEMS - QUALIT�T ----

--Voller Qualit�ts-Schaden auf Holzitems auf 1er Feld
function M.effect_67589591(User,Item)
    M.damageItemQual( Item, { M.selectCharacter( M.fieldOfRadius1( M.checkHit( User, Item ) ) ) }, 4, 5, 1, "wood" );
end

--Voller Qualit�ts-Schaden auf Holzitems auf 9er Feld
function M.effect_96566994(User,Item)
    M.damageItemQual( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "wood" );
end

--Aufgeteilter Qualit�ts-Schaden auf Holzitems auf 9er Feld
function M.effect_13983419(User,Item)
    local hitArea = M.fieldOfRadius1( M.checkHit( User, Item ) );
    M.damageItemQual( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "wood" );
end

--Voller Qualit�ts-Schaden auf Holzitems auf 21er Feld
function M.effect_42218944(User,Item)
    M.damageItemQual( Item, M.fieldOfRadius1( M.checkHit( User, Item ) ), 4, 5, 1, "wood" );
end

--Aufgeteilter Qualit�ts-Schaden auf Holzitems auf 21er Feld
function M.effect_69657293(User,Item)
    local hitArea = M.fieldOfRadius2( M.checkHit( User, Item ) );
    M.damageItemQual( Item, hitArea, 4, 5, 1/M.countCharacters( hitArea ), "wood" );
end


--[[
function M.effect_58731981(User,Item) --globale Wetterver�nderung
    return true; -- Script nicht fertig, funktion sofort abbrechen

    m_Weather = world.weather;
    m_Weather.cloud_density=newClouds;
    m_Weather.fog_density=newFog;
    m_Weather.wind_dir=newWindDir;
    m_Weather.gust_strength=newGust
    m_Weather.percipitation_strength=newRain;
    m_Weather.percipitation_type=newPerTyp;
    m_Weather.thunderstorm=newThunder;
    m_Weather.temperature=newTemp;
    logWeather(m_Weather);
    world:setWeather(m_Weather);
end



function M.effect_59595521(User,Item) --Matschbarriere auf 9er-Feld
    actionfield = fieldOfNine(Item)
    for i = 1,9 do
        --Bodentiles �ndern
        local field = world:getField(actionfield[i])
        local tileID= field.tile
        if tileID == 11 then --Wiese     !!!! id pr�fen
            world:changeTile(4,actionfield[i])  --Kontrolle: screen update?
            world:sendMapUpdate(actionfield[i],5)
            -- Dieser Effekt sollte nun umgebaut werden zu einem LTE 327 (Zeit vergeht, Effekt aufheben.)
        end
    end
end





function M.effect_42718255(User,Item) --Einen Effekt vort�uschen

end

function M.effect_25269755(User,Item)

end

return M

--@ nitram: ich bin beeindruckt

--dura auf Waffen 9er Feld
--dura auf Holz 9er Feld
--dura auf Metall 9er Feld
--das Ganze jeweils f�r 1er Feld
--das Ganze jeweils f�r Quality

-- Die Effekt-Nummer kann willk�rlich achtstellig sein (ohne Ziffer 0), die Anpassung erfolgt dann in ds_327_blaue_Flasache.lua
-- Datawerte aus Zufallsgenerator
--
--
--

--Zum Vort�uschen eines Effektes: Hier soll ein Dummy des Casters erscheinen, also ein Monster gleicher Rasse, das sich nach einer weile wieder selbst zerst�rt. Sinn soll sein, einen Gegner zu verwirren, wen er jetzt angreifen muss.
--Eine Steigerung w�re dann ein Dummy, der den Gegner angreift.

--Zu Wettereffekten: Jeweils ein Effekt f�r je eine Wetter�nderung: also 1 Wurfbombe f�r Nebel, eine f�r Regen etc. Dauer gem�� Quality des Trankes (LTE)
--Man k�nnte auch die Intensit�t �ber quality steuern, zb aquality = 345 ==> Intensit�t = 3 (1-9) und Dauer = 45 (11-99)

--Zur Aufhebung der Matschbarriere folgen noch Vorschl�ge
]]
