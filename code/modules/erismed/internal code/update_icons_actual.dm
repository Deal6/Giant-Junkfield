#warn understand proc MapColors, dont delete warn until understood

// relevant info in [human_defines.dm]


var/global/list/human_icon_cache = list()

var/global/list/light_overlay_cache = list()



//Human Overlays Indexes/////////
#define SKELETON_LAYER	1
#define MEAT_LAYER		2

#define DAMAGE_LAYER 3
#define SURGERY_LAYER 4
#define IMPLANTS_LAYER 5
#define UNDERWEAR_LAYER 6
#define UNIFORM_LAYER 7
#define ID_LAYER 8
#define SHOES_LAYER 9
#define GLOVES_LAYER 10
#define BELT_LAYER 11
#define SUIT_LAYER 12
#define TAIL_LAYER 13
#define GLASSES_LAYER 14
#define BELT_LAYER_ALT 15
#define BACK_LAYER 16
#define SUIT_STORE_LAYER 17
#define HAIR_LAYER 18
#define L_EAR_LAYER 19
#define R_EAR_LAYER 20
#define FACEMASK_LAYER 21
#define HEAD_LAYER 22
#define COLLAR_LAYER 23
#define HANDCUFF_LAYER 24
#define LEGCUFF_LAYER 25
#define L_HAND_LAYER 26
#define R_HAND_LAYER 27
#define FIRE_LAYER 28
#define BLOCKING_LAYER 29
#define TOTAL_LAYERS 29

// ------------------------------------//
#warn crutch
/obj/item/limb/update_icon()				//
// 	var/gender = "_m"								//
// 	gender = owner.gender == FEMALE ? "_f" : "_m"	//
// 	if(organ_tag)
// 		icon = 'icons/mob/human_races/r_human.dmi'
// 		icon_state = "[organ_tag][gender]"





// 	var/mob_icon = new/icon(icon, icon_state)


// 	if(skin_tone)
// 		if(skin_tone >= 0)
// 			mob_icon.Blend(rgb(skin_tone, skin_tone, skin_tone), ICON_ADD)
// 		else
// 			mob_icon.Blend(rgb(-skin_tone,  -skin_tone,  -skin_tone), ICON_SUBTRACT)
// 	else
// 		if(skin_col)
// 			mob_icon.Blend(skin_col, ICON_ADD)

// #warn what? figure out why EAST
// 	// dir = EAST
// 	icon = mob_icon
// ------------------------------------//

/mob/living/carbon/human/
	#warn debug: 2 lines hack graaaaaaa
	icon = 'icons/mob/human.dmi'
	icon_state = "human_meat"

	var/list/overlays_standing[TOTAL_LAYERS]
	var/previous_damage_appearance // store what the body last looked like, so we only have to update it if something changed
	var/list/crutch_limb_list = list()

//////////////////////////////////

/mob/living/carbon/human/update_icons()
	overlays.Cut()



#warn debug
	// if (icon_update)
	icon = stand_icon
	for(var/image/I in overlays_standing)
		overlays += I
	if(species.glowing_in_the_dark_eyes)
		overlays |= species.get_eyes(src)





	if(lying) //Only rotate them if we're not drawing a specific icon for being prone.
		var/matrix/M = matrix()
		M.Turn(90)
		M.Scale(size_multiplier)
		M.Translate(1,-6)
		src.transform = M
	else
		var/matrix/M = matrix()
		M.Scale(size_multiplier)
		M.Translate(0, 16*(size_multiplier-1))
		src.transform = M
	..()

var/global/list/damage_icon_parts = list()

//-----------------------------------------------------------------//
/mob/living/carbon/human/proc/update_skeleton_layer()	// r_skeleton.dmi
	var/icon/skeleton = image('icons/mob/human.dmi',icon_state = "skeleton")
	overlays_standing[SKELETON_LAYER] += skeleton

/mob/living/carbon/human/proc/update_meat_layer()	// human.dmi
	var/icon/meat = image('icons/mob/human.dmi',icon_state = "human_meat")
	overlays_standing[MEAT_LAYER] += meat
//-----------------------------------------------------------------//
/mob/living/carbon/human/update_mutations(var/update_icons=1)
	return

	// var/image/standing = image("icon" = 'icons/effects/genetics.dmi')
	// var/add_image = 0
	// if(add_image)
	// 	overlays_standing[MUTATIONS_LAYER] = standing
	// else
	// 	overlays_standing[MUTATIONS_LAYER] = null
	// if(update_icons)
	// 	update_icons()

//////////////////////////////////


/mob/living/carbon/human/UpdateDamageIcon(var/update_icons=1)

	var/damage_appearance = ""

	for(var/obj/item/limb/limb in organs)
		if(limb.is_stump())
			continue
		damage_appearance += limb.damage_state

	if(damage_appearance == previous_damage_appearance)
		// nothing to do here
		return

	previous_damage_appearance = damage_appearance

	var/image/standing_image = image(species.damage_overlays, icon_state = "00")

	// blend the individual damage states with our icons
	if(species.blood_color)
		for(var/obj/item/limb/limb in organs)
			if(limb.is_stump())
				continue

			limb.update_damstate()
			if(limb.damage_state == "00") continue
			var/icon/dmg_icon
			var/cache_index = "[limb.damage_state]/[limb.organ_tag]/[species.blood_color]/[species.get_bodytype()]"
			if(damage_icon_parts[cache_index] == null)
				dmg_icon = new /icon(species.damage_overlays, limb.damage_state)			// the damage icon for whole human
				dmg_icon.Blend(new /icon(species.damage_mask, limb.organ_tag), ICON_MULTIPLY)	// mask with this organ's pixels
				dmg_icon.Blend(species.blood_color, ICON_MULTIPLY)
				damage_icon_parts[cache_index] = dmg_icon
			else
				dmg_icon = damage_icon_parts[cache_index]

			standing_image.overlays += dmg_icon

	overlays_standing[DAMAGE_LAYER] = standing_image

	if(update_icons)
		update_icons()


