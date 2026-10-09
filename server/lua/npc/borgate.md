# Borgate Northoff porting notes

The CSQN and trade JSON represent Borgate's intended full barkeeper behavior. The final pre-removal Lua source is `server/lua/npc/borgate.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/borgate.lua`). That revision had most inventory, dialogue, and normal idle lines commented out; this distinction matters when reproducing exact historical behavior.

## Active behavior missing from CSQN

- The active English `help` response listed the normal trade phrases plus `Tell <something>`; active German `hilfe` listed the corresponding trade phrases. Neither help trigger is in CSQN.
- Chat accepted active languages `{0, 2}` (common and dwarf), raised both skills to 100, adopted the speaker's active language, and restored common (`0`) after processing. Unsupported speech emitted `#me sieht dich leicht verwirrt an` / `#me looks at you a little confused` once until the 600-cycle reset.
- Idle speech used the randomized 900–3000-cycle `SpeakerCycle` delay, which is not explicit in CSQN.
- Borgate supported shared day/date queries with the standard 16 month names and randomized cardinal/ordinal English formatting.
- Admin-only `status` printed cash/delivery/stock details; `refill` attempted stock and cash restoration. These are absent.

## Dormant intended behavior restored by CSQN/data

The final Lua revision commented out all 13 `AddTraderItem` calls and most small-talk/cycle registrations. The CSQN and `trades/borgate_northoff.json` intentionally restore those definitions rather than reproduce the strike-only state. The dormant cycle lines restored by CSQN include drinking beer, drying a mug, looking bored, playing with a copper coin, and wiping the bar.

The dormant dialogue used `thisNPC.name` for “who are you” and introduction replies. CSQN hardcodes `Borgate`; future interpolation should use the NPC context. One malformed dormant call combined the trigger and answer expression for the English “who” response, so the intended sentence—not the invalid call—is the useful reconstruction target.

## Trading differences

- Initial cash was 1000 copper and is retained in `trading.lua`. Refresh bounds were 10000–40000 cycles, though the common refill loop was commented out.
- If the old normal trader dispatcher is restored, it has status codes 1–18 for transaction outcomes, price quotes, sale/purchase lists, and dates. Exact templates are in the canonical source. Borgate's list summaries were `I sell drinks, drinks and hard to believe: drinks!` / `Ich verkaufe Getränke, Getränke und man stell sich vor: Getränke!` and `I buy drinks and glass mugs.` / `Ich kaufe Getränke und Glaskrüge.` Shared trading currently uses generic messages.

## Needed CSQN/runtime additions

Add help triggers, the omitted strike idle line, active-language handling and skill setup, resettable confused state, randomized cycle cooldowns, context interpolation, calendar replies, customizable trade result/list messages, and permission-gated trader maintenance actions.
