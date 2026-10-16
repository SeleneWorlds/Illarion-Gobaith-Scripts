local M = {}

function M.LookAtItem(user, item)
    if not user:isAdmin() then return end
    world:itemInform(user, item, user:getPlayerLanguage() == Player.german
        and "Auf dem Ring sind am Rand verschlungene arkane Symbole zu erkennen."
        or "You can see some arcane symbols engraved in the ring.")
end

function M.UseItem(user)
    if not user:isAdmin() then return end
    if not (user.lastSpokenText or ""):lower():find("astral", 1, true) then
        user:inform("Du versuchst den Ring zu benutzen, aber nichts passiert.",
            "You try to use the ring, but nothing happens.")
        return
    end
    user:talkLanguage(Character.say, Player.german,
        "#me's Konturen scheinen für einen kurzen Augenblick zu flimmern, bevor sich seine Gestalt vollständig auflöst.")
    user:talkLanguage(Character.say, Player.english,
        "#me's outline begins to shimmer briefly before his form dissolves completely.")
    world:gfx(52, user.pos)
    user:warp(position(-37, -193, 1))
    for _, coordinate in ipairs({ {-37,-193,1}, {-36,-194,1}, {-38,-192,1}, {-38,-194,1}, {-36,-192,1} }) do
        world:gfx(52, position(coordinate[1], coordinate[2], coordinate[3]))
    end
end

return M
