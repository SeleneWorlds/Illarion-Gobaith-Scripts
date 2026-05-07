local Base = require("magic.base.teachspell")
local basics = require("magic.base.basics")

local M = {}

-- Informations about the rune
M.Rune = {
    ["name"] = "KEL",   -- name of the rune
    ["class"] = 1,      -- class of the rune ( 1 = weak, 2 = normal, 3 = strong )
    ["value"] = 0       -- value of the rune
}

-- Teacher related informations
M.Teacher = {
    ["skill"] = {               -- The required skill of the teacher
        ["name"] = "commotio",  -- name of the skill that is required
        ["value"] = 40          -- value of the skill that is required
    },
    ["attribsum"] = 33          -- sum of attributes that are required
}

-- Student related informations
M.Student = {
    ["skill"] = nil,            -- Skill requirements to the student
    ["attribsum"] = nil         -- attribute requirements to the student
}

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
