local M = {}

local GOD_NONE     =  0
local GOD_USHARA   =  1
local GOD_BRAGON   =  2
local GOD_ELDAN    =  3
local GOD_TANORA   =  4
local GOD_FINDARI  =  5
local GOD_NARGUN   =  6
local GOD_ELARA    =  7
local GOD_ADRON    =  8
local GOD_OLDRA    =  9
local GOD_CHERGA   = 10
local GOD_MALACHIN = 11
local GOD_IRMOROM  = 12
local GOD_SIRANI   = 13
local GOD_ZHAMBRA  = 14
local GOD_RONAGAN  = 15
local GOD_MOSHRAN  = 16
local GOD_THEFIVE  = 17
local GOD_THEDEVS  = 99

M.GOD_NONE = GOD_NONE
M.GOD_USHARA = GOD_USHARA
M.GOD_BRAGON = GOD_BRAGON
M.GOD_ELDAN = GOD_ELDAN
M.GOD_TANORA = GOD_TANORA
M.GOD_FINDARI = GOD_FINDARI
M.GOD_NARGUN = GOD_NARGUN
M.GOD_ELARA = GOD_ELARA
M.GOD_ADRON = GOD_ADRON
M.GOD_OLDRA = GOD_OLDRA
M.GOD_CHERGA = GOD_CHERGA
M.GOD_MALACHIN = GOD_MALACHIN
M.GOD_IRMOROM = GOD_IRMOROM
M.GOD_SIRANI = GOD_SIRANI
M.GOD_ZHAMBRA = GOD_ZHAMBRA
M.GOD_RONAGAN = GOD_RONAGAN
M.GOD_MOSHRAN = GOD_MOSHRAN
M.GOD_THEFIVE = GOD_THEFIVE
M.GOD_THEDEVS = GOD_THEDEVS

M.GOD_LIST = {GOD_NARGUN,GOD_ELARA,GOD_ADRON,GOD_OLDRA,GOD_CHERGA,GOD_MALACHIN,
			GOD_IRMOROM,GOD_SIRANI,GOD_ZHAMBRA,GOD_RONAGAN,GOD_MOSHRAN,GOD_THEFIVE};

M.GOD_EN = {
    [GOD_USHARA]   = "Ushara",
    [GOD_BRAGON]   = "Br�gon",
    [GOD_ELDAN]    = "Eldan",
    [GOD_TANORA]   = "Tanora",
    [GOD_FINDARI]  = "Findari",
    [GOD_NARGUN]   = "Narg�n",
    [GOD_ELARA]    = "Elara",
    [GOD_ADRON]    = "Adron",
    [GOD_OLDRA]    = "Oldra",
    [GOD_CHERGA]   = "Cherga",
    [GOD_MALACHIN] = "Malach�n",
    [GOD_IRMOROM]  = "Irmorom",
    [GOD_SIRANI]   = "Sirani",
    [GOD_ZHAMBRA]  = "Zhambra",
    [GOD_RONAGAN]  = "Ronagan",
    [GOD_MOSHRAN]  = "Moshran",
    [GOD_THEFIVE]  = "Five",
    [GOD_THEDEVS]  = "Developers",
}

M.GOD_DE = {
    [GOD_USHARA]   = "Ushara",
    [GOD_BRAGON]   = "Br�gon",
    [GOD_ELDAN]    = "Eldan",
    [GOD_TANORA]   = "Tanora",
    [GOD_FINDARI]  = "Findari",
    [GOD_NARGUN]   = "Narg�n",
    [GOD_ELARA]    = "Elara",
    [GOD_ADRON]    = "Adron",
    [GOD_OLDRA]    = "Oldra",
    [GOD_CHERGA]   = "Cherga",
    [GOD_MALACHIN] = "Malach�n",
    [GOD_IRMOROM]  = "Irmorom",
    [GOD_SIRANI]   = "Sirani",
    [GOD_ZHAMBRA]  = "Zhambra",
    [GOD_RONAGAN]  = "Ronagan",
    [GOD_MOSHRAN]  = "Moshran",
    [GOD_THEFIVE]  = "F�nf",
    [GOD_THEDEVS]  = "Entwickler",
}

M.PRAYER_CONVERSION = {
	{skill = "Healing",
		gText = "bitte (.+) heilung",
		eText = "please (.+) healing"
	}
}

M.PRAYER_MASS = {
	[GOD_NARGUN]   = {gText = "preiset narg[u�]n, gott des chaos",
						eText = "praise narg[u�]n, god of chaos"},
    [GOD_ELARA]    = {gText = "preiset",
						eText = "praise"},
    [GOD_ADRON]    = {gText = "preiset",
						eText = "praise"},
    [GOD_OLDRA]    = {gText = "preiset",
						eText = "praise"},
    [GOD_CHERGA]   = {gText = "preiset",
						eText = "praise"},
    [GOD_MALACHIN] = {gText = "preiset",
						eText = "praise"},
    [GOD_IRMOROM]  = {gText = "preiset",
						eText = "praise"},
    [GOD_SIRANI]   = {gText = "preiset",
						eText = "praise"},
    [GOD_ZHAMBRA]  = {gText = "preiset",
						eText = "praise"},
    [GOD_RONAGAN]  = {gText = "preiset",
						eText = "praise"},
    [GOD_MOSHRAN]  = {gText = "preiset",
						eText = "praise"},
    [GOD_THEFIVE]  = {gText = "preiset",
						eText = "praise"},
}

