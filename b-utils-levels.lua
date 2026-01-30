LEVEL_DATA = {}

function add_level_data(lvlData)
    table.insert(LEVEL_DATA, lvlData)
end

local function init_level_data()
    --- Init data
    for i = 1, #LEVEL_DATA do
        local data = LEVEL_DATA[i]
        if data.id ~= nil then
            local stars = data.stars or {}
            local course = get_level_course_num(data.id)
            local levelName = "#  "..string.upper(data.name)
            smlua_text_utils_course_acts_replace(course, levelName, stars[1] or "?", stars[2] or "?", stars[3] or "?", stars[4] or "?", stars[5] or "?", stars[6] or "?")
        end
    end
end
hook_event(HOOK_ON_MODS_LOADED, init_level_data)