extends Control


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

func _on_sound_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		Audio.set_sound_efx(false)
	else:
		Audio.set_sound_efx(true)

func _on_muic_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		Audio.set_music(false)
	else:
		Audio.set_music(true)
