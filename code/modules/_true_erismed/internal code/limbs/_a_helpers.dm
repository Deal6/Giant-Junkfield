
/proc/APPLY_MASK_A_TO_B(var/icon/A, var/stateA , var/icon/B, var/stateB, var/image/return_image)
	if(!return_image)	// if return_image isn't set... then we are working with human sprites!
		return_image = image('icons/mob/human.dmi', icon_state = "blank")
	A = icon(A, stateA)
	B = icon(B, stateB)
	A.Blend(B, ICON_MULTIPLY)
	return_image.overlays += A
	return return_image

/* APPLY_MASK_A_TO_B()




*/