//DAMAGE OVERLAYS
//constructs damage icon for each organ from mask * damage field and saves it in our overlays_ lists

#warn
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

//BASE MOB SPRITE AKA NAKED HUMAN
/mob/living/carbon/human/proc/update_body(var/update_icons=1)

// 	//Create a new, blank icon for our mob to use.
// 	if(stand_icon)
// 		qdel(stand_icon)

// 		stand_icon = new('icons/mob/human.dmi',"blank")
// 			for(var/organ_tag in species.has_limbs)
// 				var/obj/item/limb/part = organs_by_name[organ_tag]
// 				if(isnull(part))
// 					continue
// 				// NOTE: limbs themselves HOLD an "icon_position" value.
// 				//That part makes left and right legs drawn topmost and lowermost when human looks WEST or EAST
// 				//And no change in rendering for other parts (they icon_position is 0, so goes to 'else' part)
// 				if(part.icon_position&(LEFT|RIGHT))
// 					var/icon/blank_human = new('icons/mob/human.dmi',"blank")
// 					blank_human.Insert(new/icon(temp,dir=NORTH),dir=NORTH)
// 					blank_human.Insert(new/icon(temp,dir=SOUTH),dir=SOUTH)
// 					if(!(part.icon_position & LEFT))
// 						blank_human.Insert(new/icon(temp,dir=EAST),dir=EAST)
// 					if(!(part.icon_position & RIGHT))
// 						blank_human.Insert(new/icon(temp,dir=WEST),dir=WEST)
// 					base_icon.Blend(blank_human, ICON_OVERLAY)
// 					if(part.icon_position & LEFT)
// 						blank_human.Insert(new/icon(temp,dir=EAST),dir=EAST)
// 					if(part.icon_position & RIGHT)
// 						blank_human.Insert(new/icon(temp,dir=WEST),dir=WEST)
// 					base_icon.Blend(blank_human, ICON_UNDERLAY)
// 				else
// 					base_icon.Blend(temp, ICON_OVERLAY)

// 		//END CACHED ICON GENERATION.
// 		stand_icon.Blend(base_icon,ICON_OVERLAY)

// 	if(update_icons)
// 		update_icons()

// //UNDERWEAR OVERLAY

/mob/living/carbon/human/proc/update_underwear(var/update_icons=1)
	overlays_standing[UNDERWEAR_LAYER] = null

	if(species.appearance_flags & HAS_UNDERWEAR)
		var/icon/underwear = new/icon(get_gender_icon(gender, "underwear"), "blank")
		for(var/element in worn_underwear)
			var/obj/item/underwear/UW = element
			var/icon/I = new /icon(get_gender_icon(gender, "underwear"), UW.icon_state)
			if(UW.color)
				I.Blend(UW.color, ICON_ADD)
			underwear.Blend(I, ICON_OVERLAY)
		overlays_standing[UNDERWEAR_LAYER] = image(underwear)
	if(update_icons)
		update_icons()

//HAIR OVERLAY
/mob/living/carbon/human/proc/update_hair(var/update_icons=1)
	// //Reset our hair
	// overlays_standing[HAIR_LAYER]	= null

	// // var/obj/item/limb/head/head_organ = get_organ(BP_HEAD)
	// if(!head_organ || head_organ.is_stump() )
	// 	if(update_icons)
	// 		update_icons()
	// 	return

	//masks and helmets can obscure our hair.
	if( (head && (head.flags_inv & BLOCKHAIR)) || (wear_mask && (wear_mask.flags_inv & BLOCKHAIR)))
		if(update_icons)   update_icons()
		return

	//base icons
	var/icon/face_standing = new /icon('icons/mob/hair.dmi',"bald")

	if(f_style && !(wear_mask && (wear_mask.flags_inv & BLOCKFACEHAIR)))
		var/datum/sprite_accessory/facial_hair_style = GLOB.facial_hair_styles_list[f_style]
		if(facial_hair_style && facial_hair_style.species_allowed && (src.species.get_bodytype() in facial_hair_style.species_allowed))
			var/icon/facial_s = new/icon(facial_hair_style.icon, facial_hair_style.icon_state)
			if(facial_hair_style.do_colouration)
				facial_s.Blend(facial_color, ICON_ADD)

			face_standing.Blend(facial_s, ICON_OVERLAY)

	if(h_style && !(head && (head.flags_inv & BLOCKHEADHAIR)))
		var/datum/sprite_accessory/hair/hair_style = GLOB.hair_styles_list[h_style]
		if(hair_style && (src.species.get_bodytype() in hair_style.species_allowed))
			var/icon/hair_s = new/icon(hair_style.icon, hair_style.icon_state)
			if(hair_style.do_colouration)
				hair_s.Blend(hair_color, ICON_ADD)

			face_standing.Blend(hair_s, ICON_OVERLAY)

	overlays_standing[HAIR_LAYER]	= image(face_standing)

	if(update_icons)   update_icons()



