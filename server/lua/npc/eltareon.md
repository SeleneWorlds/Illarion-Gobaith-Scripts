# Eltareon porting notes

The CSQN file preserves Eltareon's use responses, idle lines, and small-talk triggers. The canonical pre-port implementation is `server/lua/npc/eltareon.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/eltareon.lua`).

## Missing runtime behavior

- Spoken-language validation is absent. The Lua NPC accepted active languages `{0, 1}` (common and human), set `thisNPC.activeLanguage` to the speaker's active language, and only processed chat within range 2. Unsupported languages produced `#me sieht dich leicht verwirrt an` / `#me looks at you a little confused` once per reset period. `verwirrt` reset every 600 NPC cycles.
- Language proficiency initialization is absent. On first cycle the NPC raised its common- and human-language skills to 100 and selected common (`0`) as its default active language.
- Idle throttling is not represented by CSQN. `SpeakerCycle` selected one of the two idle pairs only after a randomized delay of 900–3000 NPC cycles, then selected another delay. `cycle: pick(...)` only records the text selection.
- The name replies originally interpolated `thisNPC.name`. CSQN hardcodes `Eltareon`; restoring interpolation should read `context.npc.name` (or an equivalent exposed field) at action execution time.
- Legacy trigger registration converted every literal space in a trigger to `.+`. The CSQN patterns intentionally preserve the useful matching behavior, but exact whitespace semantics may differ.

## Needed CSQN/runtime additions

To restore these features without a bespoke NPC script, add an active-spoken-language condition, a one-shot/resettable per-player or per-NPC state condition/action for the confused response, randomized cycle cooldown support, and text interpolation from context fields.

The commented-out history/chronicler code in the Lua source was inactive and was intentionally not treated as missing behavior.
