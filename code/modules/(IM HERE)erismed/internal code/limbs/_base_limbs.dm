// This is a base file for all limbs thus all variables here will be inherited by all limbs in the game

// FOR YOUR CONVENIENCE - copy "#name" into CTRL+F for navigation
//------------------//
// CONTENTS:
//  #Limbs
//	#Core
//------------------//

/obj/item/limb/
	name = "coder limb"
	desc = "If you didn't kill any coders around here, you need to report it."
	bad_type = /obj/item/limb

	//DAMAGE VARS
	var/brute	= 0
	var/burn	= 0

	//SPRITE DRAW
	icon = 'icons/mob/human_races/r_human.dmi'
	var/icon_gender = NEUTER 			// Defines if we use for example head_m or head_f sprite
	var/icon/on_mob_icon				// Icon used for drawing in world mob (not item in hand)
	var/use_same_icon_for_item = TRUE	// If we use same icon for var/icon and on_mob_icon
	var/on_mob_icon_state
	var/left_or_right

	//SINS OF THE OLD
	var/generation_flags = ORGAN_HAS_BONES | ORGAN_HAS_BLOOD_VESSELS | ORGAN_HAS_MUSCLES | ORGAN_HAS_NERVES
	var/status

	bad_type = /obj/item/limb

/obj/item/limb/proc/get_mob_icon()
	if(on_mob_icon)
		return on_mob_icon

	var/gender_suffix
	switch(icon_gender)
		if(MALE)
			gender_suffix = "_m"
		if(FEMALE)
			gender_suffix = "_f"
		if(NEUTER)
			gender_suffix = "_we_don't_have_it_right_now"


	on_mob_icon = icon(icon, "[on_mob_icon_state][gender_suffix]")

	if(use_same_icon_for_item)
		icon = on_mob_icon

	return on_mob_icon

/obj/item/limb/head
	name = "head"
	on_mob_icon_state = "head"

/obj/item/limb/chest
	name = "chest"
	on_mob_icon_state = "chest"

/obj/item/limb/l_arm
	name = "left arm"
	on_mob_icon_state = "l_arm"
/obj/item/limb/r_arm
	name = "right arm"
	on_mob_icon_state = "r_arm"

/obj/item/limb/groin
	name = "groin"
	on_mob_icon_state = "groin"

/obj/item/limb/l_leg
	name = "left leg"
	on_mob_icon_state = "l_leg"
	left_or_right = LEFT
/obj/item/limb/r_leg
	name = "right leg"
	on_mob_icon_state = "r_leg"
	left_or_right = RIGHT
