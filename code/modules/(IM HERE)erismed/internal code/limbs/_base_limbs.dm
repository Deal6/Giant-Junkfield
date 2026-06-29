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
	var/left_or_right

	//SINS OF THE OLD
	var/generation_flags = ORGAN_HAS_BONES | ORGAN_HAS_BLOOD_VESSELS | ORGAN_HAS_MUSCLES | ORGAN_HAS_NERVES
	var/status

	bad_type = /obj/item/limb


/obj/item/limb/head
	name = "head"

/obj/item/limb/chest
	name = "chest"

/obj/item/limb/l_arm
	name = "left arm"
/obj/item/limb/r_arm
	name = "right arm"

/obj/item/limb/groin
	name = "groin"

/obj/item/limb/l_leg
	name = "left leg"
	left_or_right = LEFT
/obj/item/limb/r_leg
	name = "right leg"
	left_or_right = RIGHT
