/obj/item/organ/external
	var/brute_dam = 0
	var/burn_dam = 0

/obj/item/organ/external/proc/droplimb() //Fully rework and maybe change name too

/obj/item/implanter

/obj/item/implanter/installer

#warn Return robotic external organs some day

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

/datum/reagent/toxin/mutagen/moeball

/proc/adjust_nsa()

/proc/remove_nsa()

/datum/reagents/metabolism

/obj/item/mech_equipment/auto_mender


/obj/item/organ/internal/vital/brain
/obj/item/organ/internal/vital/
/obj/item/organ/internal/
/obj/item/organ/

/obj/item/organ/proc/take_damage(var/number)
	to_chat(src, "[src] tried to take damage for [number] damage :)")

/obj/item/implanter/(var/insert)
	var/obj/item/implant/implant = TRUE


 /obj/item/organ/external/
	var/is_usable = TRUE

/obj/item/device/scanner/health

/datum/design/research/item/exosuit/sleeper
/datum/design/research/item/exosuit/sleeper/upgraded