/mob/proc/update_implants(var/update_icons = 1)
	return

/mob/living/carbon/human/update_implants(var/update_icons = 1)
	var/image/standing = image('icons/mob/mob.dmi', "blank")
	var/have_icon = FALSE
	for(var/obj/item/implant/I in src)
		if(I.is_external() && I.wearer == src)
			var/image/mob_icon = I.get_mob_overlay(gender)
			if(mob_icon)
				standing.overlays += mob_icon
				have_icon = TRUE

	if(have_icon)
		overlays_standing[IMPLANTS_LAYER] = standing
	else
		overlays_standing[IMPLANTS_LAYER] = null

	if(update_icons) update_icons()

/* --------------------------------------- */
//For legacy support.
/mob/living/carbon/human/regenerate_icons()
	..()
	if(HasMovementHandler(/datum/movement_handler/mob/transformation) || QDELETED(src))		return
	update_skeleton_layer()
	update_meat_layer()
	update_mutations(0)
	update_implants(0)
	update_body(0)
	#warn
	// update_underwear(0)
	update_hair(0)
	update_hud()//Hud Stuff
	update_inv_w_uniform(0)
	update_inv_wear_id(0)
	update_inv_gloves(0)
	update_inv_glasses(0)
	update_inv_ears(0)
	update_inv_shoes(0)
	update_inv_s_store(0)
	update_inv_wear_mask(0)
	update_inv_head(0)
	update_inv_belt(0)
	update_inv_back(0)
	update_inv_wear_suit(0)
	update_inv_r_hand(0)
	update_inv_l_hand(0)
	update_inv_handcuffed(0)
	update_inv_legcuffed(0)
	update_inv_pockets(0)
	update_fire(0)
	update_surgery(0)
	UpdateDamageIcon()
	update_icons()

/* --------------------------------------- */

// Contained sprite defines
#define WORN_LHAND	"_lh"
#define WORN_RHAND	"_rh"
#define WORN_LSTORE	"_ls"
#define WORN_RSTORE "_rs"
#define WORN_SSTORE "_ss"
#define WORN_LEAR 	"_le"
#define WORN_REAR 	"_re"
#define WORN_HEAD 	"_he"
#define WORN_UNDER 	"_un"
#define WORN_SUIT 	"_su"
#define WORN_GLOVES	"_gl"
#define WORN_SHOES	"_sh"
#define WORN_EYES	"_ey"
#define WORN_BELT	"_be"
#define WORN_BACK	"_ba"
#define WORN_ID		"_id"
#define WORN_MASK	"_ma"


//gender icons
/mob/living/carbon/human/proc/get_gender_icon(var/g = MALE, var/slot)
	var/list/icons = list(
		"uniform"		= (g == MALE) ? 'icons/inventory/uniform/mob.dmi' : 'icons/inventory/uniform/mob_fem.dmi',
		"suit"			= (g == MALE) ? 'icons/inventory/suit/mob.dmi' : 'icons/inventory/suit/mob_fem.dmi',
		"gloves"		= 'icons/inventory/hands/mob.dmi',
		"glasses"		= 'icons/inventory/eyes/mob.dmi',
		"ears"			= 'icons/inventory/ears/mob.dmi',
		"mask"			= 'icons/inventory/face/mob.dmi',
		"hat"			= 'icons/inventory/head/mob.dmi',
		"shoes"			= 'icons/inventory/feet/mob.dmi',
		"misk"			= 'icons/mob/mob.dmi',
		"belt"			= 'icons/inventory/belt/mob.dmi',
		"s_store"		= 'icons/inventory/on_suit/mob.dmi',
		"backpack"		= 'icons/inventory/back/mob.dmi',
		"underwear"		= 'icons/inventory/underwear/mob.dmi'
		)
	return icons[slot]

//contained sprite gender icons
/mob/living/carbon/human/proc/get_gender_icon_contained(var/g = MALE)
	if (g == FEMALE)
		return "_f"
	else
		return

//vvvvvv UPDATE_INV PROCS vvvvvv

/mob/living/carbon/human/update_inv_w_uniform(var/update_icons=1)
	overlays_standing[UNIFORM_LAYER]	= null
	if(check_draw_underclothing())
		//determine the icon to use
		var/icon/under_icon
		var/under_state = ""

		if(w_uniform.contained_sprite)//Do all the containedsprite stuff in one place
			if(w_uniform.icon_override)
				under_icon = w_uniform.icon_override
			else
				under_icon = w_uniform.icon

			under_state += w_uniform.icon_state + WORN_UNDER + get_gender_icon_contained(gender)

		else if(w_uniform.icon_override)
			under_icon = w_uniform.icon_override
		else
			under_icon = get_gender_icon(gender, "uniform")

		//determine state to use
		if (!under_state)
			if(w_uniform.item_state_slots && w_uniform.item_state_slots[slot_w_uniform_str])
				under_state = w_uniform.item_state_slots[slot_w_uniform_str]
			else if(w_uniform.icon_state)
				under_state = w_uniform.icon_state
			else
				under_state = w_uniform.item_state

		//need to append _s to the icon state for legacy compatibility
		var/image/standing = image(icon = under_icon, icon_state = under_state)
		standing.color = w_uniform.color

		//apply blood overlay
		if(w_uniform.blood_DNA)
			var/image/bloodsies	= image(icon = species.blood_mask, icon_state = "uniformblood")
			bloodsies.color		= w_uniform.blood_color
			standing.overlays	+= bloodsies

		//accessories
		if (istype(w_uniform, /obj/item/clothing/under))//Prevent runtime errors with unusual objects
			var/obj/item/clothing/under/under = w_uniform
			if(under.accessories.len)
				for(var/obj/item/clothing/accessory/A in under.accessories)
					standing.overlays |= A.get_mob_overlay()

		overlays_standing[UNIFORM_LAYER]	= standing

	if(update_icons)
		update_icons()

