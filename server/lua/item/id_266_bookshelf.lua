local M = {}
local Libraries

-- Side note: "BS" = Bookshelf
-- Bookshelves contain a list of positions of bookshelves and a list of books

-- UPDATE common SET com_script='item.id_266_bookshelf' WHERE com_itemid IN (266, 267);

function M.InitLibraries()

    Libraries = {}

    -- Shelves with misc books (was previously about crafts)
    -- In Troll's Bane
    local PositionsZero = {
      position( -90, -128, 0 ),
      position( -90, -126, 0 ),
      position( -90, -124, 0 ),
      position( -97, -122, 0 ),
      position( -97, -124, 0 ),
    }

    -- Shelves with books about histories
    -- In Troll's Bane
    local PositionsOneA = {
      -- In Troll's Bane
      position( -88, -128, 0 ),
      position( -88, -126, 0 ),
      position( -88, -124, 0 ),
      -- In Academy
      position( 34, 21, 50 ),
      position( 34, 23, 50 ),
      -- in Grey Refuge Castle
      position( -53, -234, 0 ),
	  position( -55, -234, 0 ),
	  position( -57, -234, 0 )
    }

    -- Shelves with books about cultures
    -- In Troll's Bane
    local PositionsOneB = {
      position( -83, -122, 0 ),
      position( -85, -129, 0 ),
      position( -87, -129, 0 ),
      -- in Academy
      position( 36, 21, 50 ),
      position( 36, 23, 50 ),
      position( 36, 25, 50 ),
      position( 38, 21, 50 ),
      position( 38, 23, 50 ),
      position( 38, 25, 50 ),
      -- In Grey Refuge Castle
      position( -48, -233, 0 ),
      position( -48, -231, 0 ),
      position( -48, -229, 0 ),
      position( -48, -227, 0 ),
      -- in Varshikar Castle
      position( 253, -318, -3 )
    }

    -- Shelves with books about Eldan priests and history
    -- In Tol Vanima
    local PositionsTwo = {
      position( 360, 209, -3 ),
      position( 363, 209, -3 ),
      position( 366, 209, -3 )
    }

    -- Shelves with books about other stuff
    -- In Varshikar
    local PositionsThree = {
      position( 272, -310, 0 ),
      position( 274, -310, 0 ),
      position( 276, -310, 0 ),
    }

    -- Shelves with books about the old man's tales
    -- In Tol Vanima
    local PositionsFourA = { position( 361, 212, -3 ) };
    local PositionsFourB = { position( 363, 212, -3 ) };
    local PositionsFourC = { position( 365, 212, -3 ) };
    local PositionsFourD = { position( 367, 212, -3 ) };

    -- Shelves with dwarven books
    -- In Silverbrand
    local PositionsFive = {
       position( 129, -209, -3 ),
       position( 129, -211, -3 ),
       position( 137, -212, -3 ),
       position( 139, -212, -3 ),
       position( 175, -204, -3 ),
       position( 173, -204, -3 ),
       position( 171, -204, -3 )
    }

    -- In Silverbrand - Hall of the Axe
    local PositionsSix = {
       position( 112, -164, -3 ),
       position( 112, -162, -3 )
    }

    -- In Magnus' building in Tol Vanima
    local PositionsSeven = {
       position( 317, 233, -3 );
    }

    -- In Grey Refuge Castle
    local PositionsEight = {
       position( -43, -233, 0 )
    }
    -- In Grey Rose's Castle
	local PositionsEightB = {
	   position( -41, -228, 0 )
	}

	-- Gem Books
	local PositionsNine = {
		position(-92,-123,1);		-- TB Library first floor
		position(367,220,0);		-- Tol Vanima
		position( 278, -308,0);		-- Varshikar
		position( 137, -212, -3 );	-- Silverbrand
		position(42,20,50);			-- Magic academy
		position(-41,-231,0);		-- Grey Rose
		position(-32,-132,-3);		-- Garon's workshop
		position(33,22,1);      	-- Kadi's Room
		position( 253, -320, -3 );  -- Varshikar Castle
	}

    -- Kadiya's room / magic academy
    local PositionsTen = {
       position( 33, 23, 51 )
    }

    -- Greenbriar bookshelf in tavern
    local PositionsEleven = {
       position( -370, 74, 0 )
    }

    -- With books about history/celebrations
    -- Shelves in Varshikar Castle Library
	local PositionsTwelve = {
	   position( 255, -318, -3 )
	}

	-- With books about basics of magic
    -- Shelves in Varshikar Castle Library
	local PositionsThirteen = {
	   position( 255, -320, -3 )
	}

	-- With books about Fragments of the lost Chronicles of Manrok
    -- Shelves in Varshikar Castle Library
	local PositionsForteen = {
	   position( 238, -325, -6 )
	}

    -- With books about Daughter of Blood
    -- Shelves in Varshikar Castle Library
	local PositionsFifteen = {
	   position( 230, -326, -6 )
	}

	--In Magic Academy
	local PositionsSixteen = {
      	position( 34, 25, 50 )
	}

    -- Misc books (previously about crafts)
    local BooksZero = {
        {2622,4},              -- How to be a simple monk
		{2616,2},              -- Ms. Piggy book
		{2615,7},             -- Brewyn the Liar
		{2605,3};            -- cooking book
  --    {106,0},              -- Simple Guide to Carpentry
  --    {107,0},              -- Husbandry and Nutrition
  --    {109,0},              -- Alchemists Basics
  --    {129,0},              -- Guide to Basic Cooking
  --    {2617,2}              -- Tihgorac's Book of Combat
    }

    -- Books about histories
    local BooksOneA = {
      {116,0},              -- History of Illarion
      {2607,0},             -- Gods of Illarion
      {2622,1},             -- Religions of Illarion
      {2617,0}              -- Celebrations
    }

    -- Books about cultures
    local BooksOneB = {
      {2622,2},             -- Human Culture
      {2609,0},             -- Elven History and Culture
      {2619,2},             -- Dwarven History and Culture
      {2607,1},             -- Halfling Culture and History
      {2617,1},             -- Lizard Culture and History
      {2616,0},             -- Feary Culture
      {2606,0},             -- Gnomish Culture
      {2604,0},             -- Orcish Culture
      {2598,0}              -- Goblin Culture
    }

    -- Books about the Eldan priests and others
    local BooksTwo = {
      {2605,0},             -- Diary of Noira Liv
      {2622,0},             -- Priests of Eldan
      {2615,7},             -- Brewyn the Liar
      {2610,0}              -- Schira'thel, Daughter of Blood
    }

    -- Books about other stuff
    local BooksThree = {
      {110,0},              -- Three Guiding truths
      {2619,0},              -- Fragments of the lost Chronicles of Manrok
	  {2605,3};            -- cooking book
    }

    -- Books about the old man's tales
    local BooksFourA = { {2615, 0} };
    local BooksFourB = { {2615, 1} };
    local BooksFourC = { {2615, 2} };
    local BooksFourD = { {2615, 3} };

    -- Dwarven books
    local BooksFive = {
      {2604, 1},            -- The Founding of Silverbrand
      {2610, 2},            -- The Saga of Thiron
      {2615, 4},            -- Tialdin's Oath
      {2616, 1},            -- Tialdin's Speeches
      {2617, 3},            -- The Story of Urubur
      {2607, 2},            -- The Festival of Relationship
      {2598, 1}             -- Dwarven poems
    }

    local BooksSix = {
      {2605, 1 }            -- Warguide of the Dwarves I
    }

    local BooksSeven = {
      {2610, 3}             -- Confusion, by Magnus Magnol
    }

    local BooksEight = {
      {2622, 3},            -- The Battle Epics of the Grey
      {2617, 6},			-- Glorification to Irmorom
      {2609, 1},            -- Petition in the name of Findari
      {2615, 6}				-- Petition on Zelphia
    }

    local BooksEightB = {
	  {2617, 5}             -- Codex of the Grey Rose
    }

    local BooksNine = {
      {116, 1};              -- Magic Stones (general)
      {107, 1};             -- Rubine
      {2622,5};             -- Diamanten
      {2607,3};             -- Blaustein
      {115, 1};             -- Smaragd
      {2619,3};             -- Schwarzstein
      {108, 1};             -- Amethyst
      {2615,5};             -- Topas
    }

    local BooksTen = {
      {2619, 4}             --  Drachentr�ume
    }

    local BooksEleven = {
      {2598, 2};			-- Cake Bible
	  {2617, 4};            -- The Articles of Greenbriar
	  {2607, 1};            -- Halfling Culture and History
	  {2622, 6};			-- The book of the jokes
	  {2609, 2};			-- The chronicles of the Blumfussens
	  {2604, 2};            -- About the humans
	  {2610, 5};  			-- Evergreen Halflings
	  {2615, 7};             -- Brewyn the Liar
	  {2605, 3};            -- cooking book
    }

    -- Twelve - Fifteen: In Varshikar Castle
    local BooksTwelve = {
      {116,0},              -- History of Illarion
      {2617,0}              -- Celebrations
    }

    local BooksThirteen = {
      {2610, 4}             -- Basics of Magic
    }

    local BooksForteen = {
      {2619,0}              -- Fragments of the lost Chronicles of Manrok
    }

    local BooksFifteen = {
      {2610,0}              -- Schira'thel, Daughter of Blood
    }
	-- in Magic Academy
	local BooksSixteen = {

		{2615,7};             -- Brewyn the Liar
    }
	--
  M.AddBookshelves( PositionsZero, BooksZero,
    "\"Seien Sie ein M�nch\", \"Bark�pfige K�nige\", \"Kochen auf Illarion, Band 1\n Fisch und Fleisch \", \"Brewyn der L�gner\"",
    "\"How To Be A Simple Monk\", \"Bareheaded Kings \", \"Cooking in Illarion, volume 1\n Fish and Meat\", \"Brewyn the Liar\"" );
  M.AddBookshelves( PositionsOneA, BooksOneA,
    "Geschichte, G�tter, Religion, Feiertage",
    "History, Gods, Religions, Celebrations" );
  M.AddBookshelves( PositionsOneB, BooksOneB,
    "Kulturen: Menschen, Elfen, Zwerge, Halblinge, Echsenmenschen, Feen, Gnome, Orks, Goblins",
    "Cultures: Human, Elven, Dwarven, Halfling,  Lizardmen, Faery, Gnomish, Orcish, Goblin" );
  M.AddBookshelves( PositionsTwo, BooksTwo,
    "Tagebuch von Noira Liv, Priester Eldans, Tochter des Blutes, \"Brewyn der L�gner\"",
    "Diary of Noira Liv, Priests of Eldan, Daughter of Blood, \"Brewyn the Liar\"" );
  M.AddBookshelves( PositionsThree, BooksThree,
    "Three Guiding Truths, verlorenen Chroniken von Manrok,  \"Kochen auf Illarion, Band 1\n Fisch und Fleisch \"",
    "Three Guiding Truths, Lost Chronicles of Manrok,  \"Cooking in Illarion, volume 1\n Fish and Meat\"" );
  M.AddBookshelves( PositionsFourA, BooksFourA,
    "Der Alte Mann, Buch 1 1",
    "the Old Man's Tales Book 1" );
  M.AddBookshelves( PositionsFourB, BooksFourB,
    "Der Alte Mann, Buch 1 2",
    "the Old Man's Tales Book 2" );
  M.AddBookshelves( PositionsFourC, BooksFourC,
    "Der Alte Mann, Buch 1 3",
    "the Old Man's Tales Book 3" );
  M.AddBookshelves( PositionsFourD, BooksFourD,
    "Der Alte Mann, Buch 1 4",
    "the Old Man's Tales Book 4" );
  M.AddBookshelves( PositionsFive, BooksFive,
    "Von der Gr�ndung Silverbrands, Thiron Saga, Tialdins Gel�bnis, Reden K�nig Tialdins, Die Geschichte Urubur, Gedichte",
    "Founding of Silverbrand, Saga of Thiron, Tialdin's Oath, Tialdin's Speeches, Urubur's Story, Festival of Relationship, Poems" );
  M.AddBookshelves( PositionsSix, BooksSix,
    "Kriegshandbuch der Zwerge I",
    "Warguide of the Dwarves I" );
  M.AddBookshelves( PositionsSeven, BooksSeven,
    "Verwirrung",
    "Confusion" );
  M.AddBookshelves( PositionsEight, BooksEight,
    "Poesie und epische Geschichten, Lobpreis an Irmorom, Gebet im Namen Findaris, Gebet f�r Zelphia",
    "Poetry and Epic Stories, Glorification to Irmorom, Petition for Findari, Petition for Zelphia" );
  M.AddBookshelves( PositionsEightB, BooksEightB,
	"Kodex der Grauen Rose",
	"Codex of the Grey Rose" );
  M.AddBookshelves( PositionsNine, BooksNine,
    "Magische Steine",
    "Magic stones" );
  M.AddBookshelves( PositionsTen, BooksTen,
    "Gesammelte Werke",
    "Collected works" );
  M.AddBookshelves( PositionsEleven, BooksEleven,
    "Die Kuchenbibel, Die Satzung Greenbriars, Kultur und Geschichte der Halblinge, Buch der Witze, Stammbaum der Blumfu�ens, �ber die Menschen, \"Evergreen Halblinge\", \"Kochen auf Illarion, Band 1\n Fisch und Fleisch \", \"Brewyn der L�gner\"",
    "The Cake Bible, The Articles of Greenbriar, Halfling Culture and History, Book of the jokes, Chronicle of the Blumfu�ens, About the Humans, \"Evergreen Halflings\", \"Cooking in Illarion, volume 1\n Fish and Meat\", \"Brewyn the Liar\"" );
  M.AddBookshelves( PositionsTwelve, BooksTwelve,
    "Geschichte, Feiertage",
    "History, Celebrations" );
  M.AddBookshelves( PositionsThirteen, BooksThirteen,
    "Grundlagen der Magie",
    "Basics of Magic" );
  M.AddBookshelves( PositionsForteen, BooksForteen,
    "verlorenen Chroniken von Manrok",
    "Lost Chronicles of Manrok" );
  M.AddBookshelves( PositionsFifteen, BooksFifteen,
    "Tochter des Blutes",
    "Daughter of Blood" );
  M.AddBookshelves( PositionsSixteen, BooksSixteen,
    "\"Brewyn der L�gner\"",
    "\"Brewyn the Liar\"" );
