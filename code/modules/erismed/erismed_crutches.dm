// # ITEMS
/obj/item/electronics/circuitboard/reagentgrinder

/obj/item/reagent_containers/syringe
	var/mode = 0

// # FUCKING ELSE
/mob/living/carbon/proc/handle_chemical_smoke(datum/gas_mixture/environment)
/obj/item/device/proc/transfer_identity(var/mob/living/carbon/H)

/obj/item/organ/external
	var/brute_dam = 0
	var/burn_dam = 0
	var/status

/obj/item/organ/external/proc/droplimb() //Fully rework and maybe change name too


/obj/item/organ/proc/is_usable()

/obj/proc/affect_grab(var/mob/user, var/mob/target, var/state)

/obj/item/grab
	var/mob/affecting
	var/state

/obj/item/implanter

/obj/item/implanter/installer




//carrion spooders
/obj/item/implant/carrion_spider
	var/spider_price = 10
	var/mob/owner_mob = "your_mom or someone else who has spider"

/obj/item/implant/carrion_spider/proc/die()
	to_chat(src, "prank ultrakill")

/obj/item/stack/medical/advanced/bruise_pack
/obj/item/stack/medical/bruise_pack

/obj/item/stack/medical/splint

/obj/item/stack/medical/advanced/ointment
/obj/item/stack/medical/ointment

/datum/metabolism_effects



/proc/adjust_nsa()

/proc/remove_nsa()



/obj/item/mech_equipment/auto_mender


/obj/item/organ/internal/vital/brain
/obj/item/organ/internal/vital/
/obj/item/organ/internal/
/obj/item/organ/

/obj/item/implanter/(var/insert)
	var/obj/item/implant/implant = TRUE



/obj/item/device/scanner/health

/datum/design/research/item/exosuit/sleeper
/datum/design/research/item/exosuit/sleeper/upgraded
/

/obj/item/organ/proc/removed()

/datum/reagents
	var/list/datum/reagent/reagent_list = list()
	var/total_volume = 0
	var/maximum_volume = 100
	var/chem_temp = T20C
	var/atom/my_atom




/atom/proc/create_reagents(max_vol)
	reagents = new /datum/reagents(max_vol, src)


// # REAGENT(S)
/datum/reagents/proc/has_reagent(id, amount = 0)	//untoched
	for(var/datum/reagent/current in reagent_list)
		if(current.id == id)
			if(current.volume >= amount)
				return 1
			else
				return 0
	return 0
/datum/reagents/proc/log_list()
/datum/reagents/proc/expose_temperature(temperature, coeff=0.02)
/datum/reagents/proc/trans_to_holder(datum/reagents/target, amount = 1, multiplier = 1, copy = 0)
/datum/reagents/proc/trans_to(datum/target, amount = 1, multiplier = 1, copy = 0, ignore_isinjectable = FALSE)
/datum/reagents/proc/trans_to_mob(mob/target, amount = 1, type = CHEM_BLOOD, multiplier = 1, copy = 0) // Transfer after checking into which holder...
/datum/reagents/proc/trans_to_turf(turf/target, amount = 1, multiplier = 1, copy = 0) // Turfs don't have any reagents (at least, for now). Just touch it.
/datum/reagents/proc/trans_to_obj(obj/target, amount = 1, multiplier = 1, copy = 0) // Objects may or may not; if they do, it's probably a beaker or something and we need to transfer properly; otherwise, just touch.
/datum/reagents/proc/remove_reagent(id, amount, safety = FALSE)
/datum/reagents/proc/splash(atom/target, amount = 1, multiplier = 1, copy = 0, min_spill=0, max_spill=60)
/datum/reagents/proc/update_total()
/datum/reagents/proc/add_reagent(id, amount, data = null, safety = 0)
/datum/reagents/proc/remove_any(amount = 1)
/datum/reagents/proc/clear_reagents()
/datum/reagents/proc/get_reagent_amount(id)

/datum/reagents/proc/get_free_space() // Returns free space.

// # REAGENT
/proc/get_reagent_name_by_id(id)
/proc/get_reagent_type_by_id(id)
/proc/is_reagent_with_id_exist(id)
/datum/reagent
	var/name = ""
	var/id = "reagent"
	var/description = "A non-descript chemical."
	var/taste_description = "old rotten bandaids"
	var/taste_mult = 1 //how this taste compares to others. Higher values means it is more noticable
	var/datum/reagents/holder
	var/reagent_state = SOLID
	var/list/data
	var/volume = 0
	var/metabolism = REM // This would be 0.2 normally
	var/ingest_met = 0
	var/touch_met = 0
	var/dose = 0
	var/max_dose = 0
	var/overdose = 0
	var/addiction_threshold = 0
	var/addiction_chance = 0
	var/withdrawal_threshold = 0
	var/withdrawal_rate = REM * 2
	var/scannable = 0 // Shows up on health analyzers.
	var/affects_dead = 0
	var/glass_unique_appearance = FALSE
	var/glass_icon_state
	var/glass_name
	var/glass_desc
	var/glass_center_of_mass
	var/color = "#000000"
	var/color_weight = 1
	var/sanity_gain = 0
	var/list/taste_tag = list()
	var/sanity_gain_ingest = 0

	var/chilling_point
	var/chilling_message = "crackles and freezes!"
	var/chilling_sound = 'sound/effects/bubbles.ogg'
	var/list/chilling_products

	var/heating_point
	var/heating_message = "begins to boil!"
	var/heating_sound = 'sound/effects/bubbles.ogg'
	var/list/heating_products

	var/constant_metabolism = FALSE	// if metabolism factor should not change with volume or blood circulation

	var/nerve_system_accumulations = 5 // Nerve system accumulations

	// Catalog stuff
	var/appear_in_default_catalog = TRUE

/datum/reagent/toxin/mutagen/moeball

//blatteding only??
/datum/reagent/proc/on_mob_add(mob/living/L)

	// return maximum_volume - total_volume


/datum/reagents/metabolism

	// get_free_space() // Returns free space.
	// return maximum_volume - total_volume
