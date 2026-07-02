/obj/item/icon_tester
	name = "Icon testing tablet"
	desc = "Advanced tablet used to create any visual imagery from thicc air"
	icon = 'icons/obj/modular_tablet.dmi'
	icon_state = "tabletsol"
	spawn_blacklisted = TRUE

	var/icon_a
	var/icon_b
	var/icon_state_a
	var/icon_state_b
	var/blend_type

	var/possible_blend_modes = list("ADD", "SUBTRACT", "MULTIPLY", "OVERLAY", "AND", "OR", "UNDERLAY")

/obj/item/icon_tester/attack_self(mob/user)
	nano_ui_interact(user)

/obj/item/icon_tester/nano_ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = NANOUI_FOCUS)
	var/list/data = nano_ui_data()

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "icon_tester.tmpl", name, 450, 500)
		ui.set_initial_data(data)
		ui.open()

/obj/item/icon_tester/nano_ui_data()
	var/list/data = list()
	data["icon_a"] = icon_a
	data["icon_b"] = icon_b
	data["icon_state_a"] = icon_state_a
	data["icon_state_b"] = icon_state_b
	data["mode"] = blend_type

	return data

/obj/item/icon_tester/Topic(href, href_list)
	if(href_list["configure_icon_a"])
		configure_icon("a")
	if(href_list["configure_icon_b"])
		configure_icon("b")
	if(href_list["configure_icon_state_a"])
		configure_icon_state("a")
	if(href_list["configure_icon_state_b"])
		configure_icon_state("b")
	if(href_list["configure_mode"])
		configure_mode()
	if(href_list["spawn_icon"])
		create_icon()

	return TOPIC_HANDLED

/obj/item/icon_tester/proc/configure_icon(icon_var)
	switch(icon_var)
		if("a")
			icon_a = input("Pick icon A:","File") as file
		if("b")
			icon_b = input("Pick icon B:","File") as file

/obj/item/icon_tester/proc/configure_icon_state(icon_var)
	switch(icon_var)
		if("a")
			icon_state_a = input("Write icon state for icon A:","Icon state A") as text
		if("b")
			icon_state_b = input("Write icon state for icon B:","Icon state B") as text

/obj/item/icon_tester/proc/configure_mode()
	var/mode_to_select = input("What kind of mode?","Mode Type") as null|anything in possible_blend_modes

	switch(mode_to_select)
		if("ADD")
			blend_type = ICON_ADD
		if("SUBTRACT")
			blend_type = ICON_SUBTRACT
		if("MULTIPLY")
			blend_type = ICON_MULTIPLY
		if("OVERLAY")
			blend_type = ICON_OVERLAY
		if("AND")
			blend_type = ICON_AND
		if("OR")
			blend_type = ICON_OR
		if("UNDERLAY")
			blend_type = ICON_UNDERLAY

/obj/item/icon_tester/proc/create_icon()
	if(!ismob(loc))
		return

	var/icon/new_icon_a = icon(icon_a, icon_state_a)
	var/icon/new_icon_b = icon(icon_b, icon_state_b)
	new_icon_a.Blend(new_icon_b, blend_type)

	var/obj/effect/effect = new(get_turf(loc))
	effect.icon = new_icon_a