end

function M.AddBookshelves( Positions, Books, gBooks, eBooks )
  local offset = # Libraries  + 1;
  Libraries[offset] = {};
  Libraries[offset][1] = Positions;
  Libraries[offset][2] = Books;
  Libraries[offset][3] = gBooks;
  Libraries[offset][4] = eBooks;
end

function M.CreateBookList( TargetPos )
    local retList={};
    for i = 1, # Libraries  do
        for j = 1, # Libraries[i][1]  do
            if ( M.BookshelvesEqual( Libraries[i][1][j], TargetPos ) ) then
                for k = 1, # Libraries[i][2]  do
                    retList[k] = Libraries[i][2][k][1]
                end
--                for bookid, bookdata in Libraries[i][2] do
--                    retList[bookid] = true;
--                end
            end
        end
    end
    return retList
end

function M.BookshelvesEqual( BSPosi, Posi )
    return ( ( BSPosi.x == Posi.x ) and ( BSPosi.y == Posi.y ) and ( BSPosi.z == Posi.z ) )
end

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    if ( Libraries == nil ) then
        M.InitLibraries()
    end


    if ( Param == 0 ) then
        local BookList = M.CreateBookList( SourceItem.pos );
        local BookMenu = MenuStruct()                    -- make new menu;
        for i = 1, # BookList  do
            BookMenu:addItem( BookList[i] );
        end