M.PRAYER_FOLLOWER = {
	[GOD_NARGUN]   = {gText = "segne mich nargun",
						eText = "bless me nargun"},
    [GOD_ELARA]    = {gText = "segne mich",
						eText = "bless me"},
    [GOD_ADRON]    = {gText = "segne mich",
						eText = "bless me"},
    [GOD_OLDRA]    = {gText = "segne mich",
						eText = "bless me"},
    [GOD_CHERGA]   = {gText = "segne mich",
						eText = "bless me"},
    [GOD_MALACHIN] = {gText = "segne mich",
						eText = "bless me"},
    [GOD_IRMOROM]  = {gText = "segne mich",
						eText = "bless me"},
    [GOD_SIRANI]   = {gText = "segne mich",
						eText = "bless me"},
    [GOD_ZHAMBRA]  = {gText = "segne mich",
						eText = "bless me"},
    [GOD_RONAGAN]  = {gText = "segne mich",
						eText = "bless me"},
    [GOD_MOSHRAN]  = {gText = "segne mich",
						eText = "bless me"},
    [GOD_THEFIVE]  = {gText = "segnet mich",
						eText = "bless me"},
}

M.PRAYER_PRIEST = {
	[GOD_NARGUN]   = {gText = "segne mich erneut nargun",
						eText = "bless me again nargun"},
    [GOD_ELARA]    = {gText = "segne mich",
						eText = "bless me"},
    [GOD_ADRON]    = {gText = "segne mich",
						eText = "bless me"},
    [GOD_OLDRA]    = {gText = "segne mich",
						eText = "bless me"},
    [GOD_CHERGA]   = {gText = "segne mich",
						eText = "bless me"},
    [GOD_MALACHIN] = {gText = "segne mich",
						eText = "bless me"},
    [GOD_IRMOROM]  = {gText = "segne mich",
						eText = "bless me"},
    [GOD_SIRANI]   = {gText = "segne mich",
						eText = "bless me"},
    [GOD_ZHAMBRA]  = {gText = "segne mich",
						eText = "bless me"},
    [GOD_RONAGAN]  = {gText = "segne mich",
						eText = "bless me"},
    [GOD_MOSHRAN]  = {gText = "segne mich",
						eText = "bless me"},
    [GOD_THEFIVE]  = {gText = "segnet mich",
						eText = "bless me"},
}

M.ALTARS = {
	[GOD_NARGUN]	= position(-69,-100,0),
    [GOD_ELARA]    	= position(0,0,0),
    [GOD_ADRON]    	= position(0,0,0),
    [GOD_OLDRA]    	= position(0,0,0),
    [GOD_CHERGA]   	= position(0,0,0),
    [GOD_MALACHIN] 	= position(0,0,0),
    [GOD_IRMOROM]  	= position(0,0,0),
    [GOD_SIRANI]   	= position(0,0,0),
    [GOD_ZHAMBRA]  	= position(0,0,0),
    [GOD_RONAGAN]  	= position(0,0,0),
    [GOD_MOSHRAN]	= position(0,0,0),
    [GOD_THEFIVE]  	= position(0,0,0)
}

M.ITEMS_FOLLOWER = {
	[GOD_NARGUN]	= {{id = 2, number = 1}},
    [GOD_ELARA]    	= {{id = 2, number = 1}},
    [GOD_ADRON]    	= {{id = 2, number = 1}},
    [GOD_OLDRA]    	= {{id = 2, number = 1}},
    [GOD_CHERGA]   	= {{id = 2, number = 1}},
    [GOD_MALACHIN] 	= {{id = 2, number = 1}},
    [GOD_IRMOROM]  	= {{id = 2, number = 1}},
    [GOD_SIRANI]   	= {{id = 2, number = 1}},
    [GOD_ZHAMBRA]  	= {{id = 2, number = 1}},
    [GOD_RONAGAN]  	= {{id = 2, number = 1}},
    [GOD_MOSHRAN]	= {{id = 2, number = 1}},
    [GOD_THEFIVE]  	= {{id = 2, number = 1}}
}

M.ITEMS_PRIEST = {
	[GOD_NARGUN]	= {{id = 2, number = 1}},
    [GOD_ELARA]    	= {{id = 2, number = 1}},
    [GOD_ADRON]    	= {{id = 2, number = 1}},
    [GOD_OLDRA]    	= {{id = 2, number = 1}},
    [GOD_CHERGA]   	= {{id = 2, number = 1}},
    [GOD_MALACHIN] 	= {{id = 2, number = 1}},
    [GOD_IRMOROM]  	= {{id = 2, number = 1}},
    [GOD_SIRANI]   	= {{id = 2, number = 1}},
    [GOD_ZHAMBRA]  	= {{id = 2, number = 1}},
    [GOD_RONAGAN]  	= {{id = 2, number = 1}},
    [GOD_MOSHRAN]	= {{id = 2, number = 1}},
    [GOD_THEFIVE]  	= {{id = 2, number = 1}}
}

-- magic flags
-- category runes
M.RUNE_HEALING = 1;
-- other runes
M.RUNE_SMALL = 32;

--[[
DEFAULT = {
	[GOD_NARGUN]	= 
    [GOD_ELARA]    	= 
    [GOD_ADRON]    	= 
    [GOD_OLDRA]    	= 
    [GOD_CHERGA]   	= 
    [GOD_MALACHIN] 	= 
    [GOD_IRMOROM]  	= 
    [GOD_SIRANI]   	= 
    [GOD_ZHAMBRA]  	= 
    [GOD_RONAGAN]  	= 
    [GOD_MOSHRAN]	= 
    [GOD_THEFIVE]  	= 
}
]]

return M