/mob/living/carbon/human/update_inv_wear_id(var/update_icons=1)
	overlays_standing[ID_LAYER]	= null
	if(wear_id)

		if(w_uniform && w_uniform:displays_id)
			if(wear_id.contained_sprite)
				var/image/standing
				if(wear_id.icon_override)
					standing = image("icon" = wear_id.icon_override, "icon_state" = "[icon_state]")

				else
					standing = wear_id.icon

				overlays_standing[ID_LAYER] = standing
			else
				overlays_standing[ID_LAYER]	= image("icon" = 'icons/mob/mob.dmi', "icon_state" = "id")


	BITSET(hud_updateflag, ID_HUD)
	BITSET(hud_updateflag, WANTED_HUD)

	if(update_icons)   update_icons()

/mob/living/carbon/human/update_inv_gloves(var/update_icons=1)
	overlays_standing[GLOVES_LAYER]	= null
	if(check_draw_gloves())

		var/t_state = gloves.icon_state
		if(!t_state)	t_state = gloves.item_state

		var/image/standing
		if(gloves.contained_sprite)
			var/state = ""
			state += "[gloves.item_state][WORN_GLOVES]"

			if(gloves.icon_override)
				standing = image("icon" = gloves.icon_override, "icon_state" = state)
			else
				standing = image("icon" = gloves.icon, "icon_state" = state)
		else if(gloves.icon_override)
			standing = image(icon = gloves.icon_override, icon_state = t_state)

		else
			standing = image(icon = get_gender_icon(gender, "gloves"), icon_state = t_state)

		if(gloves.blood_DNA)
			var/image/bloodsies	= image("icon" = species.blood_mask, "icon_state" = "bloodyhands")
			bloodsies.color = gloves.blood_color
			standing.overlays	+= bloodsies
		standing.color = gloves.color
		overlays_standing[GLOVES_LAYER]	= standing
	else
		if(blood_DNA)
			var/image/bloodsies	= image("icon" = species.blood_mask, "icon_state" = "bloodyhands")
			bloodsies.color = hand_blood_color
			overlays_standing[GLOVES_LAYER]	= bloodsies

	if(update_icons)   update_icons()


/mob/living/carbon/human/update_inv_glasses(var/update_icons=1)
	overlays_standing[GLASSES_LAYER] = null
	if(check_draw_glasses())
		if(glasses.contained_sprite)
			var/state = ""
			state += "[glasses.item_state][WORN_EYES]"

			if(glasses.icon_override)
				overlays_standing[GLASSES_LAYER] = image("icon" = glasses.icon_override, "icon_state" = state)
			else
				overlays_standing[GLASSES_LAYER] = image("icon" = glasses.icon, "icon_state" = state)

		else if (glasses.icon_override)
			overlays_standing[GLASSES_LAYER] = image(icon = glasses.icon_override,   icon_state = glasses.icon_state)

		else
			overlays_standing[GLASSES_LAYER] = image(icon = get_gender_icon(gender, "glasses"), icon_state = glasses.icon_state)

	if(update_icons)   update_icons()


/mob/living/carbon/human/update_inv_ears(var/update_icons=1)
	overlays_standing[L_EAR_LAYER] = null
	overlays_standing[R_EAR_LAYER] = null

	if (!check_draw_ears())
		if(update_icons)   update_icons()
		return

	else
		if(l_ear)
			var/t_type = l_ear.icon_state
			if(l_ear.contained_sprite)
				t_type = ""
				t_type += "[l_ear.item_state][WORN_LEAR]"
				if(l_ear.icon_override)
					overlays_standing[L_EAR_LAYER] = image(icon = l_ear.icon_override, icon_state = t_type)
				else
					overlays_standing[L_EAR_LAYER] = image(icon = l_ear.icon, icon_state = t_type)
			else if(l_ear.icon_override)
				t_type = "[t_type]_l"
				overlays_standing[L_EAR_LAYER] = image(icon = l_ear.icon_override, icon_state = t_type)

			else
				overlays_standing[L_EAR_LAYER] = image(icon = get_gender_icon(gender, "ears"), icon_state = t_type)

		if(r_ear)
			var/t_type = r_ear.icon_state
			if(r_ear.contained_sprite)
				t_type = ""
				t_type += "[r_ear.item_state][WORN_REAR]"
				if(r_ear.icon_override)
					overlays_standing[R_EAR_LAYER] = image(icon = r_ear.icon_override, icon_state = t_type)
				else
					overlays_standing[R_EAR_LAYER] = image(icon = r_ear.icon, icon_state = t_type)

			else if(r_ear.icon_override)
				t_type = "[t_type]_r"
				overlays_standing[R_EAR_LAYER] = image(icon = r_ear.icon_override, icon_state = t_type)

			else
				overlays_standing[R_EAR_LAYER] = image(icon = get_gender_icon(gender, "ears"), icon_state = t_type)

	if(update_icons)   update_icons()

