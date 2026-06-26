//------------------//
// CONTENTS:
//  #One star
//	#Limbs
//	#Prosthetics
//------------------//

/obj/item/limb/robotic/one_star
	name = "One star"
	desc = "Advanced, extremely resilient and mobile prosthetic. Inscribed with \"Made in\" followed by gibberish, must have been lost to time."
	// force_icon = 'icons/mob/human_races/cyberlimbs/one_star.dmi'
	// model = "one_star"
	armor = list(melee = 10, bullet = 10, energy = 10, bomb = 50, bio = 100, rad = 100)
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 4, MATERIAL_GOLD = 2)
	// max_damage = 70
	// min_broken_damage = 45
	spawn_blacklisted = TRUE
	rarity_value = 10
	spawn_frequency = 10
	spawn_tags = SPAWN_TAG_PROSTHETIC_OS
	bad_type = /obj/item/limb/robotic/one_star
	price_tag = 900
