# Eliza porting notes

The CSQN and trade JSON represent Eliza's intended lizard trader dialogue and inventory. The final pre-removal Lua source is `server/lua/npc/eliza.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/eliza.lua`). That source combined intended trader definitions with an unfinished experimental menu implementation, so active and dormant behavior are separated below.

## Active experimental behavior not ported

- `useNPC` required range 2 and an accepted active language. With parameter `228`, it informed the player with the result of `TraderInterface:addItem(User)`, which was the literal `worked`. Otherwise it said `Greetings friend. Have a look at my wares.`, built a `MenuStruct`, added item IDs `1`, `228`, and `4`, and sent the menu.
- `receiveText` did not invoke the normal legacy trading or small-talk dispatchers. A message containing lowercase `greeting` called `useNPC(originator, nil, 0)`. It also maintained `NPCItem[originator.id]`; if that value was nonzero and the message contained lowercase `one` or `1`, it said `You just bought one of the following item: <English item name>` and reset the value to zero. No code in this file assigned a selected nonzero item, indicating the experiment was incomplete.
- `GetItems(User, ItemID, DataValue)` scanned equipment slots `{5, 6, 12, 13, 14, 15, 16, 17}` and the backpack. Equipped items required quality at least 100; backpack items did not. It returned matching `{item, bag}` records and stored the total quantity at index `0`. CSQN/shared trading does not expose this helper.
- `lookAtNpc` always sent the German description `Hier steht ein Fisch auf dem Flur.` regardless of player language, then called `common.InformNLS` with `#b|0|61|Hier können Infos und Hilfe stehen.` and `#b|0|62|Here you could read info and help.` CSQN localizes the look text but omits these two informational messages.

## Missing language, help, and timing behavior

- Accepted active languages were `{0, 1, 4}` (common, human, and lizard). Initialization raised all three skills to 100; accepted chat adopted the speaker's language and restored common (`0`) afterward. Unsupported speech produced the standard confused emote once until the 600-cycle reset.
- The intended English/German `help`/`hilfe` trade-command responses were registered but are missing from CSQN.
- The five intended idle lines were throttled by the randomized 900–3000-cycle `SpeakerCycle` delay. CSQN preserves their selection but not the explicit cooldown.

## Dormant intended trader behavior and differences

- The 17 trade items, 5000-copper reserve, prices, stock, quality, and durability are retained in trade JSON and `trading.lua`.
- The configured dialogue triggers and `AddTraderItem` calls existed, but the final `receiveText` path did not call `TellSmallTalk` or any normal trader operation. CSQN intentionally activates them.
- Eliza's currency vocabulary was character-specific: `Sssilber`, `sssilver`, `ssstücke`, and `piecesss`. Shared trading uses standard coin words.
- Refresh bounds were 10000–40000 cycles, while the shared legacy refill loop was commented out.
- Admin-only `status` exposed cash/delivery/stock data and `refill` attempted replenishment. Neither is ported.
- Unlike the conventional trader scripts, this final Eliza file contained no status 1–18 custom-response block. Reconstructing the experimental menu should therefore be treated separately from adding customizable shared trade messages.

## Needed CSQN/runtime additions

To reproduce the final Lua behavior, add menu-building actions with item-selection callbacks, per-player mutable state, inventory/equipment scanning, multi-message look actions, active-spoken-language conditions and skill setup, resettable confused state, cycle cooldowns, help triggers, per-trader currency vocabulary, and permission-gated trader administration.
