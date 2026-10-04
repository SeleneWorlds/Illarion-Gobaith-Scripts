# Zaruk porting notes

The CSQN and trade JSON preserve Zaruk's use responses, small talk, inventory, prices, initial stock, target stock, quality, durability, and 5000-copper reserve. The canonical pre-port source is `server/lua/npc/zaruk.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/zaruk.lua`).

## Missing language behavior

- Chat accepted active languages `{0, 1}` (common and human), raised both skills to 100, and adopted the speaker's active language. Common (`0`) was selected at initialization, but the script did not explicitly restore it after each conversation.
- Unsupported speech produced `#me sieht dich leicht verwirrt an` / `#me looks at you a little confused` once until the legacy 600-cycle reset.
- `BasicNPCChecks` restricted conversation to range 2, introduced the NPC to the speaker, and rejected the NPC itself as originator. The CSQN bridge retains range checking but not necessarily every side effect.
- CSQN's `german` and `english` conditions inspect the player's configured language rather than the actively spoken character language.

## Missing generic date behavior

Zaruk answered shared day/date patterns using `world:getTime`. Month names were `Elos, Tanos, Zhas, Ushos, Siros, Ronas, Bras, Eldas, Irmas, Malas, Findos, Olos, Adras, Naras, Chos, Mas`. German used `Es ist der N. Tag des Monates MONTH im Jahre YEAR.`; English randomly selected `It's day N of MONTH of the year YEAR.` or `It's the Nth of MONTH of the year YEAR.`

## Trading differences

- The source used status codes 1–18 for plural/singular buy and sell success, inventory-space failure, insufficient player funds, unavailable stock, unsupported sale or purchase, price quotes, missing player items, insufficient trader cash, nonempty/empty sale and purchase lists, and date output. Shared `chatTrading` preserves transactions but replaces Zaruk's exact response templates. The canonical source above contains every string and value interpolation order.
- Zaruk's sale-list summary was `I sell good and hard to get things. Look` / `Ich verkauf gutes und ziemlich schwer zu bekommendes Zeug. Sieh.` His purchase-list English text contained the original typo `I but this and that. Look. On this list everything i sell is written down.`; German was `Ich kauf dies und das. Hier schau. Hier steht alles was ich kauf.`
- German singular transaction messages selected grammatical gender through `functions.GenusSel`; shared messages do not reproduce this.
- Refresh bounds were 10000–40000 cycles, although the common legacy refill loop was commented out.
- Admin-only `status` exposed cash, delivery counters, and all stock quantities. `refill` attempted stock replenishment and restored cash to at least 5000. Neither command was ported.

## Intentional port choices

- Asking about `wares` or `Ware` now opens the trade menu in addition to speaking the legacy reply.
- The original use text says `Fast mich nicht an!` (rather than the grammatically expected `Fass mich nicht an!`); CSQN preserves it verbatim.

## Needed CSQN/runtime additions

Add active-spoken-language conditions and language-skill initialization, resettable confused-response state, computed calendar replies with interpolation, customizable trade status/list messages and grammatical gender, and permission-gated trader inspection/refill actions.
