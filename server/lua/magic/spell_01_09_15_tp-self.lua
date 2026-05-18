local Base = require("magic.base.teleportspell")
local basics = require("magic.base.basics")

local M = {}

-- setting the filename of the current script. This is needed to exchange them later if needed while runtime
M.Script = "m_01_09_15_tp-self.lua";

-- Skill related spell settings
M.Skill = {
    ["min"]  =        20,  -- minimal Skillvalue needed to cast the spell
    ["max"]  =       100,  -- maximal Skillvalue of the spell where it reaches its full effect
    ["name"] = "desicio"   -- name of the skill that is needed for this spell
}

-- General Spell settings
M.Settings = {
    ["Runes"] = "JUS TAUR KEL",   -- Names of the runes the spell contains of. This is the text spoken when the spell is casted
    ["Range"] = 8         -- Maximum distance in tiles between the target of the spell and the caster
}

-- Time related effects of the spell
M.TimeEffects = {
    ["delay"] = 18,          -- Casting delay before the spell is actually casted in 1/10 seconds (while this time the Caster can be interrupted)
    ["gfx"] = {             -- The the graphic effect informations that are used while the casting delay
        ["id"] = 21,        -- The gfx id that is shown while the casting delay
        ["time"] = 10       -- The time in 1/10 seconds that has to pass before the gfx is played a second time
    },
    ["sfx"] = {             -- The sound effect informations that are used while the casting delay
        ["id"] = 0,         -- The id of the sound effect that played while the casting delay
        ["time"] = 0        -- The time in 1/10 seconds that has to pass before the sound effect is played a second time
    },
    ["msg"] = {             -- The messages that are shown before the time delay is started in german and english
        [CPlayer.german ] = "#me beginnt mit einer mystischen Formel und {PP} H�nde beginnen zu verschwimmen.",
        [CPlayer.english] = "#me starts with a mystical formula and {PP} hands become indistinct."
    }
}

-- effects on the caster when he castes the spell, the effects are interpolated linear from minSkill to maxSkill
M.CasterEffects = {
    ["minSkill"] = {                -- effects that are caused in case the caster has to minimum needed skill
        ["hitpoints"]    =     0,   -- increase of the hitpoints
        ["foodpoints"]   =     0,   -- increase of the foodlevel
        ["actionpoints"] =   -20,   -- increase of the action points
        ["manapoints"]   = -1000,   -- increase of the mana
        ["poison"]       =     0,    -- increase of the poison value
        ["posoffset"]    =     0    -- change the position of the character by this value from the caster away
    },
    ["maxSkill"] = {               -- effects that are caused in case the caster has the maximum needed skill
        ["hitpoints"]    =    0,   -- increase of the hitpoints
        ["foodpoints"]   =    0,   -- increase of the foodlevel
        ["actionpoints"] =  -10,   -- increase of the action points
        ["manapoints"]   = -300,   -- increase of the mana
        ["poison"]       =    0,    -- increase of the poison value
        ["posoffset"]    =    0    -- change the position of the character by this value from the caster away
    }
}

-- All values related to the actuall teleport
M.Teleport = {
    ["Drift"] = {               -- value of the drift of the spell location
        ["minSkill"] = 5,       -- drift of the spell location at minimal skill (radius)
        ["maxSkill"] = -1       -- drift of the spell location at maximal skill (radius)
    },
    ["StartLocation"] = {
        ["gfx"] = 41,           -- gfx shown at the start location of the teleport
        ["sfx"] = 13            -- sound effect played at the start location of the teleport
    },
    ["TargetLocation"] = {
        ["gfx"] = 41,           -- gfx shown at the target location of the teleport
        ["sfx"] = 13            -- sound effect played at the target location of the teleport
    }
}

-- Racial bonis
basics.initRaceBoni(); -- Init or reset all preset racial boni values

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
