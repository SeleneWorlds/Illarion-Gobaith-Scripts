# Gambret Mandarett porting notes

The CSQN and trade JSON preserve Gambret's use text, dialogue, inventory, prices, stock, quality, durability, and initial cash. The canonical pre-port source is `server/lua/npc/gambret.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/gambret.lua`).

## Missing language behavior

- Chat accepted active languages `{0, 1}` (common and human) and switched to the speaker's active language while responding. Common (`0`) was selected at initialization; unlike Feliam, this script did not explicitly restore it after each conversation.
- Unsupported speech emitted `#me sieht dich leicht verwirrt an` / `#me looks at you a little confused` once until the 600-cycle reset.
- Initialization raised common- and human-language skills to 100. CSQN's `german`/`english` checks use player language settings rather than the actively spoken language.

## Missing generic date behavior

Gambret supported the shared day/date queries. It used the month sequence `Elos, Tanos, Zhas, Ushos, Siros, Ronas, Bras, Eldas, Irmas, Malas, Findos, Olos, Adras, Naras, Chos, Mas`, German `Es ist der N. Tag des Monates MONTH im Jahre YEAR.`, and randomly chose between English `It's day N ...` and ordinal `It's the Nth ...` forms.

## Trading differences

- Initial cash was 400 copper and is retained in `trading.lua`.
- The legacy 10000–40000-cycle refresh configuration was present, although the base refresh loop was commented out.
- Shared trading messages replace Gambret's status-specific templates. The source defines responses for status codes 1–18 (buy/sell success variants, capacity/funds/stock failures, quotes, list summaries, and date). Retrieve the source command above for the exact strings and value interpolation order.
- His intended list summaries were `I sell cooking tools, plates and bowls.` / `Ich verkaufe Kochbesteck, Teller und Schüsseln.` and `I buy cutlery and different dishes.` / `Ich kaufe Besteck und verschiedenes Geschirr.` The legacy empty-sale-list response unusually claimed old bowls, plates, or utensils were available.
- Admin-only `status` exposed cash/delivery/stock information and `refill` replenished stock/cash. These were not ported.

## Needed CSQN/runtime additions

Add active-language conditions and language-skill initialization, resettable confused state, computed calendar replies, customizable trade status messages, and permission-gated trader administration actions.
