local M = {}

local common = require("base.common")
local Registries = require("selene.registries")
local basics = require("magic.base.basics")

--[[
    Open a teleporter gate
    Rune 1 & 15 & 21 & 23
        JUS FHEN ANTH KEL

    Spezial-Spell

    SQL:    INSERT INTO spells VALUES (2^0+2^14+2^20+2^22,0,'m_01_15_21_23_open-tp-gate.lua');
]]

-- setting the filename of the current script. This is needed to exchange them later if needed while runtime
M.Script = "m_01_15_21_23_open-tp-gate.lua";

-- Skill related spell settings
M.Skill = {
    ["min"]  =         50,  -- minimal Skillvalue needed to cast the spell
    ["max"]  =        100,  -- maximal Skillvalue of the spell where it reaches its full effect
    ["name"] = "pervestigatio"   -- name of the skill that is needed for this spell
}

-- General Spell settings
M.Settings = {
    ["Runes"] = "JUS FHEN ANTH KEL",   -- Names of the runes the spell contains of. This is the text spoken when the spell is casted
    ["Range"] = 8,          -- Maximum distance in tiles between the target of the spell and the caster
    ["FirstInLine"] = false  -- Perform a line of flight calculation and hit the first character on this line or the destination the caster pointed at
}

-- Grafik and Sound effects that appear when the spell is casted successfully
M.SpellEffects = {
    ["gfx"] = 41,        -- Grafic effect that is shown
    ["sfx"] = 4         -- Sound effect that is placed
}

-- Time related effects of the spell
M.TimeEffects = {
    ["delay"] = 40,         -- Casting delay before the spell is actually casted in 1/10 seconds (while this time the Caster can be interrupted)
    ["gfx"] = {             -- The the graphic effect informations that are used while the casting delay
        ["id"] = 21,        -- The gfx id that is shown while the casting delay
        ["time"] = 10       -- The time in 1/10 seconds that has to pass before the gfx is played a second time
    },
    ["sfx"] = {             -- The sound effect informations that are used while the casting delay
        ["id"] = 0,         -- The id of the sound effect that played while the casting delay
        ["time"] = 0        -- The time in 1/10 seconds that has to pass before the sound effect is played a second time
    },
    ["msg"] = {             -- The messages that are shown before the time delay is started in german and english
        [CPlayer.german ] = "#me beginnt mit einer mystischen Formel.",
        [CPlayer.english] = "#me starts with a mystical formula."
    }
}

-- effects on the caster when he castes the spell, the effects are interpolated linear from minSkill to maxSkill
M.CasterEffects = {
    ["minSkill"] = {                -- effects that are caused in case the caster has to minimum needed skill
        ["hitpoints"]    =     0,   -- increase of the hitpoints
        ["foodpoints"]   =     0,   -- increase of the foodlevel
        ["actionpoints"] =   -20,   -- increase of the action points
        ["manapoints"]   = -8000,   -- increase of the mana
        ["poison"]       =     0,    -- increase of the poison value
        ["posoffset"]    =     0    -- change the position of the character by this value from the caster away
    },
    ["maxSkill"] = {               -- effects that are caused in case the caster has the maximum needed skill
        ["hitpoints"]    =     0,   -- increase of the hitpoints
        ["foodpoints"]   =     0,   -- increase of the foodlevel
        ["actionpoints"] =   -10,   -- increase of the action points
        ["manapoints"]   = -2000,   -- increase of the mana
        ["poison"]       =     0,    -- increase of the poison value
        ["posoffset"]    =     0    -- change the position of the character by this value from the caster away
    }
}

M.Portal = {
    ["minSkill"] = {
        ["stability"] = 0,
        ["offset"] = 5
    },
    ["maxSkill"] = {
        ["stability"] = 10,
        ["offset"] = -3
    }
}


-- Racial bonis
basics.initRaceBoni(); -- Init or reset all preset racial boni values

-- make sure that we remember that this is the original script loaded on this spell
M.orgScript = M.Script

function M.CastMagic(Caster,counter,param, ltstate)
    M.DoTeleportSpell(Caster,common.GetFrontPosition(Caster), ltstate);
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param, ltstate)
    M.DoTeleportSpell(Caster,common.GetFrontPosition(TargetCharacter), ltstate);
end

function M.CastMagicOnField(Caster,Targetpos,counter,param, ltstate)
    M.DoTeleportSpell(Caster,Targetpos, ltstate);
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param, ltstate)
    M.DoTeleportSpell(Caster,TargetItem.pos, ltstate);
end

