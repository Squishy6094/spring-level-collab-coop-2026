add_level_data({
    name = (math.random(0, 100) == 69 and "Out Pik the Hut" or "Outset Wilds"),
    creator = "Kaktus64",
    id = LEVEL_THI,
    hubPos = {x = -750, y = 300, z = 1850},
    painting = 0,
    stars = {
        "CREATURE IN THE POT",
        "KOOPA THE SWIMMER",
        "SPARKLIUM COLLECTING",
        "EMERGENCE CAVERN",
        "CHILLY CREVASSE",
        "THE THIRD CAVE"
    },
})
create_streamed_sequence(SEQ_LEVEL_GRASS, "music-pikmin.ogg", {0*16000, 82.650*16000}, true, 1, 2.5)

smlua_text_utils_dialog_replace(DIALOG_008,1,6, 30, 200, -- TOAD 1 TEXT
"Hey, I heard that\
there's some hidden\
treasure around here...\
If you collect all 5, you\
might even get a star!...\
But I didn't tell you that.")

smlua_text_utils_dialog_replace(DIALOG_018, 1, 5, 30, 200, -- TOAD 2 TEXT
"Hey! You see that hole\
back there? I heard that\
it has a star inside of\
it. Personally, I'm too\
scared to go in...")

smlua_text_utils_dialog_replace(DIALOG_019, 1, 5, 30, 200, -- EMERGENT CAVERN TEXT
"EMERGENT CAVERN\
This cave is pretty\
simple, just try not\
to fall.\
-Captain Shroomar")

smlua_text_utils_dialog_replace(DIALOG_078, 1, 4, 30, 200, -- CHILLY CREVASSE TEXT
"CHILLY CREVASSE\
When I entered this cave,\
I was greeted by a huge,\
evil ice thing who tried\
to kill me! Luckily, I\
was able to escape before\
I met my demise.\
-Captain Shroomar")

smlua_text_utils_dialog_replace(DIALOG_151, 1, 4, 30, 200,
"OWWW!! Why'd you do\
that?! What did I even\
do?? I was just minding\
my business, and then\
you decide to stomp me!\
Now I'm really, really,\
REALLY mad!\
Waaaaaaaaaaaaaaaaa!!!")

smlua_text_utils_dialog_replace(DIALOG_168, 1, 3, 30, 200, 
"Hey! Knock it off! I've\
been having back problems\
recently!!")

smlua_text_utils_dialog_replace(DIALOG_152, 1, 4, 30, 200, 
"Oww! Owie!!\
Why'd you..\
You want my star?!\
Well why didn't you just\
ask?! I would've given\
it to you!! You just\
couldn't be bothered?!\
...Alright, here's your\
stupid star. See you\
later...")

gLevelValues.starPositions.WigglerStarPos.x = 3606
gLevelValues.starPositions.WigglerStarPos.y = 1228
gLevelValues.starPositions.WigglerStarPos.z = -3034

