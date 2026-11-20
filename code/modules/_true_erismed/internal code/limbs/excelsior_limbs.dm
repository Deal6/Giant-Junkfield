//------------------//
// CONTENTS:
//  #Excelsior
//	#Limbs
//	#Prosthetics
//------------------//

/obj/item/limb/robotic/excelsior
	name = "Excelsior"
	desc = "Plasma reinforced black prosthesis designed for heavy combat."
	// force_icon = 'icons/mob/human_races/cyberlimbs/excelsior.dmi'
	// model = "excelsior"
	armor = list(melee = 5, bullet = 5, energy = 5, bomb = 35, bio = 100, rad = 100)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTEEL = 1, MATERIAL_PLASMA = 0.5) //Plasma needed as a material that excelsiors can't teleport in
	// max_damage = 65
	// min_broken_damage = 45
	price_tag = 600
	spawn_blacklisted = TRUE
	bad_type = /obj/item/limb/robotic/excelsior
