extends Node


@onready var play_sound_efx: bool = true
@onready var play_music: bool = true

func set_sound_efx(new_value):
	play_sound_efx = new_value
	
func set_music(new_value):
	play_music = new_value
