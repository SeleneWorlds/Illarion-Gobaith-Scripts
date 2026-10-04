# Jarmal porting notes

The canonical pre-port source is `server/lua/npc/jarmal.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/jarmal.lua`). The CSQN port contains 24 unconditional dialogue groups, 0 idle pairs, and 0 trade items.

## Missing shared legacy behavior

- Accepted active-language IDs were `{0,1}`. Legacy initialization raised those language skills to 100 and selected `TradStdLang` as the default; CSQN German/English checks use the configured player language rather than the actively spoken language.
- Unsupported languages used the legacy one-shot confused response and reset through `SpeakerCycle`; this state is not represented in CSQN.
- `BasicNPCChecks` performed range-2 validation, introduction, and self-originator rejection. The CSQN bridge retains the range check but not necessarily every side effect.
- Legacy idle output, when present, waited a random 900–3000 NPC cycles. CSQN records selection but no explicit cooldown.
- Literal spaces in legacy trigger patterns were converted to `.+`; the generated CSQN preserves that conversion. Stateful or dynamic registrations are never flattened into unconditional dialogue.

## NPC-specific behavior

- `M.TownTexts` recognized Troll's Bane and Greenbriar and selected a localized reply. Both branches are represented directly in CSQN with `if(german, ..., ...)`; no custom effect remains necessary for this helper.

## Needed CSQN/runtime additions

At minimum, full fidelity requires active-spoken-language conditions and skill setup, resettable per-player/NPC state, cycle cooldowns, context interpolation, computed calendar actions, customizable trade result text, and permission-gated trader administration. Implement any NPC-specific functions or skipped registrations above as named custom effects with explicit state ownership.
