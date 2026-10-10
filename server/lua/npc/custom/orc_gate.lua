local M = {}
local config = {
    ["krudash_orcguard"] = {
        open = {"[bb]roth[ae].+[oo]pen.+[gg]ate.*", "[oo]pen.+[gg]ate.+[bb]roth[ae].*", "[bb]rud[ae].+[tt]or.*[aa]uf.*", "[tt]or.+[aa]uf.+[bb]rud[ae].*", "[bb]rud[ae].+[öoe]ffne.+[tt]or.*", "[ööe]ffne.+[tt]or.+[bb]rud[ae].*"},
        close = {"[bb]roth[ae].+[cc]lose.+[gg]ate.*", "[cc]lose.+[gg]ate.+[bb]roth[ae].*", "[bb]rud[ae].+[tt]or.*[zz]u.*", "[tt]or.+[zz]u.+[bb]rud[ae].*", "[bb]rud[ae].+schlie[ßs].+[tt]or.*", "[ss]chlie[ßs].+[tt]or.+[bb]rud[ae].*"},
        a = {-62, -141, 0},
        b = {-62, -140, 0},
    },
    ["kronk_orcguard"] = {
        open = {"[bb]roth[ae].+[oo]pen.+[gg]ate.*", "[oo]pen.+[gg]ate.+[bb]roth[ae].*", "[bb]rud[ae].+[tt]or.*[aa]uf.*", "[tt]or.+[aa]uf.+[bb]rud[ae].*", "[bb]rud[ae].+[öoe]ffne.+[tt]or.*", "[ööe]ffne.+[tt]or.+[bb]rud[ae].*"},
        close = {"[bb]roth[ae].+[cc]lose.+[gg]ate.*", "[cc]lose.+[gg]ate.+[bb]roth[ae].*", "[bb]rud[ae].+[tt]or.*[zz]u.*", "[tt]or.+[zz]u.+[bb]rud[ae].*", "[bb]rud[ae].+schlie[ßs].+[tt]or.*", "[ss]chlie[ßs].+[tt]or.+[bb]rud[ae].*"},
        a = {163, -449, -1},
        b = {164, -449, -1},
    },
    ["karkish_orcguard"] = {
        open = {"[ss]ist[ae].+[oo]pen.+[gg]ate.*", "[oo]pen.+[gg]ate.+[ss]ist[ae].*", "[ss]chwest[ae].+[tt]or.*[aa]uf.*", "[tt]or.+[aa]uf.+[ss]chwest[ae].*", "[ss]chwest[ae].+[öoe]ffne.+[tt]or.*", "[ööe]ffne.+[tt]or.+[ss]chwest[ae].*"},
        close = {"[ss]ist[ae].+[cc]lose.+[gg]ate.*", "[cc]lose.+[gg]ate.+[ss]ist[ae].*", "[ss]chwest[ae].+[tt]or.*[zz]u.*", "[tt]or.+[zz]u.+[ss]chwest[ae].*", "[ss]chwest[ae].+schlie[ßs].+[tt]or.*", "[ss]chlie[ßs].+[tt]or.+[ss]chwest[ae].*"},
        a = {157, -432, 0},
        b = {156, -432, 0},
    },
    ["gruknug_orcguard"] = {
        open = {"[bb]r.*ud.*a.+[oo]pen.+[gg]ate.*", "[bb]r.*[ou]th.*[ae].+[oo]pen.+[gg]ate.*", "[oo]pen.+[gg]ate.+[bb]r.*ud.*a.*", "[oo]pen.+[gg]ate.+[bb]r.*[ou]th.*[ae].*", "[bb]r.*ud.*[ae].+[tt]or.*[aa]uf.*", "[tt]or.+[aa]uf.+[bb]r.*ud.*[ae].*", "[bb]r.*ud.*[ae].+[öoe]ffne.+[tt]or.*", "[ööe]ffne.+[tt]or.+[bb]r.*ud.*[ae].*"},
        close = {"[bb]r.*ud.*a.+[cc]lose.+[gg]ate.*", "[bb]r.*[ou]th.*[ae].+[cc]lose.+[gg]ate.*", "[cc]lose.+[gg]ate.+[bb]r.*ud.*a.*", "[cc]lose.+[gg]ate.+[bb]r.*[ou]th.*[ae].*", "[bb]r.*ud.*[ae].+[tt]or.*[zz]u.*", "[tt]or.+[zz]u.+[bb]r.*ud.*[ae].*", "[bb]r.*ud.*[ae].+schlie[ßs].+[tt]or.*", "[ss]chlie[ßs].+[tt]or.+[bb]r.*ud.*[ae].*"},
        a = {188, -444, 1},
        b = {188, -443, 1},
    },
}

local function command(context, name)
    local settings = assert(config[name], 'Unknown orc gate ' .. tostring(name))
    for _,mode in ipairs({'open', 'close'}) do
        for _,pattern in ipairs(settings[mode]) do
            if string.find(context.text, pattern) then return mode, settings end
        end
    end
end

function M.isCommand(context, name)
    return command(context, name) ~= nil
end

local function say(context, german, english)
    context.npc:talk(Character.say, context.player:getPlayerLanguage() == 0 and german or english)
end

function M.operate(context, name)
    local mode, settings = command(context, name)
    if not mode then return end
    if context.player.activeLanguage ~= 5 then
        say(context, 'Du sprechen orkisch zu mir, wenn ich soll anfassen Orktor!',
            'Speak orcish ib yoo wunt meh touch da gate!')
        return
    end
    local doors, keys = require('base.doors'), require('base.keys')
    local a = position(table.unpack(settings.a))
    local b = position(table.unpack(settings.b))
    local left, right = world:getItemOnField(a), world:getItemOnField(b)
    if mode == 'open' then
        if doors.CheckOpenDoor(left.id) and doors.CheckOpenDoor(right.id) then
            say(context, 'Dummer Ork, Tor sein auf!', 'Stoopid orc, da gate alrrready beh open!')
            return
        end
        keys.UnlockDoor(left); keys.UnlockDoor(right)
        left, right = world:getItemOnField(a), world:getItemOnField(b)
        doors.OpenDoor(left); doors.OpenDoor(right)
        say(context, '#me öffnet schwerfällig das Tor wodurch die Höhle mit einem markerschütternden Knarren erfüllt wird.',
            '#me opens the gate. The whole cave is filled with a loud noise.')
    else
        if doors.CheckClosedDoor(left.id) and doors.CheckClosedDoor(right.id) then
            say(context, 'Du keine Augen in deinem stinkigen Kopf haben? Tor sein schon zu!',
                'Yoo nub hab eyes in yoos smelly head? Da gate alrrready beh closed!')
            return
        end
        if world:isCharacterOnField(a) or world:isCharacterOnField(b) then
            say(context, 'Ich nix können Tor zumachen wenn da jemand rumstehen!',
                'Me nub can close dat gate when someone standing there!')
            return
        end
        doors.CloseDoor(left); doors.CloseDoor(right)
        left, right = world:getItemOnField(a), world:getItemOnField(b)
        keys.LockDoor(left); keys.LockDoor(right)
        say(context, '#me lässt die Flügel des Tores krachend zufallen und sperrt ab.',
            '#me slams the gate shut and locks it.')
    end
end

return M