--        for bookid, nothing in BookList do
--            BookMenu:addItem( bookid );
--        end
        User:sendMenu( BookMenu );
    else
        if M.DistanceFromPosToPos( SourceItem.pos, User.pos ) > 1 then
            return;
        end;

        local bookPos = M.getFreePosition( User, SourceItem );

        local done = false;
        for i = 1, # Libraries  do
            for j = 1, # Libraries[i][1]  do
                if ( M.BookshelvesEqual( Libraries[i][1][j], SourceItem.pos ) ) then
                    for k = 1, # Libraries[i][2]  do
                        if ( Libraries[i][2][k][1] == Param ) and ( not done ) then
                            world:createItemFromId( Param, 1, bookPos, true, 333, Libraries[i][2][k][2] );
                            done = true;
                        end
                    end
                end
            end
        end
    end
end

function M.getFreePosition( User, BS )
   local faceto = User:get_face_to();

   if BS.id == 266 then
      return position( User.pos.x + 1, User.pos.y, User.pos.z );
   else
      return position( User.pos.x, User.pos.y + 1, User.pos.z );
   end;
end

function M.DistanceFromPosToPos(TargetA,TargetB)
    local LengthX=math.sqrt(math.pow(TargetA.x-TargetB.x,2));
    local LengthY=math.sqrt(math.pow(TargetA.y-TargetB.y,2));
    return math.ceil(math.sqrt(math.pow(LengthX,2)+math.pow(LengthY,2)))
