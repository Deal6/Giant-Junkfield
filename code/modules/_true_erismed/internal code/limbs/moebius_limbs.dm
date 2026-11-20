//------------------//
// CONTENTS:
//  #Moebius
//	#Limbs
//	#Prosthetics
//------------------//

/obj/item/limb/robotic/moebius
	name = "\"Moebius\""
	desc = "Streamlined, sleek, and sterile."
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = 10, bio = 100, rad = 100)
	// force_icon = 'icons/mob/human_races/cyberlimbs/moebius.dmi'
	// model = "moebius"
	price_tag = 250
	bad_type = /obj/item/limb/robotic/moebius

/obj/item/limb/robotic/moebius/reinforced
	name = "\"Moebius\" R++"
	desc = "Reinforced purple and white prosthesis designed for space exploration and light combat."
	armor = list(melee = 3, bullet = 3, energy = 3, bomb = 20, bio = 100, rad = 100)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_PLASTEEL = 1)
	// max_damage = 60
	// min_broken_damage = 40
	price_tag = 300
	bad_type = /obj/item/limb/robotic/moebius/reinforced
