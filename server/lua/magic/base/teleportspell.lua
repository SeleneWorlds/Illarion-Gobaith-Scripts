local common = require("base.common")
local base_basics = require("magic.base.basics")
function DoTeleSpell(Caster, TargetPos, ltstate)
    if ( ltstate == Action.abort ) then
        Caster:talkLanguage(CCharacter.say, CPlayer.german, "#me stoppt apprupt mit dem Zaubern.");
        Caster:talkLanguage(CCharacter.say, CPlayer.english,"#me abruptly stops casting.");
        return;
    end

    base_basics.loadCorrectDefScript();

    -- Generate the needed
    base_basics.gemBonis( Caster );

    genderMsg = {};
    genderMsg[CPlayer.german], genderMsg[CPlayer.english] = base_basics.GenderMessage( Caster );

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
        local message = string.gsub( TimeEffects.msg[CPlayer.german], "{PP}", genderMsg[CPlayer.german] );
        --Caster:talkLanguage( CCharacter.say,  CPlayer.german, message );
        message = string.gsub( TimeEffects.msg[CPlayer.english], "{PP}", genderMsg[CPlayer.english] );
        --Caster:talkLanguage( CCharacter.say, CPlayer.english, message );
        Caster:startAction( common.Limit( TimeEffects.delay + GemBonis.Time, 0 ), TimeEffects.gfx.id, TimeEffects.gfx.time, TimeEffects.sfx.id, TimeEffects.sfx.time);
        return;
    end

    base_basics.SayRunes( Caster );

    local CasterVal=base_basics.CasterValue( Caster );

    if not base_basics.CheckAndReduceRequirements( Caster, CasterVal ) then
        return;
    end

    if not CasterVal then
        common.TempInformNLS( Caster,
        "Es gelingt dir nicht die n�tige Konzentration aufzubringen um diesen Zauber zur Entfaltung zu bringen.",
        "You fail to concentrate enought to get this spell to its evolvement." );
        return;
    end

    local drift = common.Limit( common.Scale( Teleport.Drift.minSkill, Teleport.Drift.maxSkill, CasterVal ), 0 );

    if drift > 0 then
        drift = math.random( 0, drift );
        local phi = math.random()*2;
        TargetPos = position( math.floor(TargetPos.x+drift*math.sin( phi * math.pi )), math.floor(TargetPos.y+drift*math.cos( phi * math.pi )), TargetPos.z );
    end

    base_basics.performGFX(  Teleport.StartLocation.gfx, Caster.pos );
    base_basics.performSFX(  Teleport.StartLocation.sfx, Caster.pos );

    local oldPos = common.CopyPosition( Caster.pos );
    Caster:warp( TargetPos );
    if not equapos( TargetPos, Caster.pos ) then
        Caster:warp( oldPos );
    end

    if not equapos( oldPos, Caster.pos ) then
        base_basics.performGFX( Teleport.TargetLocation.gfx, Caster.pos );
        base_basics.performSFX( Teleport.TargetLocation.sfx, Caster.pos );
    end

    if (LuaAnd(Caster:getQuestProgress(24),1) ~= 0 ) then
        return;
    end

    Caster:learn( 3, Skill.name, 2, Skill.max );
end

function CastMagic(Caster,counter,param, ltstate)
    DoTeleSpell(Caster,common.GetFrontPosition( Caster ), ltstate);
end

function CastMagicOnCharacter(Caster,TargetCharacter,counter,param, ltstate)
    common.TempInformNLS( Caster,
    "Es ist nicht sinnvoll sich auf ein anderes Lebewesen zu teleportieren.",
    "Its not useful to teleport on another entity" );
end

function CastMagicOnField(Caster,Targetpos,counter,param, ltstate)
    DoTeleSpell(Caster,Targetpos, ltstate);
end

function CastMagicOnItem(Caster,TargetItem,counter,param, ltstate)
    DoTeleSpell(Caster,TargetItem.pos, ltstate);
end

local M = {}

function M.DoTeleSpell(...)
    return DoTeleSpell(...)
end

function M.CastMagic(...)
    return CastMagic(...)
end

function M.CastMagicOnCharacter(...)
    return CastMagicOnCharacter(...)
end

function M.CastMagicOnField(...)
    return CastMagicOnField(...)
end

function M.CastMagicOnItem(...)
    return CastMagicOnItem(...)
end

return M
