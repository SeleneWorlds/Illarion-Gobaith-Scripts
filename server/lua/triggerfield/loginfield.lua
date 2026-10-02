local M = {}

function M.CharacterOnField(character)
    character:talk(CCharacter.say,"Ich befinde mich auf einem Triggerfeld");
end

function M.MoveToField(character)
    character:talk(CCharacter.say,"Aua! Geh von mir runter,"..character.name.."!");
end

function M.MoveFromField(character)
    character:talk(CCharacter.say,"Danke. Warum nicht gleich?!");
end

function M.PutItemOnField(item,character)
    character:talk(CCharacter.say,"Kann man das essen?");
end

function M.TakeItemFromField(item,character)
    --character:talk(CCharacter.say,"Soebend habe ich etwas von einen Triggerfeld genommen: " .. item.id .. "!");
    character:talk(CCharacter.say,"Soebend habe ich etwas von einen Triggerfeld genommen: " .. item.id .. "!");
end

return M
