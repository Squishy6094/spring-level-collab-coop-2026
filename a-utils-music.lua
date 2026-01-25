
local INV_127 = 1 / 127

local sSeqToAudioStream = {}

local SOUND_MAX = SOUND_OBJ2_MRI_SPINNING

local sSoundToSample = {}

local activeStreams = {}

function stop_stream_for_seq_player(player)
    local entry = activeStreams[player]
    if entry and entry.audio then
        audio_stream_pause(entry.audio)
        audio_stream_stop(entry.audio)
        activeStreams[player] = nil
    end
end

local function on_seq_load(player, seq)
    stop_stream_for_seq_player(player)

    local stream = sSeqToAudioStream[seq]
    if not stream then
        return
    end

    local a = audio_stream_load(stream.filename)
    if stream.loopPoints then
        audio_stream_set_looping(a, true)

        if type(stream.loopPoints) == "table" and stream.loopPoints[1] and stream.loopPoints[2] then
            audio_stream_set_loop_points(a, stream.loopPoints[1], stream.loopPoints[2])
        end
    end
    audio_stream_play(a, true, stream.volume)

    activeStreams[player] = { audio = a, stream = stream, speed = stream.speed}
    return 0
end

local function streamed_audio_update()
    local masterVol = get_volume_level() * INV_127

    for player, entry in pairs(activeStreams) do
        local fadeVol = sequence_player_get_fade_volume(player)
        local vol = (masterVol * fadeVol)

        local speed = entry.speed or 1

        if is_game_paused() then
            if gNetworkPlayers[0].currCourseNum == COURSE_NONE then
                vol = vol * 0.25
            else
                speed = 0.01 --can't put 0
                vol = 0
            end
        end

        audio_stream_set_frequency(entry.audio, speed)
        audio_stream_set_volume(entry.audio, entry.stream.volume * vol)
    end
end

real_stop_sound = stop_sound

local function stop_sound_modded(sound, pos)

    real_stop_sound(sound, pos)

    local sample = sSoundToSample[sound]
    if sample and sample.audio then
        local storedPos = sample.pos
        if storedPos and vec3f_dist(pos, storedPos) == 0 then
            audio_sample_stop(sample.audio)
            sample.audio = nil
            sample.pos   = nil
            return
        end
    end
end

_G.stop_sound = stop_sound_modded

-- this is for sound overrides
local function on_play_sound(sound, pos)
    local sample = sSoundToSample[sound]
    if sample then
        if not sample.audio then
            sample.audio = audio_sample_load(sample.filename)
        end

        local obj = get_current_object() or gMarioStates[0].marioObj

        local playPos = gVec3fZero()
        vec3f_copy(playPos, obj.header.gfx.pos)

        audio_sample_play(sample.audio, playPos, sample.volume * (get_volume_sfx() * INV_127))

        sample.pos = { x = pos.x, y = pos.y, z = pos.z }

        return 0
    end
end

local function on_packet_receive(data)
    if data.sound and data.x and data.y and data.z then
        local sound = data.sound
        local pos = {x = data.x, y = data.y, z = data.z}
        local sample = sSoundToSample[sound]

        if sample then
            play_sample(sound, pos)
        else
            play_sound(sound, pos)
        end
    end
end

local function on_warps(type)
    stop_all_samples()
end

hook_event(HOOK_ON_LEVEL_INIT, on_warps)
hook_event(HOOK_ON_WARP, on_warps)
hook_event(HOOK_UPDATE, streamed_audio_update)
hook_event(HOOK_ON_SEQ_LOAD, on_seq_load)
hook_event(HOOK_ON_PLAY_SOUND, on_play_sound)
hook_event(HOOK_ON_PACKET_RECEIVE, on_packet_receive)

---------------------------------------------------------

-- use this to play your samples
function play_sample(sound, pos)
    local sample = sSoundToSample[sound]
    if sample then
        if not sample.audio then
            sample.audio = audio_sample_load(sample.filename)
        end
        audio_sample_play(sample.audio, pos, sample.volume * (get_volume_sfx() * INV_127))
    end
end

function network_play_sound_or_sample(reliable, sound, pos)
    network_send(reliable, {sound = sound, x = pos.x, y = pos.y, z = pos.z})

    local sample = sSoundToSample[sound]

    if sample then
        play_sample(sound, pos)
    else
        play_sound(sound, pos)
    end
end

function stop_all_streams()
    stop_stream_for_seq_player(SEQ_PLAYER_LEVEL)
    stop_stream_for_seq_player(SEQ_PLAYER_ENV)
end

function get_audio_stream_from_seq_player(player)
    return activeStreams[player]
end

function create_streamed_sequence(seqID, fileName, loopPoints, override, speed, volume)
    local id = override and seqID or (seqID + SEQ_COUNT)
    sSeqToAudioStream[id] = {}
    sSeqToAudioStream[id].filename = fileName
    sSeqToAudioStream[id].loopPoints = loopPoints
    sSeqToAudioStream[id].speed = speed or 1
    sSeqToAudioStream[id].volume = volume or 1
    return id
end

function create_new_audio_sample(soundID, fileName, override, volume)
    local id = override and soundID or (soundID + SOUND_MAX)
    sSoundToSample[id] = {}
    sSoundToSample[id].filename = fileName
    sSoundToSample[id].volume = volume or 1
    return id
end

function stop_all_samples()
    for soundId, sample in pairs(sSoundToSample) do
        if sample.audio then
            audio_sample_stop(sample.audio)
            sample.audio = nil
            sample.pos   = nil
        end
    end
end