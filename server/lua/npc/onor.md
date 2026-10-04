# Onor porting notes

The CSQN and trade JSON preserve Onor's dialogue, four idle lines, infinite silver/gold stock, exchange prices, quality, durability, and zero initial cash. The canonical pre-port source is `server/lua/npc/onor.lua` at commit `0d450abde152cfb2a7411bb11fe604751e5a2f97` (retrieve with `git show 0d450abd:server/lua/npc/onor.lua`).

## Missing language, use, and timing behavior

- Chat accepted active languages `{0, 1, 10}` (common, human, and ancient), raised all three skills to 100, adopted the speaker's active language for the response, and restored common (`0`) afterward. CSQN checks the player's configured German/English language instead.
- Unsupported speech produced `#me sieht dich leicht verwirrt an` / `#me looks at you a little confused` once until the 600-cycle reset.
- The Lua `useNPC` emitted both localized messages with `talkLanguage`: German `Fasst mich nicht an!` and English `Don't you touch me!`. CSQN chooses one result through its language condition; verify whether this is observably equivalent for multilingual nearby clients.
- Idle output was delayed by a randomized 900–3000-cycle `SpeakerCycle` cooldown. CSQN preserves the random line selection but not the explicit delay.
- `BasicNPCChecks` also introduced the NPC and rejected the NPC itself as originator; the CSQN bridge retains the range-2 check but not necessarily every side effect.

## Missing dialogue and date behavior

- The English `help` response listed `List your wares`, buying by count or singular item, and `Price of ...`. The German `hilfe` response listed the corresponding commands. Neither help trigger is in the CSQN file.
- Onor answered shared day/date patterns using `world:getTime`, months `Elos, Tanos, Zhas, Ushos, Siros, Ronas, Bras, Eldas, Irmas, Malas, Findos, Olos, Adras, Naras, Chos, Mas`, German `Es ist der N. Tag des Monats MONTH im Jahre YEAR.`, and randomly either `It is day N ...` or `It's the Nth ...` in English.

## Trading differences

- The original transaction dispatcher distinguished status codes 1–18: plural/singular purchases, inventory full, insufficient player funds, out of stock, unsupported sale, sell/buy price quotes, plural/singular player sales, missing player items, insufficient trader cash, unsupported purchase, nonempty/empty sell and buy lists, and date output. Shared `chatTrading` replaces Onor's exact templates; retrieve the source above for all strings and interpolation order.
- Onor's nonempty sale summary was `I sell gold and silver coins` / `Ich verkaufe Gold- und Silberstücke`. The nonempty purchase-list response was deliberately empty because Onor bought nothing.
- `RefreshTime` was `{100, 100}`, but the shared legacy refill loop was commented out and both coin stocks were the infinite sentinel `4294967295`.
- Admin-only `status` displayed cash/delivery/stock data and `refill` attempted stock/cash restoration. Neither command was ported.

## Needed CSQN/runtime additions

Add active-spoken-language conditions and skill initialization, resettable confused state, cycle cooldowns, multi-language broadcast semantics where needed, computed calendar replies, help text, customizable trade status templates, and permission-gated trader administration.
