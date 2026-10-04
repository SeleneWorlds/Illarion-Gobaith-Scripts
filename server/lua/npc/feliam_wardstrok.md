# Feliam Wardstrok porting notes

The CSQN and trade JSON preserve Feliam's look/use text, small talk, trade inventory, prices, initial stock, target stock, quality, durability, and initial cash. The canonical pre-port source is `server/lua/npc/feliam_wardstrok.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/feliam_wardstrok.lua`).

## Missing language and timing behavior

- Chat originally accepted active languages `{0, 6}` (common and halfling), not the player's configured UI language. Unsupported speech produced the confused emote in German or English once until the legacy 600-cycle reset.
- Initialization raised common- and halfling-language skills to 100 and restored common (`0`) as the NPC's active language after every conversation.
- Legacy range checking, introduction, and active-language switching came from `BasicNPCChecks`/`LangOK`; the shared CSQN bridge only retains the range-2 check.

## Missing generic date behavior

The Lua NPC recognized variants of “what day/date is it?” and their German equivalents. It read `world:getTime("day"|"month"|"year")`, used the 16 Illarion month names (`Elos`, `Tanos`, `Zhas`, `Ushos`, `Siros`, `Ronas`, `Bras`, `Eldas`, `Irmas`, `Malas`, `Findos`, `Olos`, `Adras`, `Naras`, `Chos`, `Mas`), and returned either `It's day N of MONTH of the year YEAR.` or `It's the Nth of MONTH of the year YEAR.` at random. German used `Es ist der N. Tag des Monates MONTH im Jahre YEAR.`

## Trading differences

- The original cash reserve was 3000 copper; this is retained in `trading.lua`, but persistence/replenishment is not implemented.
- Explicit aliases for onion seeds were `onion` and `zwiebel`; aliases for cabbage seeds were `cabbage` and `Kohl`. Trade JSON has no alias array, so matching currently depends on its `name` plus localized world item names.
- The original refresh interval was 10000–40000 cycles. The refresh implementation in the legacy base library was commented out, so this was already inactive; retain the constants if replenishment is reintroduced.
- NPC-specific transaction results are replaced by shared trading messages. The original distinguished status codes 1–18: multi-buy success, inventory full, insufficient funds, out of stock, item not sold, single-buy success, sell-price quote, buy-price quote, multi-sell success, player lacks item, trader lacks cash, item not bought, single-sell success, nonempty/empty sale list, nonempty/empty purchase list, and date response. Exact German/English templates remain in the canonical Lua source above.
- Feliam's list summaries were `I sell tools, food and seeds.` / `Ich verkaufe Werkzeug, Nahrung und Samen.` and `I buy food and seeds.` / `Ich kaufe Nahrung und Samen.`
- Admin-only `status` reported cash, delivery counters, and every stock amount; `refill` reset stock toward defaults and cash to at least 3000. Neither command is exposed by CSQN.

## Needed CSQN/runtime additions

Add active-spoken-language conditions, resettable confused-response state, a world-calendar action with formatting/interpolation, trade aliases, customizable per-status trade messages, and permission-gated trader inspection/refill actions.
