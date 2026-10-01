local M = {}

local common = require("base.common")
local base_basics = require("magic.base.basics")
function M.DoItemMoveSpell(Caster, TargetPos, ltstate)
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

    if not world:isItemOnField( TargetPos ) then
        common.TempInformNLS( Caster,
        "Du musst diesen Zauber auf ein Item sprechen um Erfolg zu haben.",
        "You have to cast this spell on a item to success.");
        return;
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


    local theItem = world:getItemOnField( TargetPos );
    local comItem = world:getItemStats( theItem );

    local maxWeight = common.Scale( Weight.minSkill, Weight.maxSkill, CasterVal );
    if (comItem.Weight <= maxWeight) then
        world:createItemFromItem( theItem, common.GetFrontPosition( Caster ), true );
        world:erase( theItem, theItem.number );
    else
        common.TempInformNLS( Caster,
        "Der Gegenschand ist zu schwer. Du schaffst es nicht ihn mit dem Zauber zu bewegen.",
        "The item is too heavy. You fail to move it with this spell." );
        return false;
    end

    base_basics.performGFX( SpellEffects.gfx, TargetPos );
    base_basics.performSFX( SpellEffects.sfx, TargetPos );

    if (LuaAnd(Caster:getQuestProgress(24),1) ~= 0 ) then
        return;
    end

    Caster:learn( 3, Skill.name, 2, Skill.max );
end

function M.CastMagic(Caster,counter,param,ltstate)
    M.DoItemMoveSpell(Caster,common.GetFrontPosition(Caster),ltstate);
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
    if TargetCharacter then
        M.DoItemMoveSpell(Caster, TargetCharacter.pos, ltstate);
    else
        M.CastMagic(Caster,counter,param,ltstate);
    end
end

function M.CastMagicOnField(Caster,Targetpos,counter,param,ltstate)
    M.DoItemMoveSpell(Caster,Targetpos,ltstate);
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param,ltstate)
    M.DoItemMoveSpell(Caster,TargetItem.pos,ltstate);
end

return M
