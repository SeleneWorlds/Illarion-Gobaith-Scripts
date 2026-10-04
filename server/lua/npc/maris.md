# Maris Maroqu porting notes

The CSQN and trade JSON preserve Maris's use text, dialogue, inventory, prices, stock, quality, durability, and initial cash. The canonical pre-port source is `server/lua/npc/maris.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/maris.lua`). The data record spells the name `Maris Maroqu`; dialogue used `Maris Maroqué`.

## Missing language behavior

- Chat accepted active languages `{0, 1}` (common and human) and adopted the speaker's active language. Common (`0`) was selected at initialization, but the script did not explicitly restore it after each conversation. Initialization raised both language skills to 100.
- Unsupported speech emitted `#me sieht dich leicht verwirrt an` / `#me looks at you a little confused` once until the 600-cycle reset.
- CSQN's language conditions use the configured player language, not the language currently spoken by the character.

## Missing generic date behavior

Maris supported shared day/date queries using `world:getTime`, the month names `Elos, Tanos, Zhas, Ushos, Siros, Ronas, Bras, Eldas, Irmas, Malas, Findos, Olos, Adras, Naras, Chos, Mas`, a fixed German sentence, and a random choice between cardinal and ordinal English sentences.

## Trading differences

- Initial cash was 1000 copper and is retained in `trading.lua`.
- Refresh bounds were 10000–40000 cycles, but the common legacy replenishment loop was commented out.
- The shared trader replaces Maris's custom status 1–18 dialogue. The original source contains exact German/English templates for plural/singular transactions, insufficient inventory space or funds, missing stock/items, trader cash shortage, buy/sell quotes, list summaries, and date output, including genus selection for German item names.
- Intended list summaries enumerate grey/dyed cloth, shirts, gloves, dresses/coats, trousers, needles, scissors, and thread for sale; purchases include dyed cloth and finished clothes. Shared `chatTrading` instead uses generic “These are the wares…” messages.
- Admin `status` and `refill` commands were omitted. They exposed stock/cash and replenished stock/cash for administrators.

## Needed CSQN/runtime additions

Add active-language checks and skill initialization, confused-response state, calendar formatting, customizable and interpolated trade-status replies (including grammatical gender), and permission-gated trader maintenance actions.
