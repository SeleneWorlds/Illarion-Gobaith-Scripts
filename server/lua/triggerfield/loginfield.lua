local M = {}

function M.CharacterOnField(character)
    character:talk(CCharacter.say,"Ich befinde mich auf einem Triggerfeld.", "I am on a trigger field.");
end

function M.MoveToField(character)
    character:talk(CCharacter.say,"Aua! Geh von mir runter, "..character.name.."!", "Ouch! Get off me, "..character.name.."!");
end

function M.MoveFromField(character)
    character:talk(CCharacter.say,"Danke. Warum nicht gleich?!", "Thank you. Why not do that straight away?!");
end

function M.PutItemOnField(item,character)
    character:talk(CCharacter.say,"Kann man das essen?", "Can you eat that?");
end

function M.TakeItemFromField(item,character)
    --character:talk(CCharacter.say,"Soebend habe ich etwas von einen Triggerfeld genommen: " .. item.id .. "!");
    character:talk(CCharacter.say,"Soeben habe ich etwas von einem Triggerfeld genommen: " .. item.id .. "!", "I just took something from a trigger field: " .. item.id .. "!");
end

return M
