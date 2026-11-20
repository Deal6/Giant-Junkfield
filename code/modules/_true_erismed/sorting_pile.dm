//MISSING:
//bullet_act on mob/living
//shield
//shrapnel
//projectile.OnHit()

/mob/living/carbon/human/bullet_act(var/obj/item/projectile/projectile, var/def_zone)

	def_zone = check_zone(def_zone)

	var/obj/item/limb/organ = get_limb(def_zone)

	if(!organ)
		return PROJECTILE_FORCE_MISS //if they don't have the limb in question then the projectile just passes by.

	for(var/damage_type in projectile.damage_types)
		var/damage_amount = projectile.damage_types[damage_type]
		organ.damage(damage_amount, damage_type)



//MISSING:
//is_stump()

/mob/living/carbon/human/proc/get_limb(name, check_usablility = FALSE)
	for(var/obj/item/limb/limb in contents)

		if(!findtext("[limb.type]", name))
			continue

		if(check_usablility && !limb.is_usable())
			continue

		return limb

	return FALSE



/obj/item/limb/proc/damage(damage, damage_type)
	switch(damage_type)
		if("brute")
			brute += damage
		if("burn")
			burn  += damage
		else
			log_and_message_admins("Unexpected damage type [damage_type] delt to limb [name]")