/mob/living/carbon/human/update_inv_shoes(var/update_icons=1)
	overlays_standing[SHOES_LAYER] = null
	if(check_draw_shoes())
		var/image/standing
		if(shoes.contained_sprite)
			var/state = ""
			state += "[shoes.item_state][WORN_SHOES]"

			if(shoes.icon_override)
				standing = image(icon = shoes.icon_override, icon_state = state)
			else
				standing = image(icon = shoes.icon, icon_state = state)

		else if(shoes.icon_override)
			standing = image(icon = shoes.icon_override,   icon_state = shoes.icon_state)

		else
			standing = image(icon = get_gender_icon(gender, "shoes"), icon_state = shoes.icon_state)

		if(shoes.blood_DNA)
			var/image/bloodsies = image("icon" = species.blood_mask, "icon_state" = "shoeblood")
			bloodsies.color = shoes.blood_color
			standing.overlays += bloodsies
		standing.color = shoes.color
		overlays_standing[SHOES_LAYER] = standing
	else
		if(feet_blood_DNA)
			var/image/bloodsies = image("icon" = species.blood_mask, "icon_state" = "shoeblood")
			bloodsies.color = feet_blood_color
			overlays_standing[SHOES_LAYER] = bloodsies

	if(update_icons)   update_icons()


/mob/living/carbon/human/update_inv_s_store(var/update_icons=1)
	if(s_store)
		if(s_store.contained_sprite)
			var/state = ""
			state += "[s_store.item_state][WORN_SSTORE]"

			if(s_store.icon_override)
				overlays_standing[SUIT_STORE_LAYER] = image(icon = s_store.icon_override, icon_state = state)
			else
				overlays_standing[SUIT_STORE_LAYER] = image(icon = s_store.icon, icon_state = state)

		else
			//Determine the state to use
			var/t_state
			if(s_store.item_state_slots && s_store.item_state_slots[slot_s_store_str])
				t_state = s_store.item_state_slots[slot_s_store_str]
			else if(s_store.item_state)
				t_state = s_store.item_state
			else
				t_state = s_store.icon_state

			//Determine the icon to use
			var/t_icon
			if(s_store.item_icons && (slot_s_store_str in s_store.item_icons))
				t_icon = s_store.item_icons[slot_s_store_str]
			else
				t_icon = get_gender_icon(gender, "s_store")

			//Special case here. We will check if the suit store icon contains our desired iconstate
			//If not we will use the mob's back icon instead. This allows reusing back icons for shoulder-slung guns
			var/icon/test = new (t_icon)
			if (!(t_state in icon_states(test)))
				t_icon = get_back_icon(s_store)


			overlays_standing[SUIT_STORE_LAYER]	= image(icon = t_icon, icon_state = t_state)
	else
		overlays_standing[SUIT_STORE_LAYER]	= null

	if(update_icons)   update_icons()


/mob/living/carbon/human/update_inv_head(var/update_icons=1)
	overlays_standing[HEAD_LAYER]	= null
	if(head)
		var/image/standing = null
		//Determine the icon to use
		var/t_icon
		if(head.contained_sprite)
			var/state = ""
			state += "[head.item_state][WORN_HEAD]"

			if(head.icon_override)
				standing = image(icon = head.icon_override, icon_state = state)
			else
				standing = image(icon = head.icon, icon_state = state)
		else if(head.icon_override)
			t_icon = head.icon_override

		else if(head.item_icons && (slot_head_str in head.item_icons))
			t_icon = head.item_icons[slot_head_str]
		else
			t_icon = get_gender_icon(gender, "hat")

		if (!standing)
			//Determine the state to use
			var/t_state = head.icon_state

			//Create the image
			standing = image(icon = t_icon, icon_state = t_state)

		if(head.blood_DNA)
			var/image/bloodsies = image("icon" = species.blood_mask, "icon_state" = "helmetblood")
			bloodsies.color = head.blood_color
			standing.overlays	+= bloodsies

		if(istype(head,/obj/item/clothing/head))
			var/obj/item/clothing/head/hat = head
			var/cache_key = "[hat.light_overlay]_[species.get_bodytype()]"
			if(hat.on && light_overlay_cache[cache_key])
				standing.overlays |= light_overlay_cache[cache_key]

		standing.color = head.color
		overlays_standing[HEAD_LAYER] = standing

	if(update_icons)   update_icons()


/mob/living/carbon/human/update_inv_belt(var/update_icons=1)
	overlays_standing[BELT_LAYER] = null
	if(belt)
		var/t_state = belt.icon_state
		var/t_icon = belt.icon
		if(!t_state)	t_state = belt.item_state
		var/image/standing	= image(icon_state = t_state)

		if(belt.contained_sprite)
			t_state = ""
			t_state += "[belt.item_state][WORN_BELT]"

			if(belt.icon_override)
				t_icon = belt.icon_override

		else if(belt.icon_override)
			t_icon = belt.icon_override

		else
			t_icon = get_gender_icon(gender, "belt")

		standing = image(icon = t_icon, icon_state = t_state)
		standing.color = belt.color

		var/beltlayer = BELT_LAYER
		var/otherlayer = BELT_LAYER_ALT
		if(istype(belt, /obj/item/storage/belt))
			var/obj/item/storage/belt/ubelt = belt
			if(ubelt.show_above_suit)
				beltlayer = BELT_LAYER_ALT
				otherlayer = BELT_LAYER

		overlays_standing[beltlayer] = standing
		overlays_standing[otherlayer] = null

	if(update_icons)   update_icons()


