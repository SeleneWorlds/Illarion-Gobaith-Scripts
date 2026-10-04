local base_books = require("base.books")
local M = {}

-- This file contains the book data for the book "Magic stones"

function M.loadBook(toData)
    base_books.AddLanguage("common language",toData);

    base_books.AddEnglishBookText("Magic stones and their usage",0,0,toData);
    base_books.AddEnglishBookText("Magic stones are the rarest kind of gems in the whole world.",0,0,toData);
    base_books.AddEnglishBookText("The stronger the magic power of such a stone is, the rarer and more valuable it is.",0,0,toData);
    base_books.AddEnglishBookText("Transform at an altar of one of the five gods. Thereby, 3 stones of the same quality result in a stone of higher quality.",0,0,toData);
    base_books.AddEnglishBookText("The transformation of such stones does not always work. The higher the quality you want to reach, the higher the possibility that the transformation fails.",0,0,toData);
    base_books.AddEnglishBookText("Stones with magic attributes can be used to transfer their powers onto certain objects.",0,0,toData);
    base_books.AddEnglishBookText("However, this is only possible when the object is receptive for this kind of magic energies.",0,0,toData);
    base_books.AddEnglishBookText("Axiomatically, an object can only store a certain amount of magic energy.",0,0,toData);
    base_books.AddEnglishBookText("Once transmitted, the magic energy of the stones cannot be removed from the object anymore, neither can it be superimposed by other energies.",0,0,toData);
    base_books.AddEnglishBookText("Axiomatically, weapons, armors, magic wands and tools can store the energies of two stones.",0,0,toData);
    base_books.AddEnglishBookText("Trinkets, however, can only store the energies of one single stone.",0,0,toData);
    base_books.AddEnglishBookText("Additionally, it may be that the energies of the magic stones have to match with stones embedded in the item.",0,0,toData);


    base_books.AddGermanBookText("Magische Steine und ihre Verwendung",0,0,toData);
    base_books.AddGermanBookText("Magische Steine sind die wohl am seltensten vorkommenden Edelsteine auf der Welt.",0,0,toData);
    base_books.AddGermanBookText("Je stärker die magische Kraft eines solchen Steines ist, desto seltender und wertvoller ist er.",0,0,toData);
    base_books.AddGermanBookText("Man kann magische Edelsteine am Alter eines der fünf alten Götter umwandeln. Dabei ergeben immer 3 Steine gleicher Stärke einen Stein von höherer Qualität.",0,0,toData);
    base_books.AddGermanBookText("Das Umwandeln solcher Steine gelingt nicht immer. Je höher die Qualität ist, die erreicht werden soll, desto größer ist die Gefahr dass der Umwandlungsversuch fehlschlägt.",0,0,toData);
    base_books.AddGermanBookText("Steine mit magischen Eigenschaften können dazu genutzt werden um die ihnen innewohnenden Kräfte auf bestimmte Gegenstände zu übertragen.",0,0,toData);
    base_books.AddGermanBookText("Dies ist allerdings nur dann möglich, wenn der Gegenstand für solche Art von magischen Energien empfänglich ist.",0,0,toData);
    base_books.AddGermanBookText("Grundsätzlich gilt, dass jeder Gegenstand nur eine gewisse Menge magischer Energie aufnehmen kann.",0,0,toData);
    base_books.AddGermanBookText("Einmal übertragen, kann die magische Energie der Steine nicht mehr aus dem Gegenstand entfernt oder oder mit anderen Energien überlagert werden.",0,0,toData);
    base_books.AddGermanBookText("Grundsätzlich lässt sich sagen, dass Waffen, Rüstungen, Magierstäbe und Werkzeuge die Engerien von zwei Steinen aufnehmen können.",0,0,toData);
    base_books.AddGermanBookText("In Ringe hingegen kann lediglich die Energien eines Steines übertragen werden.",0,0,toData);
    base_books.AddGermanBookText("Zudem ist bei diesen auch zu beachten, dass sich die Energien der magischen Steine mit ggf. eingesetzten Steinen gleichen muss.",0,0,toData);
end;

function loadTitle(toData)
    base_books.AddGermanBookTitle("Buch mit dem Titel \"Magische Steine\"",toData);
    base_books.AddEnglishBookTitle("Book with the title \"Magic stones\"",toData);
end;

return M