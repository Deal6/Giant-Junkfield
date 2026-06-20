//MOVE THESE HELPERS OUT INTO EXTERNAL ACCESS
if(Find(path, "/arm"))
/armed_forces

// BASE
/obj/item/limb/robotic/
	bad_type = TRUE
/obj/item/limb/robotic/head/
/obj/item/limb/robotic/l_arm/
/obj/item/limb/robotic/r_arm/
/obj/item/limb/robotic/l_leg/
/obj/item/limb/robotic/r_leg/
/obj/item/limb/robotic/groin/





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
/obj/item/limb/robotic/excelsior/head
/obj/item/limb/robotic/excelsior/chest
/obj/item/limb/robotic/excelsior/l_arm
/obj/item/limb/robotic/excelsior/r_arm
/obj/item/limb/robotic/excelsior/l_leg
/obj/item/limb/robotic/excelsior/r_leg
/obj/item/limb/robotic/excelsior/groin


//flesh
/obj/item/limb/head




/obj/item/limb/chest
/obj/item/limb/l_arm
/obj/item/limb/r_arm




/obj/item/limb/groin
/obj/item/limb/l_leg
/obj/item/limb/r_leg