/mob/living/carbon/human/update_inv_wear_suit(var/update_icons=1)

	if( wear_suit && istype(wear_suit, /obj/item/) )
		var/image/standing
		var/t_icon = get_gender_icon(gender, "suit")
		var/suit_state = ""
		if(wear_suit.contained_sprite)
			var/state = ""
			state += "[wear_suit.item_state][WORN_SUIT]"

			if(wear_suit.icon_override)
				t_icon = image(icon = wear_suit.icon_override, icon_state = state)
			else
				t_icon = image(icon = wear_suit.icon, icon_state = state)

			suit_state += wear_suit.icon_state + WORN_SUIT + get_gender_icon_contained(gender)

		else if(wear_suit.icon_override)
			t_icon = wear_suit.icon_override
		else if(wear_suit.item_icons && wear_suit.item_icons[slot_wear_suit_str])
			t_icon = wear_suit.item_icons[slot_wear_suit_str]

		//determine state to use
		if (!suit_state)
			if(wear_suit.item_state_slots && wear_suit.item_state_slots[slot_wear_suit_str])
				suit_state = wear_suit.item_state_slots[slot_wear_suit_str]
			else if(wear_suit.icon_state)
				suit_state = wear_suit.icon_state
			else
				suit_state = wear_suit.item_state

		standing = image(icon = t_icon, icon_state = suit_state)
		standing.color = wear_suit.color

		if( istype(wear_suit, /obj/item/clothing/suit/straight_jacket) ) //TODO: Should be handled elsewhere
			drop_from_inventory(handcuffed)
			drop_l_hand()
			drop_r_hand()

		if(wear_suit.blood_DNA)
			var/obj/item/clothing/suit/S = wear_suit
			var/image/bloodsies = image("icon" = species.blood_mask, "icon_state" = "[S.blood_overlay_type]blood")
			bloodsies.color = wear_suit.blood_color
			standing.overlays	+= bloodsies

		// Accessories - copied from uniform, BOILERPLATE because fuck this system.
		var/obj/item/clothing/suit/suit = wear_suit
		if(istype(suit) && suit.accessories.len)
			for(var/obj/item/clothing/accessory/A in suit.accessories)
				standing.overlays |= A.get_mob_overlay()

		overlays_standing[SUIT_LAYER]	= standing

	else
		overlays_standing[SUIT_LAYER]	= null
		update_inv_shoes(0)

	update_collar(0)

	if(update_icons)   update_icons()


/mob/living/carbon/human/update_inv_pockets(var/update_icons=1)
	return


/mob/living/carbon/human/update_inv_wear_mask(var/update_icons=1)
	overlays_standing[FACEMASK_LAYER] = null
	if(check_draw_mask())

		var/image/standing
		if(wear_mask.contained_sprite)
			var/state = ""
			state += "[wear_mask.item_state][WORN_MASK]"

			if(wear_mask.icon_override)
				standing = image("icon" = wear_mask.icon_override, "icon_state" = state)
			else
				standing = image("icon" = wear_mask.icon, "icon_state" = state)
		else if(wear_mask.icon_override)
			standing = image(icon = wear_mask.icon_override, icon_state = wear_mask.icon_state)

		else
			standing = image(icon = get_gender_icon(gender, "mask"), icon_state = wear_mask.icon_state)
		standing.color = wear_mask.color

		if( !istype(wear_mask, /obj/item/clothing/mask/smokable/cigarette) && wear_mask.blood_DNA )
			var/image/bloodsies = image("icon" = species.blood_mask, "icon_state" = "maskblood")
			bloodsies.color = wear_mask.blood_color
			standing.overlays	+= bloodsies
		overlays_standing[FACEMASK_LAYER]	= standing

	if(update_icons)   update_icons()


//Seperate proc because this is reused for suit storage
/mob/living/carbon/human/proc/get_back_icon(var/obj/item/test = null)
	if(!test && back)
		test = back
	if (test)
		//determine the icon to use
		var/icon/overlay_icon
		var/overlay_state = ""

		if(test.contained_sprite)
			overlay_state += "[test.item_state][WORN_BACK]"

			if(test.icon_override)
				overlay_icon = test.icon_override
			else
				overlay_icon = test.icon
		else if(test.icon_override)
			overlay_icon = test.icon_override
		else if(istype(test, /obj/item/rig))
			var/obj/item/rig/rig = test
			overlay_icon = rig.get_species_icon()

		else if(test.item_icons && (slot_back_str in test.item_icons))
			overlay_icon = test.item_icons[slot_back_str]
		else
			overlay_icon = get_gender_icon(gender, "backpack")
		return overlay_icon

	else return get_gender_icon(gender, "backpack")


