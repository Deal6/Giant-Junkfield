//------------------//
// CONTENTS:
//  #Makeshift
//	#Limbs
//	#Prosthetics
//------------------//

/obj/item/limb/robotic/makeshift
	name = "Makeshift"
	desc = "Rust, rods, and bolts. A barely functional prosthetic made of whatever could be scavenged from maintenance."
	// force_icon = 'icons/mob/human_races/cyberlimbs/ghetto.dmi'
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = -5, bio = 100, rad = 100)
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 1)
	// min_broken_damage = 30
	// min_malfunction_damage = 15
	bad_type = /obj/item/limb/robotic/makeshift
