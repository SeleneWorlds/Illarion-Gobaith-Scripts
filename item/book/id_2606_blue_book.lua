local M = {}
local UseItem

--LONG THIN BLUE BOOK

local base_books = require("base.books")
-- UPDATE common SET com_script='item.book.id_2606_blue_book' WHERE com_itemid = 2606;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
      if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
          world:erase(SourceItem,1);
      else
          if base_books.InitBook() then
            base_books.AddLanguage("common language",0);

            base_books.AddEnglishBookText("\n \n Gnomish Culture",0,0,0);
            base_books.AddEnglishBookText("Gnomes are somewhat related to dwarves, although much thinner and a bit smaller than halflings. We are intelligent and agile, as well as very good at crafting mechanical things.",0,0,0);
            base_books.AddEnglishBookText("Usually we are not good thieves, our ethics and views don't permit us to do such things. Our noses are somewhat big and we have a liking for long names. We often have four first names.",0,0,0);
            base_books.AddEnglishBookText("Gnomish clothing is usually more practical than decorative. We love to live under the surface, like dwarves. We live in a kind of mine, although not as big when compared to our dwarven counterparts.",0,0,0);
            base_books.AddEnglishBookText("Our homes tend to be painted with bright clay.",0,0,0);
            base_books.AddEnglishBookText("As stated before, us gnomes have a great liking for mechanical contraptions. Our caves and mines are often equipped with these inventions.",0,0,0);
            base_books.AddEnglishBookText("They usually are quite complex. Wooden gears, ropes, frames are usually what they consist of. We have them for simple purposes like retrieving a bucket of water from the well.",0,0,0);
            base_books.AddEnglishBookText("We generally don't like mountains like dwarves do and we also have a liking for magic, specifically the kind that creates illusion. We use much illusion magic for entertainment.",0,0,0);
            base_books.AddEnglishBookText("We, the gnomes, are the only race to be able to travel through Alabrian settlements without any predjudices, thanks to this magic. Our magic is so great, they will pay us to entertain them.",0,0,0);
            base_books.AddEnglishBookText("We often pray to Irmorom like dwarves do, but we are not very religious. We feel that anything can be achieved with a little intelligence and mystical creatures. Though, there are some priests.",0,0,0);
            base_books.AddEnglishBookText("As well, male and female gnomes are equal in our society.",0,0,0);

            base_books.AddGermanBookText("\n \n Die Kultur der Gnome",0,0,0);
            base_books.AddGermanBookText("Gnome sind so etwas �hnliches wie Zwerge, jedoch wesentlich d�nner und auch etwas kleiner als Halblinge. Wir sind schlau und flink und gewandt in der Herstellung von Ger�tschaften.",0,0,0);
            base_books.AddGermanBookText("Wir taugen nicht als Diebe, unsere Weltanschauung erlaubt uns so etwas nicht. Unsere Nasen sind irgendwie etwas zu gro� geraten und vielleicht kommt daher unsere Vorliebe f�r lange Namen. Manche von uns haben vier Vornamen.",0,0,0);
            base_books.AddGermanBookText("Die Kleidung der Gnome ist eher praktisch denn modisch. Wir leben gerne untertage, wie die Zwerge. Unser Minen jedoch sind, verglichen mit denen der Zwerge, sehr viel kleiner.",0,0,0);
            base_books.AddGermanBookText("F�r gew�hnlich sind unsere Heimst�tten mit hellem Lehm verputzt.",0,0,0);
            base_books.AddGermanBookText("Wie schon gesagt, wir Gnome haben eine Vorliebe f�r neumodischen mechanischen Kram. H�hlen und Minen sind deshalb oft mit solchen Sachen vollgestopft.",0,0,0);
            base_books.AddGermanBookText("Unsere Apparate sind oft recht aufw�ndig. H�lzerne Getriebe, Seile, Fahrgestelle, daraus bestehen sie meist. Wir benutzen sie dann f�r so einfache T�tigkeiten wie das zur�ckziehen eines Wassereimers aus dem Brunnen.",0,0,0);
            base_books.AddGermanBookText("Ganz im Gegensatz zu den Zwergen m�gen wir die Berge nicht, stattdessen besitzen wir einen Hang zur Magie, insbesondere f�r Illuminationszauber. Mit so etwas kann man sich auch gut die Zeit vertreiben.",0,0,0);
            base_books.AddGermanBookText("Wir, die Gnome, sind die einzige Rasse, die dank ihrer Magie in der Lage ist, durch  Alabrians Siedlungen zu reisen ohne jedwede Anfeindungen. Unsere Magie ist so gro�artig, dass man uns daf�r bezahlt, sie vorzuf�hren.",0,0,0);
            base_books.AddGermanBookText("Wir beten oft zu Irmorom, wie die Zwerge, aber eigentlich sind wir nicht besonders religi�s. Wir glauben daran, das man alles mit ein wenig Gehirnschmalz und Mystik erreichen kann. Trotzdem gibt es unter uns einige Priester.",0,0,0);
            base_books.AddGermanBookText("M�nner und Frauen haben in unserer Gesellschaft gleiche Rechte.",0,0,0);

          end
      end
      base_books.SendBookPage(User,SourceItem.data,Counter);
  end

  function LookAtItem(User,Item)
      if base_books.InitTitle() then
          base_books.AddEnglishBookTitle("Book with the title \"Gnomish Culture\"",0);
          base_books.AddGermanBookTitle("Buch mit dem Titel \"Die Kultur der Gnome\"",0);
      end
      base_books.GetBookItemInform(User,Item);
  end

return M
