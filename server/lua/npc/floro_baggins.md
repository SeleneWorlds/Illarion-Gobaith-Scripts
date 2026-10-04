# Floro Baggins porting notes

The canonical pre-port source is `server/lua/npc/floro_baggins.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/floro_baggins.lua`). The CSQN port contains 28 unconditional dialogue groups, 0 idle pairs, and 9 trade items.

## Missing shared legacy behavior

- Accepted active-language IDs were `{0,6}`. Legacy initialization raised those language skills to 100 and selected `TradStdLang` as the default; CSQN German/English checks use the configured player language rather than the actively spoken language.
- Unsupported languages used the legacy one-shot confused response and reset through `SpeakerCycle`; this state is not represented in CSQN.
- `BasicNPCChecks` performed range-2 validation, introduction, and self-originator rejection. The CSQN bridge retains the range check but not necessarily every side effect.
- Legacy idle output, when present, waited a random 900–3000 NPC cycles. CSQN records selection but no explicit cooldown.
- Literal spaces in legacy trigger patterns were converted to `.+`; the generated CSQN preserves that conversion. Stateful or dynamic registrations are never flattened into unconditional dialogue.

## Trading and calendar differences

- Initial cash was `5000` copper and must remain registered in `trading.lua`.
- Refresh bounds were `{10000,40000}`. The common legacy replenishment loop was commented out, but these constants are recorded for a future stock simulation.
- The legacy dispatcher supplied status codes 1–18 for transaction outcomes, price quotes, list summaries, and computed calendar replies. Shared `chatTrading` preserves transactions but replaces NPC-specific text. The canonical source above contains every exact German/English template and interpolation order.
- Date replies used `world:getTime`, NPC month-name tables, and randomized cardinal/ordinal English formatting. CSQN has no computed calendar action.
- German singular trade replies used `functions.GenusSel`; shared trading does not preserve grammatical gender.
- Admin-only `status` and `refill` exposed stock/cash and attempted replenishment. They require permission-gated effects.

## Needed CSQN/runtime additions

At minimum, full fidelity requires active-spoken-language conditions and skill setup, resettable per-player/NPC state, cycle cooldowns, context interpolation, computed calendar actions, customizable trade result text, and permission-gated trader administration. Implement any NPC-specific functions or skipped registrations above as named custom effects with explicit state ownership.
