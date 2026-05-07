local common = require("base.common")

local M = {}

-- INSERT INTO scheduledscripts VALUES('scheduled.gaia', 10, 10, 'plantdrop');

function M.AddPlant(ItemID,Ground,Frequenz,Season,Datawert)
    table.insert(plnt,ItemID);
    table.insert(grnd,Ground);
    table.insert(freq,Frequenz);
    table.insert(seas,Season);
    table.insert(dataval,Datawert);
end

function M.Init()
    plnt = {};
    grnd = {};
    freq = {};
    seas = {};
    dataval= {};
    M.AddPlant(133,{1,1,1,1,4},1,{8,10,2,0},0);  -- Sonnenkraut
    M.AddPlant(134,{4},1,{6,1,5,10},0);          -- Vierbl�ttrige Einbeere
    M.AddPlant(135,{1},1,{10,6,3,0},0);          -- Gelbkraut
    M.AddPlant(136,{5},1,{4,3,10,7},0);          -- Wutbeere
    M.AddPlant(137,{3},1,{3,1,4,10},0);          -- Flammkelchbl�te
    M.AddPlant(138,{2,7},1,{2,2,9,5},0);         -- Nachtengelsbl�te
    M.AddPlant(140,{2},1,{10,2,7,3},0);          -- Donfblatt
    M.AddPlant(141,{4},1,{3,10,5,0},0);          -- Schwarze Distel
    M.AddPlant(142,{3},1,{2,3,10,6},0);          -- Sandbeere
    M.AddPlant(143,{4},1,{0,5,10,5},0);          -- Roter Holunder
    M.AddPlant(144,{5},1,{5,0,2,10},0);          -- Jungfernkraut
    M.AddPlant(145,{4},1,{10,6,3,0},0);          -- Heidebl�te
    M.AddPlant(146,{3},1,{6,5,10,5},0);          -- W�stenhimmelkapsel
    M.AddPlant(148,{5},1,{2,10,3,0},0);          -- Firnisbl�te
    M.AddPlant(152,{2,3,5,6},1,{4,4,4,4},0);     -- Lebenswurz
    M.AddPlant(153,{5},1,{10,4,1,0},0);          -- Fussblatt
    M.AddPlant(155,{7},1,{4,10,5,1},0);          -- Sibanac Blatt
    M.AddPlant(156,{3},1,{10,1,2,4},0);          -- Steppenfarn
	M.AddPlant(2696,{2,4,5},1,{6,4,8,1},80);	   -- Federn

	-- Pflanzen des DS-Systems mit SonderID in data
    M.AddPlant(133,{4},1,{8,10,6,0},9001); -- "Einbl�ttrige Vierbeere" / "oneleaved fourberry"
	M.AddPlant(134,{4},1,{6,0,6,10},9002); -- "Blaue Vogelbeere" / "blue birdsberry"
    M.AddPlant(135,{5},1,{10,6,0,8},9003); -- "Schwefelkraut" / "sulfur weed"
    M.AddPlant(136,{5},1,{0,6,10,7},9004); -- "Frommbeere" / "pious berry"
    M.AddPlant(137,{4},1,{6,0,6,10},9005); -- "Wasserbl�te" / "water blossom"
    M.AddPlant(138,{2},1,{0,6,10,6},9006); -- "Tagteufel" / "daydevil"
    M.AddPlant(140,{2},1,{10,6,0,6},9007); -- "Rauchblatt" / "reek leave"
    M.AddPlant(141,{5},1,{6,10,6,0},9008); -- "Graue Distel" / "grey thistle"
    M.AddPlant(142,{3},1,{0,6,10,6},9009); -- "W�stenbeere" / "desert berry"
    M.AddPlant(152,{4},1,{4,4, 4,4},9013); -- "Feuerwurz" / "fire root"
    M.AddPlant(144,{2},1,{6,0,6,10},9010); -- "Altweiberkraut" / "gossamer weed"
    M.AddPlant(145,{4},1,{10,6,0,6},9011); -- "Regenkraut" / "rain weed"
    M.AddPlant(146,{3},1,{6,10,6,0},9012); -- "Gottesblume" / "godsflower"
    M.AddPlant(148,{2},1,{6,10,6,0},9014); -- "Trugbl�te" / "con blossom"
    M.AddPlant(156,{2},1,{0,6,10,6},9015); -- "Wolfsfarn" / "wolverine fern"
    M.AddPlant(153,{4},1,{6,10,6,0},9016); -- "Wiesen-Rhabarber" / "meadow rhabarb"

    -- 0 alle / 1 Acker / 2 Wald / 3 Sand / 4 Wiese / 5 Fels / 6 Wasser / 7 Dreck

    anz_pflanzen = #plnt;
    anz_voraussetzungen = #grnd;
end

function M.plantdrop()
    if ( plnt==nil ) then
        M.Init();
    end

    local season=math.ceil( world:getTime("month") / 4 );
    season = common.Limit( season, 1, 4 );
    local spawn_amm = 15;
    if (season == 1) then --Fr�hling
        spawn_amm = 40;
    elseif (season == 2) then --Sommer
        spawn_amm = 40;
    elseif (season == 3) then --Herbst
        spawn_amm = 40;
    elseif (season == 4) then --Winter
        spawn_amm = 40;
    end

    for i=1,spawn_amm do
        ---- Pflanze aussuchen
        auswahl = math.random( anz_pflanzen );

        if( seas[ auswahl ][ season ] >= math.random(10) ) then
            success = true;
        else
            success = false;
        end

        if success then
            check = grnd[auswahl][math.random(1,#grnd[auswahl])]
            pflwert = dataval[auswahl]
            ---- Standortbestimmung
            newpos = position( math.random(0,1000), math.random(0,1000), 0 );
            ---- bodentile feststellen
            local bodenart = common.GetGroundType( world:getField(newpos):tile() );
            if ((bodenart == check) or (check == 0)) then

              -- --------------------------------------------------------------------------------------------------------
              -- 1. Qualifizierung : werte nach zufall anpassen, wertstellung auf alchemie-bed�rfnisse anpassen
              qualitaet = math.random(111,999)
              -- 2. Qualifizierung : wertstellung an Jahreszeiten und Boden anpassen

              -- 3. Qualifizierung: wertstellung unter Ber�cksichtigung von Umgebungskomponenten,. Wetter, Region etc.

              -- --------------------------------------------------------------------------------------------------------
                world:createItemFromId(plnt[auswahl],1,newpos,false,qualitaet,pflwert);
            end
        end
    end
end

return M