/mob/living/carbon/human/update_inv_back(var/update_icons=1)
	overlays_standing[BACK_LAYER] = null

	//determine the icon to use
	var/icon/overlay_icon = get_back_icon()
	var/overlay_state = ""
	if(back && overlay_icon)
		overlay_state = back.item_state
		if(back.contained_sprite)
			overlay_state = "[back.item_state][WORN_BACK]"

			if(back.icon_override)
				overlay_icon = back.icon_override
			else
				overlay_icon = back.icon
		else if(back.icon_override)
			overlay_icon = back.icon_override

		//determine state to use
		if(back.item_state_slots && back.item_state_slots[slot_back_str])
			overlay_state = back.item_state_slots[slot_back_str]
		//apply color
		var/image/standing = image(icon = overlay_icon, icon_state = overlay_state)
		standing.color = back.color

		//Rig module overlays on mob.
		if(istype(back, /obj/item/rig))
			var/obj/item/rig/rig = back//Maybe add if(rig.installed_modules.len) below this since the code for accessories does that far as I know.
			for(var/obj/item/rig_module/module in rig.installed_modules)
				if(module.suit_overlay)
					standing.overlays += image("icon" = 'icons/mob/rig_modules.dmi', "icon_state" = module.suit_overlay)

		//create the image
		overlays_standing[BACK_LAYER] = standing

	if(update_icons)
		update_icons()




/mob/living/carbon/human/update_inv_handcuffed(var/update_icons=1)
	if(handcuffed)
		drop_r_hand()
		drop_l_hand()
		stop_pulling()	//TODO: should be handled elsewhere
		handcuffed.equip_slot = slot_handcuffed

		var/image/standing
		if(handcuffed.icon_override)
			standing = image(icon = handcuffed.icon_override, icon_state = "handcuff1")

		else
			standing = image(icon = 'icons/mob/mob.dmi', icon_state = "handcuff1")
		overlays_standing[HANDCUFF_LAYER] = standing

	else
		overlays_standing[HANDCUFF_LAYER]	= null
	if(update_icons)   update_icons()

/mob/living/carbon/human/update_inv_legcuffed(var/update_icons=1)
	if(legcuffed)

		var/image/standing
		if(legcuffed.icon_override)
			standing = image(icon = legcuffed.icon_override, icon_state = "legcuff1")

		else
			standing = image(icon = 'icons/mob/mob.dmi', icon_state = "legcuff1")
		overlays_standing[LEGCUFF_LAYER] = standing


	else
		overlays_standing[LEGCUFF_LAYER]	= null
	if(update_icons)   update_icons()


/mob/living/carbon/human/update_inv_r_hand(var/update_icons=1)
	overlays_standing[R_HAND_LAYER] = null
	if(r_hand)
		//determine icon state to use
		var/t_state
		if(r_hand.contained_sprite)
			t_state += "[r_hand.item_state][WORN_RHAND]"

			if(r_hand.icon_override)
				overlays_standing[R_HAND_LAYER] = image(icon = r_hand.icon_override, icon_state = t_state)
			else
				overlays_standing[R_HAND_LAYER] = image(icon = r_hand.icon, icon_state = t_state)

		else
			if(r_hand.item_state_slots && r_hand.item_state_slots[slot_r_hand_str])
				t_state = r_hand.item_state_slots[slot_r_hand_str]
			else if(r_hand.item_state)
				t_state = r_hand.item_state
			else
				t_state = r_hand.icon_state

			//determine icon to use
			var/icon/t_icon
			if(r_hand.item_icons && (slot_r_hand_str in r_hand.item_icons))
				t_icon = r_hand.item_icons[slot_r_hand_str]
			else if(r_hand.icon_override)
				t_state += "_r"
				t_icon = r_hand.icon_override
			else
				t_icon = INV_R_HAND_DEF_ICON

			//apply color
			var/image/standing = image(icon = t_icon, icon_state = t_state)
			standing.color = r_hand.color

			overlays_standing[R_HAND_LAYER] = standing

		if (handcuffed) drop_r_hand() //this should be moved out of icon code

	if(update_icons) update_icons()


/mob/living/carbon/human/update_inv_l_hand(var/update_icons=1)
	overlays_standing[L_HAND_LAYER] = null
	if(l_hand)
		//determine icon state to use
		var/t_state
		if(l_hand.contained_sprite)
			t_state += "[l_hand.item_state][WORN_LHAND]"

			if(l_hand.icon_override)
				overlays_standing[L_HAND_LAYER] = image(icon = l_hand.icon_override, icon_state = t_state)
			else
				overlays_standing[L_HAND_LAYER] = image(icon = l_hand.icon, icon_state = t_state)

		else
			if(l_hand.item_state_slots && l_hand.item_state_slots[slot_l_hand_str])
				t_state = l_hand.item_state_slots[slot_l_hand_str]
			else if(l_hand.item_state)
				t_state = l_hand.item_state
			else
				t_state = l_hand.icon_state

			//determine icon to use
			var/icon/t_icon
			if(l_hand.item_icons && (slot_l_hand_str in l_hand.item_icons))
				t_icon = l_hand.item_icons[slot_l_hand_str]
			else if(l_hand.icon_override)
				t_state += "_l"
				t_icon = l_hand.icon_override
			else
				t_icon = INV_L_HAND_DEF_ICON

			//apply color
			var/image/standing = image(icon = t_icon, icon_state = t_state)
			standing.color = l_hand.color

			overlays_standing[L_HAND_LAYER] = standing

		if (handcuffed) drop_l_hand() //This probably should not be here

	if(update_icons) update_icons()

