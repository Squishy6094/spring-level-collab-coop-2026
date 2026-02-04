const BehaviorScript bhvToadMessage[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvToadMessage),
    OR_INT(oFlags, (OBJ_FLAG_PERSISTENT_RESPAWN | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    LOAD_ANIMATIONS(oAnimations, &toad_seg6_anims_0600FB58),
    ANIMATE(6),
    SET_INTERACT_TYPE(INTERACT_TEXT),
    SET_HITBOX(/*Radius*/ 80, /*Height*/ 100),
    SET_INT(oIntangibleTimer, 0),
    CALL_NATIVE(bhv_init_room),
    CALL_NATIVE(bhv_custom_toad_message_init),
    BEGIN_LOOP(),
        CALL_NATIVE(bhv_custom_toad_message_loop),
    END_LOOP(),
};

const BehaviorScript bhvBlargg[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    LOAD_ANIMATIONS(oAnimations, blargg_seg5_anims_0500616C),
    DROP_TO_FLOOR(),
    SET_HOME(),
    CALL_NATIVE(bhv_blargg_init),
    //SCALE(/*Unused*/ 0, /*Field*/ 150),
    BEGIN_LOOP(),
        SET_INT(oIntangibleTimer, 0),
        CALL_NATIVE(bhv_blargg_loop),
    END_LOOP(),
};

const BehaviorScript bhvRainbowNote[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvNewId),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    SET_INT(oIntangibleTimer, 0),
    SET_INT(oAnimState, -1),
    CALL_NATIVE(bhv_init_room),
    CALL_NATIVE(bhv_rainbow_note_init),
    BEGIN_LOOP(),
        CALL_NATIVE(bhv_rainbow_note_loop),
        ADD_INT(oAnimState, 1),
    END_LOOP(),
};

const BehaviorScript bhvQuestionCoin[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvNewId),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    SET_INT(oIntangibleTimer, 0),
    SET_INT(oAnimState, -1),
    CALL_NATIVE(bhv_init_room),
    CALL_NATIVE(bhv_question_coin_init),
    BEGIN_LOOP(),
        CALL_NATIVE(bhv_question_coin_loop),
        ADD_INT(oAnimState, 1),
    END_LOOP(),
};

const BehaviorScript bhvRainbowNote_StarSpawn[] = {
BEGIN(OBJ_LIST_GENACTOR),
ID(id_bhvNewId),
CALL_NATIVE(bhv_rainbownote_starspawn_init),
BEGIN_LOOP(),
CALL_NATIVE(bhv_rainbownote_starspawn_loop),
END_LOOP(),
};