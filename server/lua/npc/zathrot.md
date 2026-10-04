# Zathrot porting notes

The CSQN and trade JSON preserve Zathrot's look/use text, idle lines, dialogue, inventory, prices, stock, quality, durability, and initial cash. The canonical pre-port source is `server/lua/npc/zathrot.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/zathrot.lua`).

## Missing language and timing behavior

- Zathrot accepted active languages `{0, 4}` (common and lizard), raised both skills to 100, and adopted the speaker's active language. Common (`0`) was selected at initialization, but the script did not explicitly restore it after each conversation.
- Unsupported speech produced `#me sieht dich leicht verwirrt an` / `#me looks at you a little confused` once until the 600-cycle reset.
- Idle lines were selected only after random waits of 900–3000 NPC cycles. CSQN preserves the four random lines but has no explicit cooldown.

## Missing generic date behavior

Date queries used `world:getTime` and Zathrot-specific month spellings: `Elosss, Tanosss, Zhasss, Ushosss, Sssirosss, Ronasss, Brasss, Eldasss, Irmasss, Malasss, Findosss, Olosss, Adrasss, Narasss, Chosss, Masss`. German began `Esss issst der ...`; English randomly used `It'sss day ...` or `It'sss the Nth ...`, ending in `sss`.

## Trading differences

- Initial cash was 1000 copper and is retained in `trading.lua`.
- The original money vocabulary was character-specific: German `Gold`, `Sssilber`, `Kupfer`, `ssstücke`; English `gold`, `sssilver`, `copper`, `piecesss`. Shared trading uses standard coin wording.
- Zathrot had custom status 1–18 messages with his extended-s speech for transaction success/failure, quotes, inventory/cash/stock errors, list summaries, and date output. The exact templates and interpolation order are in the canonical source above; shared `chatTrading` currently emits generic text.
- His list summaries were `I sell fisssh, toolsss and more. sss` / `Ich verkaufe Fisssche, Werkzeuge und Anderesss. sss`, and `I buy fissshing rodsss, oil lampsss and combsss. sss` / `Ich kaufe Angeln, Öllampen und Kämme. sss`.
- Refresh bounds were 10000–40000 cycles, although the old shared refill loop was commented out. Admin-only `status` and `refill` commands were omitted.
- The legacy German tools trigger was accidentally `[Ww]was.+[Ww]erkzeug`; the CSQN intentionally corrects it to `was.+werkzeug` rather than preserving the unreachable typo.

## Needed CSQN/runtime additions

Add active-language conditions and skill initialization, resettable confused state, randomized cycle cooldowns, calendar formatting, per-trader currency vocabulary and status templates, and permission-gated stock inspection/refill actions.
