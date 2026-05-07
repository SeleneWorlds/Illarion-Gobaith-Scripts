local Base = require("magic.base.gfxspell")
local basics = require("magic.base.basics")

local M = {}

-- setting the filename of the current script. This is needed to exchange them later if needed while runtime
M.Script = "m_01_02_16_24_explosion-area.lua";

-- Skill related spell settings
M.Skill = {
    ["min"]  =         60,  -- minimal Skillvalue needed to cast the spell
    ["max"]  =        100,  -- maximal Skillvalue of the spell where it reaches its full effect
    ["name"] = "commotio"   -- name of the skill that is needed for this spell
}

-- General Spell settings
M.Settings = {
    ["Runes"] = "KEL RA DUN QWAN",   -- Names of the runes the spell contains of. This is the text spoken when the spell is casted
    ["Range"] = 8,          -- Maximum distance in tiles between the target of the spell and the caster
    ["FirstInLine"] = false  -- Perform a line of flight calculation and hit the first character on this line or the destination the caster pointed at
}

-- Grafik and Sound effects that appear when the spell is casted successfully
M.SpellEffects = {
    ["line"] = nil,
    [0] = {                 -- Radius 0 around the target location (so this IS exactly the target location)
        ["gfx"] = 35,       -- Grafic effect that is shown on the position the spell hitted
        ["sfx"] = 5         -- Sound effect that is placed in the position the spell hitted
    },
    [1] = {                 -- Radius 1 around the target location
        ["gfx"] = 36,       -- Graphic effect on this radius
        ["sfx"] = 0         -- Sound effect on this radius
    },
    [2] = {                 -- Radius 2 around the target location
        ["gfx"] = 36,       -- Graphic effect on this radius
        ["sfx"] = 0         -- Sound effect on this radius
    },
    [3] = {                 -- Radius 3 around the target location
        ["gfx"] = 36,       -- Graphic effect on this radius
        ["sfx"] = 0         -- Sound effect on this radius
    }
}

-- Time related effects of the spell
M.TimeEffects = {
    ["delay"] = 35,         -- Casting delay before the spell is actually casted in 1/10 seconds (while this time the Caster can be interrupted)
    ["gfx"] = {             -- The the graphic effect informations that are used while the casting delay
        ["id"] = 21,        -- The gfx id that is shown while the casting delay
        ["time"] = 10       -- The time in 1/10 seconds that has to pass before the gfx is played a second time
    },
    ["sfx"] = {             -- The sound effect informations that are used while the casting delay
        ["id"] = 0,         -- The id of the sound effect that played while the casting delay
        ["time"] = 0        -- The time in 1/10 seconds that has to pass before the sound effect is played a second time
    },
    ["msg"] = {             -- The messages that are shown before the time delay is started in german and english
        [CPlayer.german ] = "#me beginnt mit einer mystischen Formel und in {PP}n H�nden beginnen Flammen zu z�ngeln.",
        [CPlayer.english] = "#me starts with a mystical formula and in {PP} hands some small flames appear."
    }
}

-- effects on the caster when he castes the spell, the effects are interpolated linear from minSkill to maxSkill
M.CasterEffects = {
    ["minSkill"] = {                -- effects that are caused in case the caster has to minimum needed skill
        ["hitpoints"]    =     0,   -- increase of the hitpoints
        ["foodpoints"]   =     0,   -- increase of the foodlevel
        ["actionpoints"] =   -30,   -- increase of the action points
        ["manapoints"]   = -3500,   -- increase of the mana
        ["poison"]       =     0,    -- increase of the poison value
        ["posoffset"]    =     0    -- change the position of the character by this value from the caster away
    },
    ["maxSkill"] = {               -- effects that are caused in case the caster has the maximum needed skill
        ["hitpoints"]    =     0,   -- increase of the hitpoints
        ["foodpoints"]   =     0,   -- increase of the foodlevel
        ["actionpoints"] =   -20,   -- increase of the action points
        ["manapoints"]   = -1500,   -- increase of the mana
        ["poison"]       =     0,    -- increase of the poison value
        ["posoffset"]    =     0    -- change the position of the character by this value from the caster away
    }
}

-- effects that are caused at the target of the spell, handled in the same way as the CasterEffects
M.TargetEffects = {
    ["minSkill"] = {                -- effects that are caused in case the caster has the minium needed skill
        ["hitpoints"]    =  -900,   -- increase of the hitpoints
        ["foodpoints"]   =     0,   -- increase of the foodlevel
        ["actionpoints"] =     0,   -- increase of the action points
        ["manapoints"]   =     0,   -- increase of the mana
        ["poison"]       =     0,    -- increase of the poison value
        ["posoffset"]    =     0    -- change the position of the character by this value from the caster away
    },
    ["maxSkill"] = {                -- effects that are caused in case the caster has the maximum needed skill, however the needed Skill is higher then the the setted value due the magic resistance
        ["hitpoints"]    = -4000,   -- increase of the hitpoints
        ["foodpoints"]   =     0,   -- increase of the foodlevel
        ["actionpoints"] =     0,   -- increase of the action points
        ["manapoints"]   =     0,   -- increase of the mana
        ["poison"]       =     0,    -- increase of the poison value
        ["posoffset"]    =     0    -- change the position of the character by this value from the caster away
    }
}

-- Racial bonis
basics.initRaceBoni(); -- Init or reset all preset racial boni values
basics.SetRaceBoni( 33, 2.00, 10.00 ); -- dragon ( RaceID 33 - Offensive Boni: *2 - Defensive Value (against this spell): *10

-- make sure that we remember that this is the original script loaded on this spell
M.orgScript = M.Script

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

function M.CastMagic(...)
    activate()
    return Base.CastMagic(...)
end

function M.CastMagicOnCharacter(...)
    activate()
    return Base.CastMagicOnCharacter(...)
end

function M.CastMagicOnField(...)
    activate()
    return Base.CastMagicOnField(...)
end

function M.CastMagicOnItem(...)
    activate()
    return Base.CastMagicOnItem(...)
end

return M