//Adds a collar overlay above the helmet layer if the suit has one
//	Suit needs an identically named sprite in icons/mob/collar.dmi
/mob/living/carbon/human/proc/update_collar(var/update_icons=1)
	var/icon/C = new('icons/mob/collar.dmi')
	var/image/standing = null

	if(wear_suit)
		if(wear_suit.icon_state in C.IconStates())
			standing = image("icon" = C, "icon_state" = "[wear_suit.icon_state]")

	overlays_standing[COLLAR_LAYER]	= standing

	if(update_icons)   update_icons()


/mob/living/carbon/human/update_fire(var/update_icons=1)
	overlays_standing[FIRE_LAYER] = null
	if(on_fire)
		overlays_standing[FIRE_LAYER] = image("icon"='icons/mob/OnFire.dmi', "icon_state"="Standing", "layer"=FIRE_LAYER)

	if(update_icons)   update_icons()

/mob/living/carbon/human/proc/update_block_overlay(var/update_icons=1)
	overlays_standing[BLOCKING_LAYER] = null
	if(blocking)
		overlays_standing[BLOCKING_LAYER] = image("icon"='icons/mob/misc_overlays.dmi', "icon_state"="block", "layer"=BLOCKING_LAYER)

	update_icons()
#warn my sanity is going fucking downwards
/mob/living/carbon/human/proc/update_surgery(var/update_icons=1)
	// overlays_standing[SURGERY_LAYER] = null
	// var/image/total = new
	// for(var/obj/item/limb/E in organs)
	// 	if(E.open)
	// 		var/image/I = image("icon"='icons/mob/surgery.dmi', "icon_state"="[E.name][round(E.open)]", "layer"=-SURGERY_LAYER)
	// 		total.overlays += I
	// overlays_standing[SURGERY_LAYER] = total
	// if(update_icons)   update_icons()

//Drawcheck functions
//These functions check if an item should be drawn, or if its covered up by something else
/mob/living/carbon/human/proc/check_draw_gloves()
	if (!gloves)
		return 0
	else if (gloves.flags_inv & ALWAYSDRAW)
		return 1
	else if (wear_suit && (wear_suit.flags_inv & HIDEGLOVES))
		return 0
	else
		return 1

/mob/living/carbon/human/proc/check_draw_ears()
	if (!l_ear && !r_ear)
		return 0
	else if ((l_ear && (l_ear.flags_inv & ALWAYSDRAW)) || (r_ear && (r_ear.flags_inv & ALWAYSDRAW)))
		return 1
	else if( (head && (head.flags_inv & (HIDEEARS))) || (wear_mask && (wear_mask.flags_inv & (HIDEEARS))))
		return 0
	else
		return 1

/mob/living/carbon/human/proc/check_draw_glasses()
	if (!glasses)
		return 0
	else if (glasses.flags_inv & ALWAYSDRAW)
		return 1
	else if( (head && (head.flags_inv & (HIDEEYES))) || (wear_mask && (wear_mask.flags_inv & (HIDEEYES))))
		return 0
	else
		return 1


/mob/living/carbon/human/proc/check_draw_mask()
	if (!wear_mask)
		return 0
	else if (wear_mask.flags_inv & ALWAYSDRAW)
		return 1
	else if( head && (head.flags_inv & HIDEEYES))
		return 0
	else
		return 1

/mob/living/carbon/human/proc/check_draw_shoes()
	if (!shoes)
		return 0
	else if (shoes.flags_inv & ALWAYSDRAW)
		return 1
	else if(wear_suit && (wear_suit.flags_inv & HIDESHOES))
		return 0
	else
		return 1


/mob/living/carbon/human/proc/check_draw_underclothing()
	if (!w_uniform)
		return 0
	else if (w_uniform.flags_inv & ALWAYSDRAW)
		return 1
	else if(wear_suit && (wear_suit.flags_inv & HIDEJUMPSUIT))
		return 0
	else
		return 1

// Contained sprite defines
#undef WORN_LHAND
#undef WORN_RHAND
#undef WORN_LSTORE
#undef WORN_RSTORE
#undef WORN_SSTORE
#undef WORN_LEAR
#undef WORN_REAR
#undef WORN_HEAD
#undef WORN_UNDER
#undef WORN_SUIT
#undef WORN_GLOVES
#undef WORN_SHOES
#undef WORN_EYES
#undef WORN_BELT
#undef WORN_BACK
#undef WORN_ID
#undef WORN_MASK

//Human Overlays Indexes/////////
#warn commented out for the dev of the thingie
// #undef MUTATIONS_LAYER
// #undef DAMAGE_LAYER
// #undef SURGERY_LAYER
// #undef UNDERWEAR_LAYER
// #undef IMPLANTS_LAYER
// #undef UNIFORM_LAYER
// #undef ID_LAYER
// #undef SHOES_LAYER
// #undef GLOVES_LAYER
// #undef L_EAR_LAYER
// #undef R_EAR_LAYER
// #undef SUIT_LAYER
// #undef TAIL_LAYER
// #undef GLASSES_LAYER
// #undef FACEMASK_LAYER
// #undef BELT_LAYER
// #undef SUIT_STORE_LAYER
// #undef BACK_LAYER
// #undef HAIR_LAYER
// #undef HEAD_LAYER
// #undef COLLAR_LAYER
// #undef HANDCUFF_LAYER
// #undef LEGCUFF_LAYER
// #undef L_HAND_LAYER
// #undef R_HAND_LAYER
// #undef FIRE_LAYER
// #undef TOTAL_LAYERS
