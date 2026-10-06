# Sorgan Stonemate porting notes

The canonical pre-port source is `server/lua/npc/sorgan.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/sorgan.lua`). The CSQN port intentionally restores the NPC's dormant smith dialogue and trade inventory instead of preserving the temporary strike behavior from the final Lua revision.

## Missing shared legacy behavior

- Accepted active-language IDs were `{0,2}`. Legacy initialization raised those language skills to 100 and selected `TradStdLang` as the default; CSQN German/English checks use the configured player language rather than the actively spoken language.
- Unsupported languages used the legacy one-shot confused response and reset through `SpeakerCycle`; this state is not represented in CSQN.
- `BasicNPCChecks` performed range-2 validation, introduction, and self-originator rejection. The CSQN bridge retains the range check but not necessarily every side effect.
- Legacy idle output, when present, waited a random 900–3000 NPC cycles. CSQN records selection but no explicit cooldown.
- Literal spaces in legacy trigger patterns were converted to `.+`; the generated CSQN preserves that conversion. Stateful or dynamic registrations are never flattened into unconditional dialogue.

## Restored commented-out trader content

The final Lua source had all 20 `AddTraderItem` registrations and most dialogue registrations commented out. It actively retained only the Silverbrand directions, help texts, and three strike-era idle lines. The CSQN and `trades/sorgan.json` restore the intended dialogue and inventory, retain the neutral `Arrr` idle lines, and omit the `I am on strike!` line.

The receive handler invoked the generic trader and date dispatchers with `TraderCopper=2000`. The restored trade uses that initial cash value and the exact item definitions from the canonical source.

## Needed CSQN/runtime additions

At minimum, full fidelity requires active-spoken-language conditions and skill setup, resettable per-player/NPC state, cycle cooldowns, context interpolation, computed calendar actions, customizable trade result text, and permission-gated trader administration. Implement any NPC-specific functions or skipped registrations above as named custom effects with explicit state ownership.