end

function M.LookAtItem(User,Item)
    if ( Libraries == nil ) then
        M.InitLibraries()
    end

    for i = 1, # Libraries  do
        for j = 1, # Libraries[i][1]  do
            if ( M.BookshelvesEqual( Libraries[i][1][j], Item.pos ) ) then
                if (User:getPlayerLanguage()==0) then
                    --world:itemInform(User,Item, "B�cherregal (" .. Libraries[i][3] .. ")" );
                    User:inform( "Du siehst verschiedene B�cher �ber " .. Libraries[i][3] );
                else
                    --world:itemInform(User,Item, "Bookshelf (" .. Libraries[i][5] .. ")" );
                    User:inform( "There are books about " .. Libraries[i][4] );
                end
                return;
            end
        end
    end

    if (User:getPlayerLanguage()==0) then
        world:itemInform(User,Item,"Du siehst "..world:getItemName(Item.id,0))
    else
        world:itemInform(User,Item,"You see "..world:getItemName(Item.id,1))
    end
end
---- B�cherregal
--
--function InitLibraries()
--    LibPos={};
--    LibRad={};
--    LibBooks={};
--
--    AddLibrary(position(-89,-125,0),15,
--    {
--      {106,0},
--      {107,0},
--      {108,0},
--      {109,0},
--      {110,0},
--      {111,0},
--      {112,0},
--      {113,0},
--      {114,0},
--      {115,0},
--      {116,0},
--      {127,0},
--      {131,0},
--      {2606,0},
--      {2607,0},
--      {2608,0},
--      {2610,0},
--      {2619,0},
--      {2621,0}
--    });
--
--end
--
--function AddLibrary(Posi,Rad,Books)
--    table.insert(LibPos,Posi);
--    table.insert(LibRad,Rad);
--    offset = #LibRad;
--    LibBooks[offset] = { };
--    for i, bookdef in Books do
--        if not LibBooks[offset][bookdef[1]] then
--            LibBooks[offset][bookdef[1]] = {};
--        end
--        table.insert( LibBooks[offset][bookdef[1]], bookdef[2] );
--    end
--end
--
--function DistanceFromPosToPos(TargetA,TargetB)
--    local LengthX=math.sqrt(math.pow(TargetA.x-TargetB.x,2));
--    local LengthY=math.sqrt(math.pow(TargetA.y-TargetB.y,2));
--    return math.ceil(math.sqrt(math.pow(LengthX,2)+math.pow(LengthY,2)))
--end
--
--function CreateBookList(TargetPos)
--    local retList={};
--    for i=1,#LibPos do
--        if (DistanceFromPosToPos(TargetPos,LibPos[i])<=LibRad[i]) then
--            for bookid, bookdata in LibBooks[i] do
--                retList[bookid] = true;
--            end
--        end
--    end
--    return retList
--end
--
--function UseItem(User,SourceItem,TargetItem,Counter,Param)
--    if (LibPos==nil) then
--        InitLibraries()
--    end
--    if (Param == 0) then
--        BuecherListe=CreateBookList(SourceItem.pos);
--        BuecherMenue = MenuStruct()                    -- make new menu
--        for bookid, nothing in BuecherListe do
--            BuecherMenue:addItem(bookid);
--        end
--        User:sendMenu(BuecherMenue);
--    else
--        -- Position f�r Buch
--        local buchPos = position(SourceItem.pos.x+1, SourceItem.pos.y+1, SourceItem.pos.z )
--
--        done = false;
--        for i=1,#LibPos do
--            if (DistanceFromPosToPos(TargetPos,LibPos[i])<=LibRad[i]) then
--                for bookid, bookdatalist in LibBooks[i] do
--                    if (bookid == Param) and not done then
--                        math.randomseed( SourceItem.pos.x + SourceItem.pos.y + SourceItem.pos.z );
--                        bookdata = bookdatalist[ math.random( 1, #  bookdatalist  ) ];
--                        world:createItemFromId(Param,1,buchPos,false,333,bookdata);
--                        done = true;
--                    end
--                end
--            end
--        end
--    end
--end

return M
