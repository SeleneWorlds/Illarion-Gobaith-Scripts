local M = {}

local base_books = require("base.books")
-- UPDATE common SET com_script='item.book.id_106_plants' WHERE com_itemid = 106;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
  if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
    world:erase(SourceItem,1);
  else
    if base_books.InitBook() then
       base_books.AddLanguage("common language",0);  
           
       base_books.AddGermanBookText("Dies ist das Buch der Pflanzen.",0,0,0);
       base_books.AddGermanBookText("Die Wüstenhimmelskapsel wird in Wüsten gefunden. Sie wird dazu gebraucht, das Element Wind zu verwenden.",0,0,0);
       base_books.AddGermanBookText("Das Donfblatt wächst im Wald. Es wird angeblich benutzt, um irgend etwas zusammenzukleben.",0,0,0);
       base_books.AddGermanBookText("Sandbeeren verstärken den Effekt von Zaubertränken. Man sagt, sie seien in der Wüste zu finden.",0,0,0);
       base_books.AddGermanBookText("Wutbeeren können in Hecken tief im Wald gefunden werden.",0,0,0);
       base_books.AddGermanBookText("Wenn man eine Tanne pflanzen will, braucht man zuerst einen Tannensetzling.",0,0,0);
       base_books.AddGermanBookText("Tannensetzlinge können von Tannen abgeschnitten werden.",0,0,0);
       base_books.AddGermanBookText("Äpfel verrotten nach eienr Weile. Wenn man sie gut wässert, wächst daraus erneut ein Setzling.",0,0,0);
       base_books.AddGermanBookText("Beeren wachsen an Büschen im Wald.",0,0,0);
       base_books.AddGermanBookText("Zwiebeln gedeihen auf Ackerboden.",0,0,0);
       base_books.AddGermanBookText("Tomaten wachsen an Büschen, wenn man vorher die Erde beackert.",0,0,0);
       base_books.AddGermanBookText("Kirschen verrotten nach einiger Zeit. Wässert man sie stattdessen gut, können daraus Setzlinge wachsen.",0,0,0);
       base_books.AddGermanBookText("Wenn man die Wurzeln einer Tanne ausgräbt, kann man dort eine geheime Pflanze finden.",0,0,0);
       base_books.AddGermanBookText("Gutes Getreide braucht gute Samen und eine fruchtbare Erde.",0,0,0);
       base_books.AddGermanBookText("Der Blätterpilz findet sich in der Nähe von Tannen.",0,0,0);
       base_books.AddGermanBookText("Die Firnisblüte gedeiht auf Wiesen nahe an Bachläufen besonders gut.",0,0,0);
       base_books.AddGermanBookText("Der gut schmechende Rotkopfpilz kann in Wäldern gefundenwerden.",0,0,0);
       base_books.AddGermanBookText("Ein Kirschbaum wird mit seinen Wurzeln gefällt.",0,0,0);
       base_books.AddGermanBookText("Eine Palme wird mit ihren Wurzeln gefällt.",0,0,0);
       base_books.AddGermanBookText("Man sollte nie versuchen, Bäume zu fällen, wenn man Schilde trägt.",0,0,0);
       base_books.AddGermanBookText("In Schilfgürteln nahe an saftigen Wiesen kann die Vierblättrige Einbeere von wachsamen Augen gefunden werden.",0,0,0);
       base_books.AddGermanBookText("Das Gelbe Kraut ist eine wiederkehrende Pflanze in Wiesen.",0,0,0);
       base_books.AddGermanBookText("In den tiefsten Wäldern wartet die Flammenkelchblüte darauf gepflückt zu werden.",0,0,0);
       base_books.AddGermanBookText("Wenn Engel weinen, lassen ihre Tränen Nachtengelsblüten im Dreck wachsen.",0,0,0);
       base_books.AddGermanBookText("Das Heidekraut braucht nie Regen. Wenige Tropfen des morgendlichen Taus auf einem sandigen Hügel sind genug für diese genügsame Pflanze.",0,0,0);
       base_books.AddGermanBookText("Das Fußblatt ist der einzige Farn, der keinen sandigen Untergrund im Sinn hat.",0,0,0);
       base_books.AddGermanBookText("Grabe mit deiner Hand im Dreck und finde einige Sibanac Blätter im Schilf.",0,0,0);
       base_books.AddGermanBookText("Wo Kulturland in Steppe übergeht, findet sich ein von den meisten Leuten übersehener Farn.",0,0,0);
       base_books.AddGermanBookText("Einige ältere Palmen verbergen verrottete Rinde an ihren Baumwurzeln.",0,0,0);
       base_books.AddGermanBookText("Der Hirtenpilz lebt in Symbiose mit Fruchtbäumen und liebt schattige Plätze in der Nähe des Waldes.",0,0,0);
       base_books.AddGermanBookText("Der Geburtspilz kann an Nadelwaldrändern gefunden werden.",0,0,0);

       base_books.AddEnglishBookText("This is a book about plants.",0,0,0);       
       base_books.AddEnglishBookText("The desert sky capsule can be found in the desert sand. It is used to release the element of wind.",0,0,0);
       base_books.AddEnglishBookText("The donf blade is a plant that can be found in the forest. It is used to glue something on something else.",0,0,0);
       base_books.AddEnglishBookText("The sandberry strengthens the effect of a potion. It is said to be found in the desert.",0,0,0);
       base_books.AddEnglishBookText("Anger berries may be found in hedges deep in the woods.",0,0,0);
       base_books.AddEnglishBookText("If you want to plant a fir tree you need some seedlings first.",0,0,0);
       base_books.AddEnglishBookText("Fir tree seedlings can be cut down from fir trees.",0,0,0);
       base_books.AddEnglishBookText("Apples may rot after a while. When watered, they may turn to seedlings again.",0,0,0);
       base_books.AddEnglishBookText("Berries grow at bushes in the forest.",0,0,0);
       base_books.AddEnglishBookText("Onions can be cultivated on farmland.",0,0,0);
       base_books.AddEnglishBookText("Tomatoes grow into bushes if you till the soil.",0,0,0);
       base_books.AddEnglishBookText("Cherries may rot after a while, watered they may turn to seedlings again.",0,0,0);
       base_books.AddEnglishBookText("If you dig out a fir tree's root you may find another secret plant there.",0,0,0);
       base_books.AddEnglishBookText("Good grain needs good seeds and fertile soil.",0,0,0);
       base_books.AddEnglishBookText("The toadstool is to be found close to fir trees.",0,0,0);
       base_books.AddEnglishBookText("Firnis blossoms are very recurrent at meadows close to a creek.",0,0,0);
       base_books.AddEnglishBookText("The red hat is a delicious mushroom that can be found in the forest.",0,0,0);
       base_books.AddEnglishBookText("A cherry tree is cut down with its root.",0,0,0);
       base_books.AddEnglishBookText("A palm tree is cut down with its root.",0,0,0);
       base_books.AddEnglishBookText("You should never try to cut down trees while wearing shields.",0,0,0);
       base_books.AddEnglishBookText("In reeds, close to lush meadows, the four-leafed oneberry can be found by an alert eye.",0,0,0);
       base_books.AddEnglishBookText("Yellow weed is a recurrent flower in the meadows.",0,0,0);
       base_books.AddEnglishBookText("In the darkest woods flamegoblet blossoms wait to be culled.",0,0,0);
       base_books.AddEnglishBookText("When angels cry, their tears cause night angel's blossoms to spread across the dirt.",0,0,0);
       base_books.AddEnglishBookText("The heath flower never needs rain. A few drops of morning dew on a sandy hill are enough for this frugal plant.",0,0,0);
       base_books.AddEnglishBookText("The foot leaf is the only fern that does not mind a sandy ground.",0,0,0);
       base_books.AddEnglishBookText("Dig with your hands in the dirt and find some sibanac leaves in the reeds.",0,0,0);
       base_books.AddEnglishBookText("Where pasture land changes into steppe, there is a fern that some people try hard to find.",0,0,0);
       base_books.AddEnglishBookText("Some elder palm trees cultivate rotten tree bark at their stump .",0,0,0);
       base_books.AddEnglishBookText("Herds mushrooms live in symbiosis of fruit trees and love shadowed places near woods.",0,0,0);
       base_books.AddEnglishBookText("The birth mushroom can be found at the border of coniferous forests.",0,0,0);
     end
       base_books.SendBookPage(User,SourceItem.data,Counter);
   end
end  -- function

function M.LookAtItem( User, Item )
  --User:inform("debug 106-4")
  if base_books.InitTitle() then
    base_books.AddGermanBookTitle("Buch mit dem Titel \"Buch der Pflanzen\"",0);
    base_books.AddEnglishBookTitle("Book with the title \"Botany And Forestry\"",0);
  end
    base_books.GetBookItemInform(User,Item);
end

return M
