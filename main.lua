-- name: Spring Level Collab 2026
-- incompatible: romhack

gLevelValues.exitCastleLevel = LEVEL_CASTLE_GROUNDS
gLevelValues.exitCastleArea = 1
gLevelValues.exitCastleWarpNode = 0x0A
gLevelValues.entryLevel = LEVEL_CASTLE_GROUNDS
gLevelValues.fixCollisionBugs = true
gLevelValues.disableActs = true

-- Ensure you're always in grounds
local function warp_to_hub()
    warp_to_level(LEVEL_CASTLE_GROUNDS, 1, 0)
end
hook_event(HOOK_ON_PAUSE_EXIT, warp_to_hub)