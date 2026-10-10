local M = {}

function M.addEffect( myEffect, Character )
    world:gfx( 16, Character.pos );   
    world:makeSound( 13, Character.pos );
    Character:increaseAttrib( "hitpoints", 500 * ( Character:increaseAttrib( "intelligence", 0 ) + math.random( -2, 2 ) ) );
    Character:talk(CCharacter.say, "#me wird von belebendem Licht umgeben, das vom Schwert in der Hand ausgeht.", "#me is surrounded by revitalizing light emitted by the wielded sword.");
end;

function M.callEffect( myEffect, Character )
    item1 = Character:getItemAt( 5 );
    item2 = Character:getItemAt( 6 );
    if ( ( ( item1.id == 2701 ) and ( item1.data == 100 ) ) or
         ( ( item2.id == 2701 ) and ( item2.data == 100 ) ) ) then
        Character:inform(Character:getPlayerLanguage() == 0 and "Dein Schwert scheint seine Energie zurückgewonnen zu haben." or "Your sword seems to have regained its energy.");
    end;
    return false;
end;

return M
