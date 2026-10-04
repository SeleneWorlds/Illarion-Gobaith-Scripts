# Sorgan Stonemate porting notes

The canonical pre-port source is `server/lua/npc/sorgan.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/sorgan.lua`). The CSQN port contains 4 unconditional dialogue groups, 3 idle pairs, and 0 trade items.

## Missing shared legacy behavior

- Accepted active-language IDs were `{0,2}`. Legacy initialization raised those language skills to 100 and selected `TradStdLang` as the default; CSQN German/English checks use the configured player language rather than the actively spoken language.
- Unsupported languages used the legacy one-shot confused response and reset through `SpeakerCycle`; this state is not represented in CSQN.
- `BasicNPCChecks` performed range-2 validation, introduction, and self-originator rejection. The CSQN bridge retains the range check but not necessarily every side effect.
- Legacy idle output, when present, waited a random 900–3000 NPC cycles. CSQN records selection but no explicit cooldown.
- Literal spaces in legacy trigger patterns were converted to `.+`; the generated CSQN preserves that conversion. Stateful or dynamic registrations are never flattened into unconditional dialogue.

## Commented-out trader content

The final Lua source had all 20 `AddTraderItem` registrations and most dialogue registrations commented out. It actively retained only the Silverbrand directions, help texts, and three strike-era idle lines. The CSQN preserves only that active behavior; no trade JSON was created.

The receive handler still invoked the generic trader and date dispatchers with an empty inventory and `TraderCopper=2000`. This could produce empty-list/date responses, but reactivating it as `chatTrading` would misleadingly make Sorgan look like an operational trader. If the dormant smith inventory is intentionally restored later, recover the exact 20 item definitions and dialogue from the canonical source, create `trades/sorgan.json`, register `sorgan = 2000` in `INITIAL_CASH`, and then add `chatTrading("sorgan")`.

## Needed CSQN/runtime additions

At minimum, full fidelity requires active-spoken-language conditions and skill setup, resettable per-player/NPC state, cycle cooldowns, context interpolation, computed calendar actions, customizable trade result text, and permission-gated trader administration. Implement any NPC-specific functions or skipped registrations above as named custom effects with explicit state ownership.
