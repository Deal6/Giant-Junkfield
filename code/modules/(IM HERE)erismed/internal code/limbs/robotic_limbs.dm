//------------------//
// CONTENTS:
//  #Robotic
//	#Limbs
//	#Prosthetics
//	#Core
//------------------//

/obj/item/organ/external/robotic
	name = "robotic"
	force_icon = 'icons/mob/human_races/cyberlimbs/generic.dmi'
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	nerve_struck = -1 // no nerves here
	nature = MODIFICATION_SILICON
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = 15, bio = 100, rad = 100)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2) // Multiplied by w_class
	spawn_tags = SPAWN_TAG_PROSTHETIC
	bad_type = /obj/item/organ/external/robotic
	var/min_malfunction_damage = 20 // Any more damage than that and you start getting nasty random malfunctions
