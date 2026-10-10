local M = {}
local settings = {
    irmtrud={a={137,-163,-9}, b={138,-163,-9}, title='irmtrud'},
    magda_rosenzopf={a={102,-181,-3}, b={102,-180,-3}, title='magda'},
}

local function command(context, name)
    local gate = assert(settings[name], 'Unknown dwarf gate ' .. tostring(name))
    local text = context.text
    if text:find('wem.+hast.+du.+zuletzt.+aufgemacht') or text:find('who.+did.+you.+open.+last.+time.+the.+gate') then return 'report', gate end
    if text:find('tor.+zu') or text:find('close.+gate') then return 'close', gate end
    if text:find('tor.+auf') or text:find('open.+gate') then
        local polite = text:find(gate.title) or text:find('schwester') or text:find('sister')
        return polite and 'open' or 'impolite', gate
    end
end

function M.isCommand(context, name)
    return command(context, name) ~= nil
end

local function say(context, german, english)
    context.npc:talk(Character.say, context.player:getPlayerLanguage() == 0 and german or english)
end

function M.operate(context, name)
    local mode, gate = command(context, name)
    if not mode then return end
    if context.player.activeLanguage ~= 2 then
        say(context, 'Sprich zwergisch mit mir, wenn ich das Tor öffnen oder schließen soll!',
            "Talk dwarfish with me if you want me to open or close the gate!")
        return
    end
    if mode == 'impolite' then
        say(context, 'Ick bin deine Schwester, also behandle mich och so!', "I'm yer sister, so ye better treat me lik' this!")
        return
    end
    if mode == 'report' then
        if context.player.id ~= 867463423 and context.player.id ~= 2082906332 then
            say(context, 'Dat verrate ick dir doch nich!', "I don't tell that to you!")
        elseif context.state.lastUser then
            say(context, "Dem dem ick zuletzt aufjemacht hab war '" .. context.state.lastUser .. "', jau!",
                "The one who I opened last time the door was '" .. context.state.lastUser .. "', aye!")
        else
            say(context, 'Tut mir leid, hab ick schon vergessen.', 'I am sorry, I have forgot who I opened last time the gate.')
        end
        return
    end
    local doors, keys = require('base.doors'), require('base.keys')
    local a, b = position(table.unpack(gate.a)), position(table.unpack(gate.b))
    local left, right = world:getItemOnField(a), world:getItemOnField(b)
    if mode == 'close' then
        if world:isCharacterOnField(a) or world:isCharacterOnField(b) then
            say(context, 'Ich kann dat Tor nich zumachen wenn da jemand steht.', "I can't close the gate during someone stands there.")
            return
        end
        if doors.CheckClosedDoor(left.id) and doors.CheckClosedDoor(right.id) then
            say(context, 'Dat Tor ist bereits zu.', 'The gate is already closed.')
            return
        end
        doors.CloseDoor(left); doors.CloseDoor(right)
        left, right = world:getItemOnField(a), world:getItemOnField(b)
        keys.LockDoor(left); keys.LockDoor(right)
        say(context, '#me lässt die Flügel des Tores krachend zufallen und sperrt ab.', '#me shuts the gate crashing then locks it.')
        return
    end
    if math.random(0,200) == 1 then
        if math.random(0,10) == 1 then
            say(context, '#me hält ihren Kopf "Nay, bin heut nich im Stimmung, hab Kopfweh! Beweg deinen Hintern selber!".',
                '#me holds her head "Nay, today I\'m in a foul mood, I\'ve headache! Mov\' yer behind yerself!".')
        else
            say(context, '#me grummelt "Mach doch selber auf!".', '#me grumbles "I don\'t feel like it today. Do it yourself!".')
        end
        return
    end
    if doors.CheckOpenDoor(left.id) or doors.CheckOpenDoor(right.id) then
        say(context, 'Dat Tor steht doch schon offen.', 'The gate is already opened.')
        return
    end
    keys.UnlockDoor(left); keys.UnlockDoor(right)
    left, right = world:getItemOnField(a), world:getItemOnField(b)
    doors.OpenDoor(left); doors.OpenDoor(right)
    say(context, name == 'irmtrud' and '#me öffnet das Tor.' or '#me öffnet das Tor und wirft einen grimmigen Blick in den Raum.',
        name == 'irmtrud' and '#me opens the gate.' or '#me opens the gate and looks grimly into the room.')
    local player = context.player
    if player.id ~= 867463423 and player.id ~= 2082906332 then context.state.lastUser = player.name end
    if name == 'irmtrud' and player.pos.y > -162 then
        if player:increaseAttrib('sex', 0) == 0 then say(context, 'Willkommen zurück Bruder.', 'Welcome back brother.')
        else say(context, 'Willkommen zurück Schwester.', 'Welcome back sister') end
    elseif name == 'magda_rosenzopf' and player.pos.x < 101 then
        if player.id == 956233928 then
            say(context, 'Willkommmen zurück Friedl, heut schon wen verkloppt?', 'Welcome back Friedl, anyone beated today?')
        elseif player.id == 2082906332 then
            say(context, 'Willkommen zurück Boindil, hübsch siehste heut aus.', 'Welcome back Boindil, you look beautiful today.')
        end
    end
end

return M
