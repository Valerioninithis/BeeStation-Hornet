/datum/orbital_map_tgui/ui_state(mob/user)
	return GLOB.observer_state

/datum/orbital_map_tgui/Destroy(force, ...)
	. = ..()
	SSorbits.open_orbital_maps -= SStgui.get_all_open_uis(src)

/datum/orbital_map_tgui/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OrbitalMap")
		ui.open()
	//Do not auto update, handled by orbits subsystem.
	SSorbits.open_orbital_maps |= ui
	ui.set_autoupdate(FALSE)

/datum/orbital_map_tgui/ui_close(mob/user, datum/tgui/tgui)
	SSorbits.open_orbital_maps -= tgui

/datum/orbital_map_tgui/ui_data(mob/user)
	var/list/data = list()
	data["update_index"] = SSorbits.times_fired
	data["map_objects"] = list()
	for(var/datum/orbital_object/object in SSorbits.orbital_map.bodies)
		data["map_objects"] += list(list(
			"name" = object.name,
			"position_x" = object.position.x,
			"position_y" = object.position.y,
			"velocity_x" = object.velocity.x,
			"velocity_y" = object.velocity.y,
			"radius" = object.radius,
			"gravity_range" = object.relevant_gravity_range
		))
	return data
