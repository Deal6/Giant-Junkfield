/*
Contains most of the procs that are called when a mob is attacked by something

bullet_act
explosion_act
meteor_act

*/
#warn bad
/mob/living/carbon/human/bullet_act(var/obj/item/projectile/P, var/def_zone)


/mob/living/carbon/human/hit_impact(damage, dir, hit_zone)

/mob/living/carbon/human/stun_effect_act(var/stun_amount, var/agony_amount, var/def_zone)


// /mob/living/carbon/human/getarmor(var/def_zone, var/type)
// 	return armorval

/mob/living/carbon/human/getarmorablative(var/def_zone, var/type)

//Returns true if the ablative armor successfully took damage
/mob/living/carbon/human/damageablative(var/def_zone, var/damage_taken)

//this proc returns the Siemens coefficient of electrical resistivity for a particular external organ.
/mob/living/carbon/human/proc/get_siemens_coefficient_organ(obj/item/organ/external/def_zone)

//this proc returns the armour value for a particular external organ.
/mob/living/carbon/human/proc/getarmor_organ(var/obj/item/limb/def_zone, var/type)

/mob/living/carbon/human/proc/check_head_coverage()

/mob/living/carbon/human/proc/check_mouth_coverage()

/mob/living/carbon/human/proc/check_shields(var/damage = 0, var/atom/damage_source = null, var/mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")

/mob/living/carbon/human/proc/has_shield()

/mob/living/carbon/human/proc/handle_blocking(var/damage)


/mob/living/carbon/human/proc/grab_redirect_attack(var/mob/living/carbon/human/attacker, var/obj/item/grab/G, var/obj/item/I)


/mob/living/carbon/human/resolve_item_attack(obj/item/I, mob/living/user, var/target_zone)

	// return hit_zone

/mob/living/carbon/human/hit_with_weapon(obj/item/I, mob/living/user, var/effective_force, var/hit_zone)

/mob/living/carbon/human/standard_weapon_hit_effects(obj/item/I, mob/living/user, var/effective_force, var/hit_zone)

/mob/living/carbon/human/proc/attack_joint(var/obj/item/limb/organ, var/obj/item/W)

//this proc handles being hit by a thrown atom
/mob/living/carbon/human/hitby(atom/movable/AM as mob|obj,var/speed = THROWFORCE_SPEED_DIVISOR)

/mob/living/carbon/human/embed(var/obj/O, var/def_zone)



/mob/living/carbon/human/proc/bloody_hands(var/mob/living/source, var/amount = 2)
	if (gloves)
		gloves.add_blood(source)
		gloves:transfer_blood = amount
		gloves:bloody_hands_mob = source
	else
		add_blood(source)
		bloody_hands = amount
		bloody_hands_mob = source
	update_inv_gloves()		//updates on-mob overlays for bloody hands and/or bloody gloves

/mob/living/carbon/human/proc/bloody_body(var/mob/living/source)
	if(wear_suit)
		wear_suit.add_blood(source)
		update_inv_wear_suit(0)
	if(w_uniform)
		w_uniform.add_blood(source)
		update_inv_w_uniform(0)

/mob/living/carbon/human/proc/handle_suit_punctures(var/damtype, var/damage, var/def_zone)

	// Tox and oxy don't matter to suits.
	if(damtype != BURN && damtype != BRUTE) return

	// The rig might soak this hit, if we're wearing one.
	if(back && istype(back,/obj/item/rig))
		var/obj/item/rig/rig = back
		rig.take_hit(damage)

	// We may also be taking a suit breach.
	if(!wear_suit) return
	if(!istype(wear_suit,/obj/item/clothing/suit/space)) return
	var/obj/item/clothing/suit/space/SS = wear_suit
	var/penetrated_dam = max(0,(damage - SS.breach_threshold))
	if(prob(20 + (penetrated_dam * SS.resilience))) SS.create_breaches(damtype, penetrated_dam) // changed into a probability calculation based on the degree of penetration by Plasmatik. you can tune resilience to drastically change breaching chances.
																			// at maximum penetration, breaches are always created, at 1 penetration, they have a 20% chance to form

/mob/living/carbon/human/reagent_permeability()
	var/perm = 0

	var/list/perm_by_part = list(
		"head" = THERMAL_PROTECTION_HEAD,
		"upper_torso" = THERMAL_PROTECTION_UPPER_TORSO,
		"lower_torso" = THERMAL_PROTECTION_LOWER_TORSO,
		"legs" = THERMAL_PROTECTION_LEG_LEFT + THERMAL_PROTECTION_LEG_RIGHT,
		"arms" = THERMAL_PROTECTION_ARM_LEFT + THERMAL_PROTECTION_ARM_RIGHT,
		)

	for(var/obj/item/clothing/C in src.get_equipped_items())
		if(C.permeability_coefficient == 1 || !C.body_parts_covered)
			continue
		if(C.body_parts_covered & HEAD)
			perm_by_part["head"] *= C.permeability_coefficient
		if(C.body_parts_covered & UPPER_TORSO)
			perm_by_part["upper_torso"] *= C.permeability_coefficient
		if(C.body_parts_covered & LOWER_TORSO)
			perm_by_part["lower_torso"] *= C.permeability_coefficient
		if(C.body_parts_covered & LEGS)
			perm_by_part["legs"] *= C.permeability_coefficient
		if(C.body_parts_covered & ARMS)
			perm_by_part["arms"] *= C.permeability_coefficient

	for(var/part in perm_by_part)
		perm += perm_by_part[part]

	return perm
