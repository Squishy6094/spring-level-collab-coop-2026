-- Overwrite Default Functions
local og_hud_hide = hud_hide
local og_hud_show = hud_show
local og_hud_is_hidden = hud_is_hidden
local og_hud_get_value = hud_get_value
local og_hud_set_value = hud_set_value

local collabHud = true
local collabFlags = HUD_DISPLAY_FLAGS_COIN_COUNT | HUD_DISPLAY_FLAG_STAR_COUNT | HUD_DISPLAY_FLAG_POWER | HUD_DISPLAY_FLAG_LIVES

local function collab_hud_hide()
    collabHud = false
    og_hud_hide()
end
local function collab_hud_show()
    collabHud = true
    og_hud_show()
end
local function collab_hud_is_hidden()
    return not collabHud and og_hud_is_hidden()
end
local function collab_hud_get_value(type)
    if type == HUD_DISPLAY_FLAGS then
        return og_hud_get_value(type) & ~collabFlags
    else
        return og_hud_get_value(type)
    end
end
local function collab_hud_set_value(type, value)
    if type == HUD_DISPLAY_FLAGS then
        collabFlags = value
    else
        og_hud_set_value(type, value)
    end
end

_G.hud_hide = collab_hud_hide
_G.hud_show = collab_hud_show
_G.hud_is_hidden = collab_hud_is_hidden
_G.hud_get_value = collab_hud_get_value
_G.hud_set_value = collab_hud_set_value

local saveFile = get_current_save_file_num() - 1
local TEX_COIN = get_texture_info("coin_seg3_texture_03005F80")

local idleTimer = 0
local starsTrans = 0
local function hud_render()
    if not collabHud then return end
    local m = gMarioStates[0]
    og_hud_hide()
    djui_hud_set_resolution(RESOLUTION_N64)
    local screenWidth = djui_hud_get_screen_width() - 1
    local screenHeight = djui_hud_get_screen_height()

    -- Render Meter
    djui_hud_set_color(255, 255, 255, 255)
    hud_render_power_meter(m.health, 5, 5, 64, 64)
    -- Render Coins
    djui_hud_set_color(255, 255, 0, 255)
    djui_hud_render_texture(TEX_COIN, 10, screenHeight - 42, 1, 1)
    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_print_text(tostring(m.numCoins), 26, screenHeight - 26, 1)

    local lvlData = nil
    for i = 1, #LEVEL_DATA do
        if LEVEL_DATA[i].id == gNetworkPlayers[0].currLevelNum then
            lvlData = LEVEL_DATA[i]
        end
    end

    if lvlData then
        local y = 10
        starsTrans = math.lerp(starsTrans, idleTimer > 90 and 255 or 127, 0.1)
        if m.action & ACT_FLAG_ALLOW_FIRST_PERSON ~= 0 and (m.forwardVel < 1) then
            idleTimer = idleTimer + 1
        else
            idleTimer = 0
        end
        if lvlData.stars and collabFlags & HUD_DISPLAY_FLAG_STAR_COUNT ~= 0 then
            for i = 1, #lvlData.stars do
                if save_file_get_star_flags(saveFile, gNetworkPlayers[0].currCourseNum - 1) & (1 << (i - 1)) ~= 0 then
                    djui_hud_set_color(255, 255, 255, starsTrans)
                else
                    djui_hud_set_color(0, 0, 0, starsTrans*0.5)
                end
                djui_hud_render_texture(gTextures.star, screenWidth - 21, y, 1, 1)
                local starName = lvlData.stars[i]
                djui_hud_set_font(djui_menu_get_font())
                djui_hud_set_color(0, 0, 0, math.max(starsTrans - 127, 0)*2)
                djui_hud_print_text(starName, screenWidth - djui_hud_measure_text(starName)*0.5 - 31 + 1, y + 1, 0.5)
                djui_hud_set_color(255, 255, 255, math.max(starsTrans - 127, 0)*2)
                djui_hud_print_text(starName, screenWidth - djui_hud_measure_text(starName)*0.5 - 31, y, 0.5)
                y = y + 21
            end
        end
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, hud_render)
