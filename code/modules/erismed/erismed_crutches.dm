/obj/item/organ/external

/obj/item/organ/external/proc/droplimb() //Fully rework and maybe change name too

/obj/item/implanter

/obj/item/implanter/installer

#warn Return robotic external organs some day

//carrion spooders
/obj/item/implant/carrion_spider
	var/spider_price = 10
	var/owner_mob = "your_mom or someone else who has spider"

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


/obj/item/organ/interval/vital/brain

/obj/item/implanter
	var/obj/item/implant/implant