function M.DoTeleportSpell(Caster,TargetPos, ltstate)
    if ((Caster.lastSpokenText~="JUS FHEN ANTH KEL") and
        (Caster.lastSpokenText~="#me beginnt mit einer mystischen Formel.") and
        (Caster.lastSpokenText~="#me starts with a mystical formula.")) then
        TalkedText=Caster.lastSpokenText;
    end

    if ( ltstate == Action.abort ) then
        Caster:talkLanguage(CCharacter.say, CPlayer.german, "#me stoppt abrupt mit dem Zaubern.");
        Caster:talkLanguage(CCharacter.say, CPlayer.english,"#me abruptly stops casting.");
        return;
    end

    basics.loadCorrectDefScript();

    -- Generate the needed
    basics.gemBonis( Caster );

    genderMsg = {};
    genderMsg[CPlayer.german], genderMsg[CPlayer.english] = basics.GenderMessage( Caster );

    if ( Caster:distanceMetricToPosition(TargetPos) > Settings.Range + GemBonis.Range) then
        common.InformNLS( Caster,
        "Du bist zuweit weg um diesen Zauber zu sprechen.",
        "You are too far away to cast this spell." );
        return;
    end

    if not common.IsLookingAt( Caster, TargetPos ) then
        common.TempInformNLS( Caster,
        "Du drehst dich auf dein Ziel zu um es in dein Blickfeld zu bekommen.",
        "You turn to your target to get it into your field of vision.");
        common.TurnTo( Caster, TargetPos );
    end

    if ( ltstate == Action.none ) then
        Caster:startAction( TimeEffects.delay + GemBonis.Time, TimeEffects.gfx.id, TimeEffects.gfx.time, TimeEffects.sfx.id, TimeEffects.sfx.time);
        local message = string.gsub( TimeEffects.msg[CPlayer.german], "{PP}", genderMsg[CPlayer.german] );
        Caster:talkLanguage( CCharacter.say,  CPlayer.german, message );
        message = string.gsub( TimeEffects.msg[CPlayer.english], "{PP}", genderMsg[CPlayer.english] );
        Caster:talkLanguage( CCharacter.say, CPlayer.english, message );
        return;
    end

    basics.SayRunes( Caster );

    local CasterVal=basics.CasterValue( Caster );

    if not basics.CheckAndReduceRequirements( Caster, CasterVal ) then
        return;
    end

    if not CasterVal then
        common.TempInformNLS( Caster,
        "Es gelingt dir nicht die nötige Konzentration aufzubringen um diesen Zauber zur Entfaltung zu bringen.",
        "You fail to concentrate enought to get this spell to its evolvement." );
        return;
    end


    if not M.ChoseAndOpenGate(TalkedText,TargetPos, CasterVal, Caster) then
        common.TempInformNLS( Caster,
        "Der Spruch gelingt doch das Portal schliest sich sogleich wieder.",
        "The spell succeeds but the portal closes again instandly.");
    else
        basics.performGFX( SpellEffects.gfx, TargetPos );
        basics.performSFX( SpellEffects.sfx, TargetPos );
    end

    if (LuaAnd(Caster:getQuestProgress(24),1) ~= 0 ) then
        return;
    end

    Caster:learn( 3, Skill.name, 2, Skill.max );
end

-- Each pattern group requires one match; exclusions preserve ambiguous phrase precedence.
local function matchesDestination(text, destination)
    local groups = destination:getField("patterns") or {}
    if #groups == 0 then return false end
    for _, pattern in ipairs(destination:getField("excludedPatterns") or {}) do
        if string.find(text, pattern) then return false end
    end
    for _, patterns in ipairs(groups) do
        local matched = false
        for _, pattern in ipairs(patterns) do
            if string.find(text, pattern) then matched = true; break end
        end
        if not matched then return false end
    end
    return true
end

function M.ChoseAndOpenGate(Text,TPos, CasterVal, Caster)
    local destinations = {}
    for _, entry in pairs(Registries.findAll("illarion:mage_portal_destinations")) do
        if #(entry:getField("patterns") or {}) > 0 then
            destinations[#destinations + 1] = entry
        end
    end
    table.sort(destinations, function(a, b)
        return a:getField("order") < b:getField("order")
    end)
    local selected
    for index, entry in ipairs(destinations) do
        if matchesDestination(Text, entry) then selected = index; break end
    end
    if not selected then return false end

    local stability = common.Limit( common.Round( common.Scale( Portal.minSkill.stability, Portal.maxSkill.stability, CasterVal ) ), 0, 9 );
    local offset    = common.Limit( common.Round( common.Scale( Portal.minSkill.offset,    Portal.maxSkill.offset,    CasterVal ) ), 0, 5 );

    if (stability == 0) then
        return false;
    end

    selected = common.Limit(selected + math.random(-offset, offset), 1, #destinations)
    local destination = destinations[selected]
    local coordinate = destination:getField("coordinate")



    if (world:isCharacterOnField(TPos)) then
        return false;
    end

    world:createItemFromId(10, 1, TPos, true, stability*100+33, {
        x = coordinate.x,
        y = coordinate.y,
        z = coordinate.z,
        CustomName = destination:getField("name")
    });
    return true;
end

local function activate()
    basics.initRaceBoni()
    Script = M.Script
    Skill = M.Skill
    Settings = M.Settings
    SpellEffects = M.SpellEffects
    TimeEffects = M.TimeEffects
    CasterEffects = M.CasterEffects
    TargetEffects = M.TargetEffects
    Teleport = M.Teleport
    Spot = M.Spot
    Wall = M.Wall
    Circle = M.Circle
    Rune = M.Rune
    Teacher = M.Teacher
    Student = M.Student
    Monsters = M.Monsters
    Portal = M.Portal
    Weight = M.Weight
    orgScript = M.orgScript
end

local castMagic = M.CastMagic
local castMagicOnCharacter = M.CastMagicOnCharacter
local castMagicOnField = M.CastMagicOnField
local castMagicOnItem = M.CastMagicOnItem
local doTeleportSpell = M.DoTeleportSpell
local choseAndOpenGate = M.ChoseAndOpenGate

function M.CastMagic(...)
    activate()
    return castMagic(...)
end

function M.CastMagicOnCharacter(...)
    activate()
    return castMagicOnCharacter(...)
end

function M.CastMagicOnField(...)
    activate()
    return castMagicOnField(...)
end

function M.CastMagicOnItem(...)
    activate()
    return castMagicOnItem(...)
end

function M.DoTeleportSpell(...)
    activate()
    return doTeleportSpell(...)
end

function M.ChoseAndOpenGate(...)
    activate()
    return choseAndOpenGate(...)
end

function M.actionDisturbed(Caster, disturber)
    return basics.actionDisturbed(Caster, disturber, M.Skill)
end

return M
