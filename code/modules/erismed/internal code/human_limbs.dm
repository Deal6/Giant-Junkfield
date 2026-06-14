//------------------------------------------------------------------------------------------------------//
// This file consists all human limbs possible. I will kill you for putting different types elsewhere.

// FOR YOUR CONVENIENCE - copy "#name" into CTRL+F for navigation
// CONTENTS:
//  #Human Skeleton
//	#Prosthetics

// Base limb
/obj/item/limb/
	#warn generation_flags SUCK. Replace with something more understandable.
	var/generation_flags = ORGAN_HAS_BONES | ORGAN_HAS_BLOOD_VESSELS | ORGAN_HAS_MUSCLES | ORGAN_HAS_NERVES
	var/status

	bad_type = TRUE


//---------------------------//
// #Human Skeleton

/obj/item/limb/skeletal
	generation_flags = ORGAN_HAS_BONES

/obj/item/limb/skeletal/chest

/obj/item/limb/skeletal/groin

/obj/item/limb/skeletal/head

// #Prosthetics
/obj/item/limb/robotic/asters
	name = "Asters \"Movement Lock\""
	desc = "Generic gray prosthesis for everyday use."
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = 10, bio = 100, rad = 100)
	// force_icon = 'icons/mob/human_races/cyberlimbs/asters.dmi'
	// model = "asters"
	price_tag = 300
	bad_type = /obj/item/limb/robotic/asters

/obj/item/limb/robotic/serbian
	name = "\"Serbian Arms\""
	desc = "Battle hardened green and brown prosthesis, rebranded several times."
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = 10, bio = 100, rad = 100)
	// force_icon = 'icons/mob/human_races/cyberlimbs/serbian.dmi'
	// model = "serbian"
	price_tag = 600
	bad_type = /obj/item/limb/robotic/serbian

//In game prostheses
/obj/item/limb/robotic/frozen_star
	name = "\"Frozen Star\""
	desc = "Tactical \"Frozen Star\" blue and gray prosthesis for dangerous environment."
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = 10, bio = 100, rad = 100)
	// force_icon = 'icons/mob/human_races/cyberlimbs/frozen_star.dmi'
	// model = "frozen_star"
	price_tag = 450
	bad_type = /obj/item/limb/robotic/frozen_star

/obj/item/limb/robotic/frozen_star/l_arm

/obj/item/limb/robotic/frozen_star/r_arm

/obj/item/limb/robotic/frozen_star/l_leg

/obj/item/limb/robotic/frozen_star/r_leg

/obj/item/limb/robotic/technomancer
	name = "Technomancer \"Homebrew\""
	desc = "Technomancer \"branded\" \"functional\" prosthesis."
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = 10, bio = 100, rad = 100)
	// force_icon = 'icons/mob/human_races/cyberlimbs/technomancer.dmi'
	// model = "technomancer"
	price_tag = 700
	bad_type = /obj/item/limb/robotic/technomancer

/obj/item/limb/robotic/technomancer/l_arm


/obj/item/limb/robotic/technomancer/r_arm

/obj/item/limb/robotic/technomancer/l_leg

/obj/item/limb/robotic/technomancer/r_leg

/obj/item/limb/robotic/technomancer/groin

/obj/item/limb/robotic/technomancer/torso

/obj/item/limb/robotic/technomancer/head

/obj/item/limb/robotic/moebius
	name = "\"Moebius\""
	desc = "Streamlined, sleek, and sterile."
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = 10, bio = 100, rad = 100)
	// force_icon = 'icons/mob/human_races/cyberlimbs/moebius.dmi'
	// model = "moebius"
	price_tag = 250
	bad_type = /obj/item/limb/robotic/moebius

/obj/item/limb/robotic/moebius/l_arm

/obj/item/limb/robotic/moebius/r_arm

/obj/item/limb/robotic/moebius/l_leg

/obj/item/limb/robotic/moebius/r_leg

/obj/item/limb/robotic/moebius/groin

/obj/item/limb/robotic/moebius/torso

/obj/item/limb/robotic/moebius/head

/obj/item/limb/robotic/moebius/reinforced
	name = "\"Moebius\" R++"
	desc = "Reinforced purple and white prosthesis designed for space exploration and light combat."
	armor = list(melee = 3, bullet = 3, energy = 3, bomb = 20, bio = 100, rad = 100)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_PLASTEEL = 1)
	// max_damage = 60
	// min_broken_damage = 40
	price_tag = 300
	bad_type = /obj/item/limb/robotic/moebius/reinforced

/obj/item/limb/robotic/moebius/reinforced/l_arm

/obj/item/limb/robotic/moebius/reinforced/r_arm

/obj/item/limb/robotic/moebius/reinforced/l_leg

/obj/item/limb/robotic/moebius/reinforced/r_leg

/obj/item/limb/robotic/moebius/reinforced/groin

/obj/item/limb/robotic/moebius/reinforced/torso

/obj/item/limb/robotic/moebius/reinforced/head

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

/obj/item/limb/robotic/excelsior/l_arm

/obj/item/limb/robotic/excelsior/r_arm

/obj/item/limb/robotic/excelsior/l_leg

/obj/item/limb/robotic/excelsior/r_leg

/obj/item/limb/robotic/excelsior/groin

/obj/item/limb/robotic/excelsior/chest

/obj/item/limb/robotic/excelsior/head

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

/obj/item/limb/robotic/one_star/l_arm

/obj/item/limb/robotic/one_star/r_arm

/obj/item/limb/robotic/one_star/l_leg

/obj/item/limb/robotic/one_star/r_leg

/obj/item/limb/robotic/makeshift
	name = "Makeshift"
	desc = "Rust, rods, and bolts. A barely functional prosthetic made of whatever could be scavenged from maintenance."
	// force_icon = 'icons/mob/human_races/cyberlimbs/ghetto.dmi'
	armor = list(melee = 2, bullet = 2, energy = 2, bomb = -5, bio = 100, rad = 100)
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 1)
	// min_broken_damage = 30
	// min_malfunction_damage = 15
	bad_type = /obj/item/limb/robotic/makeshift

/obj/item/limb/robotic/makeshift/l_arm

/obj/item/limb/robotic/makeshift/r_arm

/obj/item/limb/robotic/makeshift/l_leg

/obj/item/limb/robotic/makeshift/r_leg

/obj/item/limb/robotic/makeshift/groin

/obj/item/limb/robotic/makeshift/chest
