# Gloarn porting notes

The CSQN preserves Gloarn's use responses, twelve idle lines, and all active small talk. The canonical pre-port implementation is `server/lua/npc/gloarn.lua` at commit `57581583b460194077d1825088feff9e873283e6` (retrieve with `git show 57581583:server/lua/npc/gloarn.lua`).

## Missing runtime behavior

- Gloarn accepted active languages `{0, 1, 4}` (common, human, and lizard), raised all three language skills to 100, and used common (`0`) by default. CSQN language conditions inspect the player's configured language instead.
- Unsupported speech produced `#me grinst dich blöde an` / `#me grins stupidly at you` once until the legacy 600-cycle reset.
- `BasicNPCChecks` introduced the NPC to the player and rejected speakers beyond range 2 or the NPC itself. The CSQN bridge retains range checking but does not reproduce every legacy side effect.
- Idle speech was throttled by `SpeakerCycle`: after each line it waited a random 900–3000 NPC cycles. CSQN records the random choice but not this cooldown.
- The “who/wer” responses interpolated `thisNPC.name`; the CSQN currently hardcodes `Gloarn`.
- Legacy trigger setup replaced literal spaces with `.+`, which is slightly more permissive than ordinary spaces in hand-written CSQN patterns.

## Needed CSQN/runtime additions

Add active-spoken-language conditions, language-skill setup, per-NPC/per-player resettable state for the confused emote, randomized cycle cooldowns, and context-field interpolation.

`testgnome.lua` is a separate gambling prototype despite also carrying a `--Name: Gloarn` comment. It was not the script referenced by the new NPC record and its stateful game was not part of this port. If that game is ever desired, it needs per-player state, exclusive-player locking, timeouts, random draws without replacement, inventory currency checks/removal/creation, and multi-message actions.
